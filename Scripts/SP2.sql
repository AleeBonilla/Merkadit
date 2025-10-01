USE Merkadit;
DROP PROCEDURE IF EXISTS settleCommerce;

DELIMITER //

CREATE PROCEDURE settleCommerce(
    IN p_local VARCHAR(45),
    IN p_comercio VARCHAR(50),
    IN p_month INT
)
settle_commerce: BEGIN
	DECLARE v_paymentMethod INT DEFAULT 3;
	DECLARE v_transactionType INT DEFAULT 4;
    DECLARE v_spacesCount INT;
    DECLARE v_payments INT;
    DECLARE v_total FLOAT DEFAULT 0.0;
	DECLARE v_month INT;
    
    IF p_month is NULL THEN
		SET v_month = MONTH(NOW());
	ELSE
		SET v_month = p_month;
    END IF;
    
    -- SET @comercio = 'Librería Alfa';
	-- SET @local = 'Mercado 99 SUC1';
    
	-- validar que el comercio y local existan y tengan un contrato establecido
    SET v_spacesCount = (select COUNT(*) from SpacesPerContract as SPC
	inner join contracts C on C.contractId = SPC.contractId
    inner join Business B on B.businessId = C.tenantBusinessId
    inner join Spaces S on S.SpaceID = SPC.SpaceId
    inner join Markets M on M.MarketId = S.MarketId
    where
        B.name =  p_comercio AND
        M.name = p_local
	);
        
    If v_spacesCount <= 0 THEN
		SIGNAL SQLSTATE '01000' -- Standard SQLSTATE for a general warning
			SET MESSAGE_TEXT = "No se realizó el cobro ya que no hay un contrato entre el comercio y el local proveidos";
		SELECT "Warning" as Status, "No se realizó el cobro ya que no hay un contrato entre el comercio y el local proveidos" as Description, v_spacesCount as count;
		Leave settle_commerce;
	End If;
    
	-- Chequear si el monto ya se pagó este mes
	SET v_payments = (select COUNT(*) from transactions as T
    inner join Business B on B.businessId = T.BusinessId
    inner join contracts C on C.contractId = T.contractId
    inner join SpacesPerContract SPC on SPC.contractId = T.contractId
    inner join Spaces S on S.SpaceID = SPC.SpaceId
    inner join Markets M on M.MarketId = S.MarketId
    where
		T.transactionType = v_transactionType AND
        B.name = p_comercio AND
        M.name = p_local AND
        MONTH(T.createdAt) = v_month
    );
	if v_payments > 0 THEN
		SIGNAL SQLSTATE '01000' -- Standard SQLSTATE for a general warning
			SET MESSAGE_TEXT = "El cobro ya se había realizado anteriormente";
		SELECT "Warning" as Status, "El cobro ya se había realizado anteriormente" as Description;
		Leave settle_commerce;
    end if;
    
	-- Encontrar el monto total de deuda
	SET v_total = (
	SELECT SUM(SB.total * (C.feePercentage / 100)) AS v_total
	FROM SaleBills AS SB
	INNER JOIN Contracts AS C ON SB.contractId = C.contractId
	inner join SpacesPerContract SP on SP.contractid = C.contractId
	inner join Spaces S on S.spaceID = SP.SpaceId
	inner join Markets M on S.marketId = M.MarketId
	inner join Business B on C.tenantBusinessId = B.BusinessId
	WHERE
		B.name = p_comercio AND
        M.name = p_local AND
		MONTH(SB.createdAt) = v_month
	);
	
    -- si se debe algo realizar la transacción
    if v_total <= 0 OR v_total IS NULL THEN
		SIGNAL SQLSTATE '01000' -- Standard SQLSTATE for a general warning
			SET MESSAGE_TEXT = "No se realizó el cobro ya que el monto de la transacción sería 0";
		SELECT "Warning" as Status, "No se realizó el cobro ya que el monto de la transacción sería 0" as Description;
		leave settle_commerce;
    end if;
    
	insert into Transactions (amount, createdAt, status, checksum, transactionType, businessId, contractId, currencyId, paymentMethodId)
	select 
		v_total amount, 
		now() createdAt, 
		'COMPLETED' status,
		SHA2(CONCAT(now(), '-', v_total), 256) checkSum,
		v_transactionType transactionType,
		B.BusinessId businessId,
        C.contractId contractId,
		C.currencyId currencyId, 
		v_paymentMethod paymentMethod
	from Markets as M
	inner join Spaces S on M.MarketId = S.MarketId
	inner join SpacesPerContract SP on SP.spaceId = S.SpaceId
	INNER JOIN Contracts AS C ON C.contractId = SP.contractId
	inner join Business B on C.tenantBusinessId = B.BusinessId
	where
		B.name = p_comercio AND
		M.name = p_local;
        
	SELECT "Success" as Status, "Cobro procesado correctamente" as Description;
END//
DELIMITER ;

SET @comercio = 'Librería Alfa';
SET @local = 'Mercado 99 SUC1';
select COUNT(*) from transactions as T
    inner join Business B on B.businessId = T.BusinessId
    inner join contracts C on C.contractId = T.contractId
    inner join SpacesPerContract SPC on SPC.contractId = T.contractId
    inner join Spaces S on S.SpaceID = SPC.SpaceId
    inner join Markets M on M.MarketId = S.MarketId
    where
		T.transactionType = 4 AND
        B.name = @comercio AND
        M.name = @local AND
        MONTH(T.createdAt) = 9;

select * from transactions
order by createdAt Desc;

-- delete from transactions
-- where transactionId = 247

-- SET @comercio = 'Librería Alfa';
-- SET @local = 'Mercado 99 SUC1';
call settleCommerce('Mercado 99 SUC1', 'Librería Alfa', 9);
