USE Merkadit_DB;

-- Stored procedure #1

DROP PROCEDURE IF EXISTS registerSale;

DELIMITER //

CREATE PROCEDURE registerSale(
    IN p_nombre_producto VARCHAR(60),
    IN p_nombre_tienda VARCHAR(50),
    IN p_cantidad_vendida INT,
    IN p_monto_pagado FLOAT,
    IN p_metodo_pago VARCHAR(30),
    IN p_confirmaciones_pago JSON,
    IN p_numeros_referencia BIGINT,
    IN p_cedula_cliente VARCHAR(20),
    IN p_nombre_cliente VARCHAR(60),
    IN p_descuentos_aplicados FLOAT,
    IN p_user_id INT,
    IN p_computer_name VARCHAR(100)
)
BEGIN
    DECLARE v_product_id INT;
    DECLARE v_business_id INT;
    DECLARE v_inventory_id INT;
    DECLARE v_contract_id INT;
    DECLARE v_product_price FLOAT;
    DECLARE v_current_quantity INT;
    DECLARE v_transaction_id INT;
    DECLARE v_sale_bill_id INT;
    DECLARE v_checksum VARCHAR(64);
    DECLARE v_tax_amount FLOAT;
    DECLARE v_subtotal FLOAT;
    DECLARE v_total_calculado FLOAT;
    DECLARE v_payment_method_id INT;
    DECLARE v_transaction_started BOOLEAN DEFAULT FALSE;
    DECLARE v_numero_factura BIGINT;
    DECLARE v_rows_affected INT;
    
    -- Handler simplificado
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        IF v_transaction_started THEN
            ROLLBACK;
        END IF;
        RESIGNAL;
    END;

    -- Validaciones
    IF p_cantidad_vendida IS NULL OR p_cantidad_vendida <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad vendida debe ser mayor a 0';
    END IF;

    IF p_monto_pagado IS NULL OR p_monto_pagado <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto pagado debe ser mayor a 0';
    END IF;

    IF p_descuentos_aplicados IS NULL THEN
        SET p_descuentos_aplicados = 0;
    END IF;
    
    IF p_descuentos_aplicados < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los descuentos no pueden ser negativos';
    END IF;

    IF p_user_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Debe especificar el usuario';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Users WHERE userId = p_user_id AND userStatus = 'ACTIVE') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario inválido o inactivo';
    END IF;

    IF p_nombre_producto IS NULL OR TRIM(p_nombre_producto) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Debe especificar el producto';
    END IF;

    IF p_nombre_tienda IS NULL OR TRIM(p_nombre_tienda) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Debe especificar la tienda';
    END IF;

    -- Buscar método de pago
    SELECT paymentMethodId INTO v_payment_method_id 
    FROM PaymentMethods 
    WHERE UPPER(TRIM(name)) = UPPER(TRIM(p_metodo_pago))
    LIMIT 1;

    IF v_payment_method_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Método de pago inválido';
    END IF;

    -- Buscar producto
    SELECT 
        bp.businessProductId,
        bp.businessId,
        bp.price,
        i.InventoryId,
        i.quantity,
        i.contractId
    INTO 
        v_product_id,
        v_business_id,
        v_product_price,
        v_inventory_id,
        v_current_quantity,
        v_contract_id
    FROM BusinessProducts bp
    INNER JOIN Business b ON bp.businessId = b.businessId
    INNER JOIN Inventory i ON bp.businessProductId = i.businessProductId
    WHERE UPPER(TRIM(bp.name)) = UPPER(TRIM(p_nombre_producto))
      AND UPPER(TRIM(b.name)) = UPPER(TRIM(p_nombre_tienda))
      AND bp.status = 'ACTIVE'
      AND bp.enabled = 1
      AND b.status = 'ACTIVE'
      AND b.enabled = 1
      AND i.status = 'ACTIVE'
      AND i.enabled = 1
    LIMIT 1;

    IF v_product_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no encontrado o inactivo';
    END IF;

    IF v_current_quantity < p_cantidad_vendida THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;

    IF v_contract_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se encontró contrato';
    END IF;

    -- Calcular totales
    SET v_subtotal = v_product_price * p_cantidad_vendida;
    SET v_tax_amount = v_subtotal * 0.13;
    SET v_total_calculado = v_subtotal + v_tax_amount - p_descuentos_aplicados;

    IF p_monto_pagado < v_total_calculado THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Monto insuficiente';
    END IF;

    -- Generar número de factura
    SELECT COALESCE(MAX(BillNumber), 10000) + 1 INTO v_numero_factura FROM SaleBills;

    -- Transacción
    START TRANSACTION;
    SET v_transaction_started = TRUE;

    INSERT INTO Transactions (
        amount, createdAt, status, checksum, transactionType, 
        businessId, contractId, currencyId, paymentMethodId
    ) VALUES (
        v_total_calculado, NOW(), 'COMPLETED',
        SHA2(CONCAT(v_business_id, '-', v_product_id, '-', NOW()), 256),
        1, v_business_id, v_contract_id, 1, v_payment_method_id
    );
    SET v_transaction_id = LAST_INSERT_ID();

    INSERT INTO SaleBills (
        BillNumber, referenceNumber, discount, taxAmount, taxApplied, total,
        paymentConfirmation, buyerName, buyerId, createdAt, checksum, 
        transactionId, contractId, paymentMethodId
    ) VALUES (
        v_numero_factura, p_numeros_referencia, p_descuentos_aplicados,
        v_tax_amount, 0.13, v_total_calculado, p_confirmaciones_pago,
        p_nombre_cliente, p_cedula_cliente, NOW(),
        SHA2(CONCAT(v_numero_factura, '-', v_transaction_id, '-', NOW()), 256),
        v_transaction_id, v_contract_id, v_payment_method_id
    );
    SET v_sale_bill_id = LAST_INSERT_ID();

    INSERT INTO BillDetail (
        quantity, unitPrice, subtotal, checksum, createdAt,
        saleBillId, businessSaleItemId, businessProductId
    ) VALUES (
        p_cantidad_vendida, v_product_price, v_subtotal,
        SHA2(CONCAT(v_sale_bill_id, '-', v_product_id, '-', NOW()), 256),
        NOW(), v_sale_bill_id, NULL, v_product_id
    );

    UPDATE Inventory 
    SET quantity = quantity - p_cantidad_vendida, updatedAt = NOW()
    WHERE InventoryId = v_inventory_id AND quantity >= p_cantidad_vendida;
    
    SET v_rows_affected = ROW_COUNT();
    IF v_rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pudo actualizar inventario';
    END IF;

    INSERT INTO InventoryLogs (
        changeQuantity, changeType, InventoryLogTypeId, InventoryId, checksum, createdAt
    ) VALUES (
        -p_cantidad_vendida, 'SALE', 1, v_inventory_id,
        SHA2(CONCAT(v_inventory_id, '-', NOW()), 256), NOW()
    );
    
    -- Antes del COMMIT, agregar:
