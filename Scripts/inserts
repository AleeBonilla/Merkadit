USE Merkadit_DB;

-- Timeouts de inserción

SET SESSION wait_timeout = 28800;
SET SESSION interactive_timeout = 28800;
SET SESSION max_execution_time = 0;

START TRANSACTION;

-- 1. INSERTAR CATEGORÍAS DE PRODUCTOS (primero, son dependencias)
INSERT IGNORE INTO `ProductCategories` (productCategoryId, productCategoryName) VALUES 
(1, 'JUGUETES'),
(2, 'PANADERIA'),
(3, 'LIBRERIA');

-- 2. INSERTAR UNIDADES DE MEDIDA
INSERT IGNORE INTO `UnitMeasures` (unitMeasureId, name, code) VALUES 
(1, 'Unidad', 'UND'),
(2, 'Kilogramo', 'KG'),
(3, 'Litro', 'L');

-- 3. INSERTAR TIPOS DE TRANSACCIÓN Y MÉTODOS DE PAGO
INSERT IGNORE INTO `TransactionTypes` (transactionType, name) VALUES 
(1, 'VENTA'),
(2, 'COMPRA');

INSERT IGNORE INTO `PaymentMethods` (paymentMethodId, name) VALUES 
(1, 'EFECTIVO'),
(2, 'TARJETA'),
(3, 'SINPE');

-- 4. INSERTAR TIPOS DE LOGS DE INVENTARIO
INSERT IGNORE INTO `InventoryLogTypes` (InventoryLogTypeId, name) VALUES 
(1, 'VENTA'),
(2, 'REPOSICION'),
(3, 'AJUSTE');

-- 5. INSERTAR PRODUCTOS PARA TRES NEGOCIOS

-- Productos para Juguetería Feliz (ID: 7)
INSERT INTO `BusinessProducts` 
(businessProductId, name, description, status, price, cost, createdAt, updatedAt, enabled, businessId, productCategoryId, currencyId, unitMeasureId) VALUES
(1, 'Set de Lego City', 'Set de construcción Lego con 500 piezas', 'ACTIVE', 25000, 18000, '2024-09-01 08:00:00', NULL, 1, 7, 1, 1, 1),
(2, 'Muñeca Barbie', 'Muñeca Barbie profesional con accesorios', 'ACTIVE', 15000, 11000, '2024-09-01 08:00:00', NULL, 1, 7, 1, 1, 1),
(3, 'Carro de Control Remoto', 'Carro RC con batería recargable', 'ACTIVE', 35000, 28000, '2024-09-01 08:00:00', NULL, 1, 7, 1, 1, 1),
(4, 'Rompecabezas 1000 piezas', 'Rompecabezas educativo de animales', 'ACTIVE', 12000, 8000, '2024-09-01 08:00:00', NULL, 1, 7, 1, 1, 1),
(5, 'Juego de Mesa Monopoly', 'Juego clásico de Monopoly edición especial', 'ACTIVE', 18000, 13000, '2024-09-01 08:00:00', NULL, 1, 7, 1, 1, 1);

-- Productos para Panadería Dulce (ID: 8)
INSERT INTO `BusinessProducts` 
(businessProductId, name, description, status, price, cost, createdAt, updatedAt, enabled, businessId, productCategoryId, currencyId, unitMeasureId) VALUES
(6, 'Pan Francés', 'Pan francés artesanal recién horneado', 'ACTIVE', 1200, 600, '2024-09-01 08:00:00', NULL, 1, 8, 2, 1, 1),
(7, 'Croissant de Mantequilla', 'Croissant hojaldrado con mantequilla', 'ACTIVE', 800, 400, '2024-09-01 08:00:00', NULL, 1, 8, 2, 1, 1),
(8, 'Torta de Chocolate', 'Torta de chocolate premium por porción', 'ACTIVE', 2000, 1200, '2024-09-01 08:00:00', NULL, 1, 8, 2, 1, 1),
(9, 'Galletas de Avena', 'Galletas de avena con pasas y miel', 'ACTIVE', 600, 300, '2024-09-01 08:00:00', NULL, 1, 8, 2, 1, 1),
(10, 'Empanada de Piña', 'Empanada dulce rellena de piña', 'ACTIVE', 1000, 500, '2024-09-01 08:00:00', NULL, 1, 8, 2, 1, 1);

