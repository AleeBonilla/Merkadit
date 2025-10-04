
-- INSERCIÓN DE DATOS

Use Merkadit_DB;

/*

DELIMITER $$

CREATE PROCEDURE GenerateFourMonthsSales()
BEGIN
    -- Variable para contar registros insertados
    DECLARE total_records INT;
    -- Contador para el bucle WHILE
    DECLARE i INT DEFAULT 1;

    -- Empezamos una transacción para asegurar consistencia
    START TRANSACTION;

    -- -----------------------------------------------------------------------
    -- 1. CREAR TABLA TEMPORAL (plan de ventas a simular)
    -- -----------------------------------------------------------------------
    -- Aquí guardamos las "ventas planificadas" antes de insertarlas en las tablas reales.
    -- La columna transaction_id se llenará más adelante cuando tengamos el ID real.
    CREATE TEMPORARY TABLE temp_sales_plan (
        seq_num INT AUTO_INCREMENT PRIMARY KEY, -- número secuencial de la venta simulada
        product_id INT,                         -- producto vendido
        business_id INT,                        -- negocio al que pertenece el producto
        price DECIMAL(15,2),                    -- precio unitario
        inventory_id INT,                       -- inventario afectado
        contract_id INT,                        -- contrato según el negocio
        sale_qty INT,                           -- cantidad vendida
        sale_date DATE,                         -- fecha simulada de venta
        sale_time TIME,                         -- hora simulada de venta
        payment_method INT,                     -- método de pago (aleatorio)
        checksum_tx VARCHAR(64),                -- hash único para evitar duplicados
        transaction_id INT NULL                 -- se actualizará luego con el ID real
    );

    -- -----------------------------------------------------------------------
    -- 2. GENERAR 240 VENTAS SIMULADAS
    -- -----------------------------------------------------------------------
    -- Cada iteración crea UNA venta, tomando un producto aleatorio
    -- de la tabla BusinessProducts + Inventory.
    -- Se asegura de no vender más de lo que hay en inventario.
    WHILE i <= 240 DO
        INSERT INTO temp_sales_plan (product_id, business_id, price, inventory_id, contract_id, sale_qty, sale_date, sale_time, payment_method, checksum_tx)
        SELECT 
            bp.businessProductId, -- producto
            bp.businessId,        -- negocio dueño del producto
            bp.price,             -- precio
            inv.InventoryId,      -- inventario afectado
            CASE                  -- contrato depende del negocio
                WHEN bp.businessId = 11 THEN 5
                WHEN bp.businessId = 14 THEN 7
                ELSE 8
            END,
            CASE                  -- cantidad vendida depende del negocio y stock
                WHEN bp.businessId = 11 THEN LEAST(1 + FLOOR(RAND() * 3), inv.quantity)
                ELSE LEAST(1 + FLOOR(RAND() * 10), inv.quantity)
            END,
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 120) DAY), -- fecha aleatoria últimos 4 meses
            MAKETIME(FLOOR(RAND() * 23), FLOOR(RAND() * 59), FLOOR(RAND() * 59)), -- hora aleatoria
            1 + FLOOR(RAND() * 3), -- método de pago aleatorio entre 1–3
            MD5(CONCAT(bp.businessProductId, '-', bp.businessId, '-', inv.InventoryId, '-', i, '-', RAND())) -- hash único
        FROM BusinessProducts bp
        JOIN Inventory inv ON bp.businessProductId = inv.businessProductId
        WHERE inv.quantity > 0
        ORDER BY RAND() -- escoger producto al azar
        LIMIT 1;
        
        -- avanzar el contador
        SET i = i + 1;
    END WHILE;

    -- Guardar cuántas ventas se generaron (deberían ser 240)
    SET total_records = (SELECT COUNT(*) FROM temp_sales_plan);

    -- -----------------------------------------------------------------------
    -- 3. INSERTAR EN TRANSACCIONES (Transactions)
    -- -----------------------------------------------------------------------
    -- Aquí se registran las transacciones financieras
    -- Una transacción = el pago de la venta simulada.
    INSERT INTO Transactions (amount, createdAt, status, checksum, transactionType, businessId, contractId, currencyId, paymentMethodId)
    SELECT 
        price * sale_qty,                   -- monto = precio * cantidad
        CONCAT(sale_date, ' ', sale_time),  -- fecha y hora
        'COMPLETED',                        -- siempre completada
        checksum_tx,                        -- hash único
        1,                                  -- transactionType (ejemplo: 1 = venta)
        business_id,                        -- negocio dueño de la venta
        contract_id,                        -- contrato definido arriba
        1,                                  -- currencyId (ejemplo: 1 = CRC/USD según modelo)
        payment_method                      -- forma de pago
    FROM temp_sales_plan;

    -- -----------------------------------------------------------------------
    -- 4. ACTUALIZAR TABLA TEMPORAL CON EL transactionId REAL
    -- -----------------------------------------------------------------------
    -- Ahora que ya insertamos en Transactions, enlazamos cada venta simulada
    -- con su verdadero transactionId usando el checksum como "llave puente".
    UPDATE temp_sales_plan t
    JOIN Transactions tr ON tr.checksum = t.checksum_tx
    SET t.transaction_id = tr.transactionId;

    -- -----------------------------------------------------------------------
    -- 5. INSERTAR FACTURAS (SaleBills)
    -- -----------------------------------------------------------------------
    -- Aquí se generan las facturas de cada venta.
    -- Cada factura apunta a su transacción correspondiente.
    INSERT INTO SaleBills (BillNumber, referenceNumber, discount, taxAmount, taxApplied, total, 
                          paymentConfirmation, buyerName, buyerId, createdAt, checksum, transactionId, contractId, paymentMethodId)
    SELECT 
        seq_num,                                           -- número de factura = correlativo simulado
        1000 + seq_num,                                    -- referencia única
        0,                                                 -- sin descuento
        (price * sale_qty) * 0.13,                         -- impuesto calculado (13%)
        0.13,                                              -- tasa aplicada
        price * sale_qty,                                  -- total factura
        CONCAT('{"confirmed": true, "ref": "', seq_num, '"}'), -- JSON simulado
        CONCAT('Cliente_', seq_num),                       -- nombre comprador simulado
        NULL,                                              -- buyerId no definido
        CONCAT(sale_date, ' ', sale_time),                 -- fecha factura
        MD5(CONCAT(seq_num, price * sale_qty)),            -- checksum único
        transaction_id,                                    -- relación con Transactions
        contract_id,                                       -- contrato usado
        payment_method                                     -- método de pago
    FROM temp_sales_plan;

    -- -----------------------------------------------------------------------
    -- 6. INSERTAR DETALLES DE FACTURA (BillDetail)
    -- -----------------------------------------------------------------------
    -- Cada factura puede tener varios detalles (aquí 1 producto por factura).
    INSERT INTO BillDetail (quantity, unitPrice, subtotal, checkSum, createdAt, saleBillId, businessSaleItemId, businessProductId)
    SELECT 
        sale_qty,                          -- cantidad vendida
        price,                             -- precio unitario
        price * sale_qty,                  -- subtotal
        2000 + seq_num,                    -- checksum ficticio
        CONCAT(sale_date, ' ', sale_time), -- fecha
        seq_num,                           -- apunta a la factura creada arriba
        NULL,                              -- businessSaleItemId no usado aquí
        product_id                         -- producto vendido
    FROM temp_sales_plan;

    -- -----------------------------------------------------------------------
    -- 7. INSERTAR LOGS DE INVENTARIO (InventoryLogs)
    -- -----------------------------------------------------------------------
    -- Se registra la salida de inventario por la venta.
    INSERT INTO InventoryLogs (changeQuantity, changeType, InventoryLogTypeId, InventoryId, checksum, createdAt)
    SELECT 
        -sale_qty,                                      -- se descuenta cantidad vendida
        'SALE',                                         -- tipo de cambio = venta
        1,                                              -- tipo log (ej: 1 = movimiento de venta)
        inventory_id,                                   -- inventario afectado
        MD5(CONCAT(inventory_id, sale_qty, sale_date)), -- checksum único
        CONCAT(sale_date, '  ', sale_time)               -- fecha del movimiento
    FROM temp_sales_plan;

    -- -----------------------------------------------------------------------
    -- 8. ACTUALIZAR INVENTARIO
    -- -----------------------------------------------------------------------
    -- Ahora sí se descuenta del inventario real la cantidad vendida acumulada.
    UPDATE Inventory inv
    JOIN (
        SELECT product_id, SUM(sale_qty) as total_vendido
        FROM temp_sales_plan
        GROUP BY product_id
    ) ventas ON inv.businessProductId = ventas.product_id
    SET inv.quantity = GREATEST(inv.quantity - ventas.total_vendido, 0), -- nunca baja de 0
        inv.updatedAt = NOW();

    -- -----------------------------------------------------------------------
    -- 9. LIMPIAR TABLA TEMPORAL
    -- -----------------------------------------------------------------------
    DROP TEMPORARY TABLE temp_sales_plan;

    -- Confirmamos todo
    COMMIT;

    -- -----------------------------------------------------------------------
    -- 10. MENSAJE FINAL
    -- -----------------------------------------------------------------------
    SELECT CONCAT('Ventas generadas: ', total_records) as Resultado;
END$$

DELIMITER ;

-- 2. CONFIGURAR DATOS BASE
INSERT IGNORE INTO ProductCategories (productCategoryId, productCategoryName) VALUES
(1, 'Electrónicos'), (2, 'Bebidas'), (3, 'Papelería');

INSERT IGNORE INTO UnitMeasures (unitMeasureId, name, code) VALUES
(1, 'Unidad', 'UND'), (2, 'Litros', 'LTS'), (3, 'Kilogramos', 'KGS');

INSERT IGNORE INTO TransactionTypes (transactionType, name) VALUES
(1, 'VENTA'), (2, 'COMPRA'), (3, 'GASTO');

INSERT IGNORE INTO PaymentMethods (paymentMethodId, name) VALUES
(1, 'EFECTIVO'), (2, 'TARJETA'), (3, 'TRANSFERENCIA');

INSERT IGNORE INTO InventoryLogTypes (InventoryLogTypeId, name) VALUES
(1, 'VENTA_NORMAL'), (2, 'VENTA_MAYORISTA'), (3, 'COMPRA_PROVEEDOR'), (4, 'AJUSTE_INVENTARIO');

-- 3. CREAR PRODUCTOS
INSERT INTO BusinessProducts (name, description, status, price, cost, createdAt, updatedAt, enabled, businessId, productCategoryId, currencyId, unitMeasureId) VALUES
-- Electronic & Convenience (businessId 11)
('Smart TV 55"', 'Televisor inteligente 4K UHD', 'ACTIVE', 350000, 280000, NOW(), NULL, 1, 11, 1, 1, NULL),
('Laptop Gaming', 'Laptop para gaming 16GB RAM', 'ACTIVE', 650000, 520000, NOW(), NULL, 1, 11, 1, 1, NULL),
('Smartphone Android', 'Teléfono Android 128GB', 'ACTIVE', 280000, 224000, NOW(), NULL, 1, 11, 1, 1, NULL),
('Auriculares Inalámbricos', 'Audífonos Bluetooth cancelación ruido', 'ACTIVE', 85000, 68000, NOW(), NULL, 1, 11, 1, 1, NULL),
('Tablet 10"', 'Tablet 64GB WiFi', 'ACTIVE', 180000, 144000, NOW(), NULL, 1, 11, 1, 1, NULL),

-- Bebidas CR7 (businessId 14)
('Bebida Energética 500ml', 'Bebida energética sabor original', 'ACTIVE', 1200, 800, NOW(), NULL, 1, 14, 2, 1, 1),
('Bebida Energética 1L', 'Bebida energética tamaño familiar', 'ACTIVE', 2000, 1400, NOW(), NULL, 1, 14, 2, 1, 1),
('Pack 6 Bebidas', 'Pack de 6 bebidas energéticas', 'ACTIVE', 6500, 4500, NOW(), NULL, 1, 14, 2, 1, 1),
('Bebida Sin Azúcar', 'Bebida energética sin azúcar', 'ACTIVE', 1300, 900, NOW(), NULL, 1, 14, 2, 1, 1),
('Bebida Sabor Frutas', 'Bebida energética sabor frutas tropicales', 'ACTIVE', 1250, 850, NOW(), NULL, 1, 14, 2, 1, 1),

-- Pre U (businessId 15)
('Cuaderno Universitario', 'Cuaderno 100 hojas rayado', 'ACTIVE', 2500, 1500, NOW(), NULL, 1, 15, 3, 1, 1),
('Paquete de Lápices', 'Paquete de 12 lápices HB', 'ACTIVE', 1800, 1200, NOW(), NULL, 1, 15, 3, 1, 1),
('Mochila Universitaria', 'Mochila resistente para laptop', 'ACTIVE', 35000, 25000, NOW(), NULL, 1, 15, 3, 1, 1),
('Calculadora Científica', 'Calculadora para ingeniería', 'ACTIVE', 22000, 16000, NOW(), NULL, 1, 15, 3, 1, 1),
('Set de Marcadores', 'Set de 8 marcadores permanentes', 'ACTIVE', 4500, 3000, NOW(), NULL, 1, 15, 3, 1, 1);

-- 4. CREAR INVENTARIO INICIAL
INSERT INTO Inventory (status, quantity, createdAt, updatedAt, enabled, contractId, businessProductId)
SELECT 'ACTIVE', 
    CASE 
        WHEN bp.businessId = 11 THEN FLOOR(50 + RAND() * 50)   -- 50-100 para electrónicos
        WHEN bp.businessId = 14 THEN FLOOR(200 + RAND() * 200) -- 200-400 para bebidas
        ELSE FLOOR(300 + RAND() * 300) -- 300-600 para papelería
    END,
    NOW(), NULL, 1,
    CASE bp.businessId
        WHEN 11 THEN 5
        WHEN 14 THEN 7
        ELSE 8
    END,
    bp.businessProductId
FROM BusinessProducts bp;

-- 6. EJECUTAR PROCEDIMIENTO
CALL GenerateFourMonthsSales();

-- 7. ELIMINAR PROCEDIMIENTO
DROP PROCEDURE GenerateFourMonthsSales;

*/