INSERT INTO SystemLogs (
    description, postTime, checksum, 
    systemLogTypeId, moduleId, userId, logSourceId, logLevelId
) VALUES (
    JSON_OBJECT(
        'operacion', 'registerSale',
        'factura', v_numero_factura,
        'transaccion', v_transaction_id,
        'producto', p_nombre_producto,
        'tienda', p_nombre_tienda,
        'cantidad', p_cantidad_vendida,
        'total', v_total_calculado,
        'cliente', p_nombre_cliente,
        'cedula', p_cedula_cliente,
        'computadora', p_computer_name,  -- ✅ Ahora se registra
        'metodo_pago', p_metodo_pago,
        'usuario_id', p_user_id
    ),
    NOW(),
    SHA2(CONCAT('SUCCESS-', v_transaction_id, '-', p_user_id, '-', NOW()), 256),
    2, 2, p_user_id, 1, 1
);

    COMMIT;
    SET v_transaction_started = FALSE;

    SELECT 
        'SUCCESS' AS status,
        v_numero_factura AS numero_factura,
        v_transaction_id AS transaccion_id,
        v_total_calculado AS total,
        (p_monto_pagado - v_total_calculado) AS cambio,
        (v_current_quantity - p_cantidad_vendida) AS stock_restante;

END//

DELIMITER ;

CALL registerSale(
    'Set de Lego City',
    'Juguetería Feliz',
    2,
    56500.0,      
    'EFECTIVO',
    '{"confirmado": true}',
    123456789,
    '304560789',
    'Juan Pérez',
    0.0,
    100,
    'CAJA-01'
);
