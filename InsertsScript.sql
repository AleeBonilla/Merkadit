USE Merkadit_DB;
-- CATALOGOS BASE
INSERT INTO Countries (countryId,name) VALUES (1,'Costa Rica');
INSERT INTO States (stateId,name,countryId) VALUES (1,'San José',1);
INSERT INTO Cities (cityId,name,stateId) VALUES (1,'San José',1);

INSERT INTO LegalEntityTypes (EntityTypeId,legalEntityName) VALUES (1,'S.R.L.'),(2,'S.A.');
INSERT INTO BusinessRoles (BussinessRoleId,name) VALUES (1,'TENANT'),(2,'ADMIN');

INSERT INTO Users (userNationalId, userFirstname, userLastname, userPassword, userStatus, createdAt, updatedAt, enabled) VALUES
('101010101', 'Carlos', 'Ramírez', UNHEX('5f4dcc3b5aa765d61d8327deb882cf99'), 'ACTIVE', NOW(), NULL, 1),
('202020202', 'María', 'González', UNHEX('e99a18c428cb38d5f260853678922e03'), 'CHANGED', NOW(), NOW(), 1),
('303030303', 'Luis', 'Mora', UNHEX('25d55ad283aa400af464c76d713c07ad'), 'INACTIVE', NOW(), NULL, 0),
('404040404', 'Ana', 'Soto', UNHEX('d8578edf8458ce06fbc5bb76a58c5ca4'), 'DELETED', NOW(), NOW(), 0),
('505050505', 'Sofía', 'Navarro', UNHEX('5f4dcc3b5aa765d61d8327deb882cf99'), 'ACTIVE', NOW(), NULL, 1);

INSERT INTO RentPaymentFrequencies (rentPaymentFrequencyId,name) VALUES (1,'MONTHLY');
INSERT INTO Currencies (currencyId,name,code,symbol) VALUES (1,'Colón','CRC','₡'),(2,'US Dollar','USD','$');
INSERT INTO TransactionTypes (transactionType, name) VALUES
(1, 'Compra'),
(2, 'Venta'),
(3, 'Devolución'),
(4, 'Transferencia'),
(5, 'Ajuste de inventario');
INSERT INTO PaymentMethods (paymentMethodId,name) VALUES (1,'CASH'),(2,'CARD');
INSERT INTO UnitMeasures (unitMeasureId, name, code) VALUES
(1, 'Kilogramo', 'kg'),(2, 'Gramo', 'g'),(3, 'Litro', 'lt'),(4, 'Mililitro', 'ml'),
(5, 'Unidad', 'ud'),(6, 'Metro', 'm'),(7, 'Centímetro', 'cm'),(8, 'Caja', 'cx'),
(9, 'Paquete', 'pk'),(10, 'Docena', 'dz');
INSERT INTO ProductCategories (productCategoryName) VALUES
('Electrónica'),('Ropa'),('Alimentos'),('Hogar'),('Libros'),('Juguetes')
,('Deportes'),('Salud'),('Belleza'),('Automotriz');

-- UBICACIONES
INSERT INTO Addresses (address1, address2, zipcode, geolocation, status, createdAt, updatedAt, enabled, cityIid) VALUES
('Av. Central 100', 'Edificio A, Piso 1', '30101', ST_GeomFromText('POINT(9.864 -83.918)'), 'ACTIVE', NOW(), NULL, 1, 1),
('Calle 5', 'Local B, Frente a parque', '30102', ST_GeomFromText('POINT(9.865 -83.920)'), 'ACTIVE', NOW(), NULL, 1, 1),
('Boulevard Norte', 'Edificio B, Piso 2', '30103', ST_GeomFromText('POINT(9.870 -83.925)'), 'CHANGED', NOW(), NOW(), 1, 1),
('Ruta 32', 'Contiguo a gasolinera', '30104', ST_GeomFromText('POINT(9.872 -83.930)'), 'ACTIVE', NOW(), NULL, 1, 1),
('Calle 10', 'Diagonal a escuela', '30105', ST_GeomFromText('POINT(9.868 -83.922)'), 'ACTIVE', NOW(), NULL, 1, 1);

INSERT INTO Buildings (name, createdAt, updatedAt, enabled, buildingStatus, addressId) VALUES
('Edificio Central', NOW(), NULL, 1, 'ACTIVE', 1),
('Edificio Norte', NOW(), NULL, 1, 'ACTIVE', 2);

INSERT INTO BuildingArea (floorNumber, description, status, createdAt, updatedAt, enabled, buildingId) VALUES
(1, 'Zona Norte del primer piso', 'ACTIVE', NOW(), NULL, 1, 1),
(2, 'Área de restaurantes en segundo piso', 'ACTIVE', NOW(), NULL, 1, 1),
(1, 'Pasillo principal junto a entrada', 'ACTIVE', NOW(), NULL, 1, 2),
(2, 'Zona de tiendas frente al ascensor', 'ACTIVE', NOW(), NULL, 1, 2);