-- Productos para Librería Alfa (ID: 9)
INSERT INTO `BusinessProducts` 
(businessProductId, name, description, status, price, cost, createdAt, updatedAt, enabled, businessId, productCategoryId, currencyId, unitMeasureId) VALUES
(11, 'Libro de Cocina', 'Libro de recetas tradicionales costarricenses', 'ACTIVE', 15000, 9000, '2024-09-01 08:00:00', NULL, 1, 9, 3, 1, 1),
(12, 'Cuaderno Universitario', 'Cuaderno de 100 hojas rayado', 'ACTIVE', 2500, 1500, '2024-09-01 08:00:00', NULL, 1, 9, 3, 1, 1),
(13, 'Set de Bolígrafos', 'Paquete de 5 bolígrafos de colores', 'ACTIVE', 3000, 1800, '2024-09-01 08:00:00', NULL, 1, 9, 3, 1, 1),
(14, 'Mochila Escolar', 'Mochila resistente con compartimentos', 'ACTIVE', 22000, 15000, '2024-09-01 08:00:00', NULL, 1, 9, 3, 1, 1),
(15, 'Calculadora Científica', 'Calculadora científica para estudiantes', 'ACTIVE', 12000, 8000, '2024-09-01 08:00:00', NULL, 1, 9, 3, 1, 1);

-- 6. INSERTAR INVENTARIO INICIAL (cantidades realistas para 4 meses de ventas)
INSERT INTO `Inventory` 
(InventoryId, status, quantity, createdAt, updatedAt, enabled, contractId, businessProductId) VALUES
-- Juguetería Feliz (productos de precio medio-alto, menos rotación)
(1, 'ACTIVE', 100, '2024-06-01 08:00:00', NULL, 1, 6, 1),
(2, 'ACTIVE', 80, '2024-06-01 08:00:00', NULL, 1, 6, 2),
(3, 'ACTIVE', 60, '2024-06-01 08:00:00', NULL, 1, 6, 3),
(4, 'ACTIVE', 90, '2024-06-01 08:00:00', NULL, 1, 6, 4),
(5, 'ACTIVE', 70, '2024-06-01 08:00:00', NULL, 1, 6, 5),

-- Panadería Dulce (productos de consumo diario, alta rotación)
(6, 'ACTIVE', 500, '2024-06-01 08:00:00', NULL, 1, 7, 6),
(7, 'ACTIVE', 400, '2024-06-01 08:00:00', NULL, 1, 7, 7),
(8, 'ACTIVE', 200, '2024-06-01 08:00:00', NULL, 1, 7, 8),
(9, 'ACTIVE', 600, '2024-06-01 08:00:00', NULL, 1, 7, 9),
(10, 'ACTIVE', 300, '2024-06-01 08:00:00', NULL, 1, 7, 10),

-- Librería Alfa (productos variados, rotación media)
(11, 'ACTIVE', 80, '2024-06-01 08:00:00', NULL, 1, 8, 11),
(12, 'ACTIVE', 300, '2024-06-01 08:00:00', NULL, 1, 8, 12),
(13, 'ACTIVE', 250, '2024-06-01 08:00:00', NULL, 1, 8, 13),
(14, 'ACTIVE', 60, '2024-06-01 08:00:00', NULL, 1, 8, 14),
(15, 'ACTIVE', 100, '2024-06-01 08:00:00', NULL, 1, 8, 15);

COMMIT;

-- ==========================================
-- PROCEDIMIENTO OPTIMIZADO CON BATCH COMMITS
-- ==========================================
DELIMITER //

CREATE PROCEDURE GenerarComprasAleatorias()
BEGIN
    DECLARE contador INT DEFAULT 1;
    DECLARE compras_por_mes INT;
    DECLARE total_compras INT DEFAULT 0;
    DECLARE fecha_compra DATETIME;
    DECLARE business_id INT;
    DECLARE product_id INT;
    DECLARE inventory_id INT;
    DECLARE cantidad_comprada INT;
    DECLARE precio_venta FLOAT;
    DECLARE stock_disponible INT;
    DECLARE transaction_id INT DEFAULT 1;
    DECLARE sale_bill_id INT DEFAULT 1;
    DECLARE bill_detail_id INT DEFAULT 1;
    DECLARE inventory_log_id INT DEFAULT 1;
    DECLARE contract_id INT;
    DECLARE payment_method INT;
    DECLARE mes INT;
    DECLARE intentos INT;
    DECLARE max_intentos INT DEFAULT 20;
    DECLARE total_factura FLOAT;
    DECLARE impuesto FLOAT;
    DECLARE batch_counter INT DEFAULT 0;
    
    -- Deshabilitar autocommit para mejorar rendimiento
    SET autocommit = 0;
    
    SET mes = 0;
    WHILE mes < 4 DO
        -- Generar entre 50 y 70 compras por mes
        SET compras_por_mes = FLOOR(50 + RAND() * 21);
        SET contador = 1;
        
        SELECT CONCAT('Procesando mes ', mes + 1, ' con ', compras_por_mes, ' compras...') AS Estado;
        
        WHILE contador <= compras_por_mes DO
            SET intentos = 0;
            SET stock_disponible = 0;
            
            -- Intentar encontrar un producto con stock disponible
            WHILE stock_disponible <= 0 AND intentos < max_intentos DO
                -- Seleccionar negocio aleatorio (7, 8, o 9)
                SET business_id = ELT(FLOOR(1 + RAND() * 3), 7, 8, 9);
                
                -- Seleccionar producto aleatorio según el negocio
                IF business_id = 7 THEN
                    -- Juguetería (productos 1-5)
                    SET product_id = FLOOR(1 + RAND() * 5);
                    SET inventory_id = product_id;
                    SET cantidad_comprada = FLOOR(1 + RAND() * 3); -- 1-3 unidades
                ELSEIF business_id = 8 THEN
                    -- Panadería (productos 6-10)
                    SET product_id = FLOOR(6 + RAND() * 5);
                    SET inventory_id = product_id;
                    SET cantidad_comprada = FLOOR(1 + RAND() * 8); -- 1-8 unidades
                ELSE
                    -- Librería (productos 11-15)
                    SET product_id = FLOOR(11 + RAND() * 5);
                    SET inventory_id = product_id;
                    SET cantidad_comprada = FLOOR(1 + RAND() * 4); -- 1-4 unidades
                END IF;
                
                -- Verificar stock disponible
                SELECT quantity INTO stock_disponible 
                FROM Inventory 
                WHERE InventoryId = inventory_id;
                
                -- Ajustar cantidad si excede el stock
                IF stock_disponible < cantidad_comprada THEN
                    IF stock_disponible > 0 THEN
                        SET cantidad_comprada = stock_disponible;
                    ELSE
                        SET intentos = intentos + 1;
                    END IF;
                END IF;
            END WHILE;
            
            -- Si encontramos stock disponible, procesar la venta
            IF stock_disponible > 0 THEN
                -- Generar fecha aleatoria en el mes correspondiente
                SET fecha_compra = DATE_SUB(NOW(), INTERVAL (mes * 30) + FLOOR(RAND() * 30) DAY);
                SET fecha_compra = DATE_ADD(fecha_compra, INTERVAL FLOOR(RAND() * 14) HOUR);
                SET fecha_compra = DATE_ADD(fecha_compra, INTERVAL FLOOR(RAND() * 59) MINUTE);
                
                -- Obtener precio del producto
                SELECT price INTO precio_venta 
                FROM BusinessProducts 
                WHERE businessProductId = product_id;
                
                -- Calcular totales
                SET total_factura = precio_venta * cantidad_comprada;
                SET impuesto = total_factura * 0.13;
                
                -- Determinar contrato
                SET contract_id = CASE 
                    WHEN business_id = 7 THEN 6 
                    WHEN business_id = 8 THEN 7 
                    ELSE 8 
                END;
                
                -- Método de pago aleatorio
                SET payment_method = FLOOR(1 + RAND() * 3);
                
                -- Insertar transacción
                INSERT INTO `Transactions` 
                (TransactionId, amount, createdAt, status, checksum, transactionType, businessId, contractId, currencyId, paymentMethodId)
                VALUES (
                    transaction_id,
                    total_factura,
                    fecha_compra,
                    'COMPLETED',
                    SHA2(CONCAT(transaction_id, business_id, fecha_compra, total_factura), 256),
                    1,
                    business_id,
                    contract_id,
                    1,
                    payment_method
                );
                
                -- Insertar factura de venta
                INSERT INTO `SaleBills` 
                (saleBillId, BillNumber, referenceNumber, discount, taxAmount, taxApplied, total, paymentConfirmation, buyerName, buyerId, createdAt, checksum, transactionId, contractId, paymentMethodId)
                VALUES (
                    sale_bill_id,
                    FLOOR(10000 + RAND() * 90000),
                    FLOOR(100000 + RAND() * 900000),
                    0,
                    impuesto,
                    13,
                    total_factura + impuesto,
                    JSON_OBJECT('confirmado', true, 'metodo', 'pago_exitoso', 'timestamp', fecha_compra),
                    CONCAT('Cliente-', LPAD(FLOOR(1 + RAND() * 9999), 4, '0')),
                    NULL,
                    fecha_compra,
                    SHA2(CONCAT(sale_bill_id, transaction_id, fecha_compra), 256),
                    transaction_id,
                    contract_id,
                    payment_method
                );
                
                -- Insertar detalle de factura
                INSERT INTO `BillDetail` 
                (billDetail_id, quantity, unitPrice, subtotal, checksum, createdAt, saleBillId, businessSaleItemId, businessProductId)
                VALUES (
                    bill_detail_id,
                    cantidad_comprada,
                    precio_venta,
                    total_factura,
                    SHA2(CONCAT(bill_detail_id, sale_bill_id, product_id, cantidad_comprada, precio_venta), 256),
                    fecha_compra,
                    sale_bill_id,
                    NULL,
                    product_id
                );
                
                -- Actualizar inventario (CRÍTICO: restar cantidad)
                UPDATE `Inventory` 
                SET quantity = quantity - cantidad_comprada,
                    updatedAt = fecha_compra
                WHERE InventoryId = inventory_id;
                
                -- Insertar log de inventario
                INSERT INTO `InventoryLogs` 
                (InventoryLogId, changeQuantity, changeType, InventoryLogTypeId, InventoryId, checksum, createdAt)
                VALUES (
                    inventory_log_id,
                    -cantidad_comprada,
                    'SALE',
                    1,
                    inventory_id,
                    SHA2(CONCAT(inventory_log_id, inventory_id, fecha_compra, cantidad_comprada), 256),
                    fecha_compra
                );
                
                -- Incrementar contadores
                SET transaction_id = transaction_id + 1;
                SET sale_bill_id = sale_bill_id + 1;
                SET bill_detail_id = bill_detail_id + 1;
                SET inventory_log_id = inventory_log_id + 1;
                SET total_compras = total_compras + 1;
                SET batch_counter = batch_counter + 1;
                
                -- COMMIT cada 25 registros para evitar timeouts
                IF batch_counter >= 25 THEN
                    COMMIT;
                    SET batch_counter = 0;
                END IF;
            END IF;
            
            SET contador = contador + 1;
        END WHILE;
        
        -- Commit al final de cada mes
        COMMIT;
        SELECT CONCAT('Mes ', mes + 1, ' completado') AS Estado;
        
        SET mes = mes + 1;
    END WHILE;
    
    -- Commit final
    COMMIT;
    SET autocommit = 1;
    
    SELECT CONCAT('Total de compras generadas exitosamente: ', total_compras) AS Resultado;
    
END//

DELIMITER ;

CALL GenerarComprasAleatorias();