-- NEGOCIO
INSERT INTO Business (taxId, legalId, name, legalName, description, status, createdAt, updatedAt, enabled, bussinessRoleId, legalAddressId, legalEntityTypeId, changed_by) VALUES
(101, '3101010101', 'Tienda Uno', 'Tienda Uno S.R.L.', 'Venta de artículos variados', 'ACTIVE', NOW(), NULL, 1, 1, 1, 1, 1),
(102, '3101010102', 'Papelería Azul', 'Papelería Azul S.A.', 'Papelería y útiles escolares', 'ACTIVE', NOW(), NULL, 1, 1, 2, 2, 1),
(103, '3101010103', 'Farmacia Vida', 'Farmacia Vida S.R.L.', 'Medicamentos y productos de salud', 'ACTIVE', NOW(), NULL, 1, 1, 3, 1, 1),
(104, '3101010104', 'Boutique Sol', 'Boutique Sol S.A.', 'Ropa y accesorios', 'ACTIVE', NOW(), NULL, 1, 1, 4, 2, 1),
(105, '3101010105', 'ElectroMax', 'ElectroMax S.R.L.', 'Electrodomésticos y tecnología', 'ACTIVE', NOW(), NULL, 1, 1, 5, 1, 1),
(106, '3101010106', 'Supermercado Norte', 'Supermercado Norte S.A.', 'Alimentos y productos de consumo', 'ACTIVE', NOW(), NULL, 1, 1, 6, 2, 1),
(107, '3101010107', 'Juguetería Feliz', 'Juguetería Feliz S.R.L.', 'Juguetes y entretenimiento infantil', 'ACTIVE', NOW(), NULL, 1, 1, 7, 1, 1),
(108, '3101010108', 'Panadería Dulce', 'Panadería Dulce S.A.', 'Panadería y repostería', 'ACTIVE', NOW(), NULL, 1, 1, 8, 2, 1),
(109, '3101010109', 'Librería Alfa', 'Librería Alfa S.R.L.', 'Libros y papelería', 'ACTIVE', NOW(), NULL, 1, 1, 9, 1, 1),
(110, '3101010110', 'Zapatería Paso Firme', 'Zapatería Paso Firme S.A.', 'Calzado y accesorios', 'ACTIVE', NOW(), NULL, 1, 1, 10, 2, 1),
(111, '3101010111', 'Óptica Luz', 'Óptica Luz S.R.L.', 'Lentes y servicios ópticos', 'ACTIVE', NOW(), NULL, 1, 1, 11, 1, 1),
(112, '3101010112', 'Tienda Verde', 'Tienda Verde S.A.', 'Productos ecológicos y naturales', 'ACTIVE', NOW(), NULL, 1, 1, 12, 2, 1),
(113, '3101010113', 'Ferretería Fuerte', 'Ferretería Fuerte S.R.L.', 'Herramientas y materiales de construcción', 'ACTIVE', NOW(), NULL, 1, 1, 13, 1, 1),
(114, '3101010114', 'Cafetería Aroma', 'Cafetería Aroma S.A.', 'Café y bebidas artesanales', 'ACTIVE', NOW(), NULL, 1, 1, 14, 2, 1),
(115, '3101010115', 'Estética Bella', 'Estética Bella S.R.L.', 'Servicios de belleza y cuidado personal', 'ACTIVE', NOW(), NULL, 1, 1, 15, 1, 1);

-- Market de retail
INSERT INTO Markets (name, status, spaceCount, createdAt, updatedAt, enabled, businessId, buildingArea) VALUES
('Local A - Retail Central', 'ACTIVE', 5, NOW(), NULL, 1, 5, 1);

-- Market de gastronomía
INSERT INTO Markets (name, status, spaceCount, createdAt, updatedAt, enabled, businessId, buildingArea) VALUES
('Local B - Gastronómica Norte', 'ACTIVE', 6, NOW(), NULL, 1, 6, 2);

-- Mixto
INSERT INTO Markets (name, status, spaceCount, createdAt, updatedAt, enabled, businessId, buildingArea) VALUES
('Local C - Mixta Norte', 'ACTIVE', 4, NOW(), NULL, 1, 13, 3);

-- ¿En esta parte hay que usar random?
INSERT INTO Spaces (code, size, type, status, createdAt, updatedAt, enabled, marketId) VALUES
('A001', 12.5, 'RETAIL', 'OCUPPIED', NOW(), NULL, 1, 1),
('A002', 10.0, 'RETAIL', 'OCUPPIED', NOW(), NULL, 1, 1),
('A003', 9.0,  'RETAIL', 'OCUPPIED', NOW(), NULL, 1, 1),
('A004', 11.0, 'RETAIL', 'OCUPPIED', NOW(), NULL, 1, 1);

-- Local B - Zona Gastronómica 7 espacios FOOD
INSERT INTO Spaces (code, size, type, status, createdAt, updatedAt, enabled, marketId) VALUES
('B001', 14.0, 'FOOD', 'OCUPPIED', NOW(), NULL, 1, 2),
('B002', 13.5, 'FOOD', 'OCUPPIED', NOW(), NULL, 1, 2),
('B003', 12.0, 'FOOD', 'OCUPPIED', NOW(), NULL, 1, 2),
('B004', 10.5, 'FOOD', 'OCUPPIED', NOW(), NULL, 1, 2),
('B005', 11.5, 'FOOD', 'OCUPPIED', NOW(), NULL, 1, 2),
('B006', 9.0,  'FOOD', 'OCUPPIED', NOW(), NULL, 1, 2),
('B007', 10.0, 'FOOD', 'OCUPPIED', NOW(), NULL, 1, 2);

-- Local C - Zona Mixta Norte (marketId = 3) → 6 espacios mixtos
INSERT INTO Spaces (code, size, type, status, createdAt, updatedAt, enabled, marketId) VALUES
('C001', 10.0, 'RETAIL', 'OCUPPIED', NOW(), NULL, 1, 3),
('C002', 9.0,  'FOOD',   'OCUPPIED', NOW(), NULL, 1, 3),
('C003', 8.5,  'RETAIL', 'OCUPPIED', NOW(), NULL, 1, 3),
('C004', 11.0, 'FOOD',   'OCUPPIED', NOW(), NULL, 1, 3),
('C005', 10.5, 'RETAIL', 'OCUPPIED', NOW(), NULL, 1, 3),
('C006', 9.5,  'FOOD',   'OCUPPIED', NOW(), NULL, 1, 3);

select * from Spaces;

