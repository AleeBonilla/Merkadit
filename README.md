# Merkadit - Sistema de Gestión de Mercados Gastronómicos y Minoristas

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)

## Descripción del Proyecto

**Merkadit** es un sistema integral diseñado para optimizar la gestión de mercados gastronómicos y minoristas, donde un administrador invierte en remodelar un espacio físico y lo transforma en múltiples tiendas o quioscos alquilados por negocios independientes.

### Características Principales

- **Gestión Centralizada**: Control total sobre espacios, contratos, alquileres y comisiones
- **Punto de Venta (POS)**: Sistema integrado para que los inquilinos registren ventas en tiempo real
- **Cálculo Automático**: Comisiones basadas en ventas según contrato
- **Trazabilidad Completa**: Logs de sistema, checksums e inventario auditables
- **Reportes Financieros**: Visibilidad completa de ingresos, gastos y rendimiento

---

## Arquitectura de Base de Datos

### Módulos Principales

#### 1. **Gestión Geográfica y Ubicaciones**
```
Countries → States → Cities → Addresses → Buildings → BuildingArea
```
- Jerarquía completa de ubicación física
- Geolocalización mediante campos POINT
- Soporte para múltiples edificios y áreas

#### 2. **Gestión de Mercados y Espacios**
- **Markets**: Mercados dentro de áreas de edificios
- **Spaces**: Espacios individuales (FOOD/RETAIL)
- **SpacesPerContract**: Relación espacios-contratos

#### 3. **Gestión de Negocios**
- **Business**: Entidades jurídicas (inquilinos/administradores)
- **BusinessRoles**: Roles de negocio
- **BusinessCategories**: Categorización de negocios
- **ContactMethodsPerBusiness**: Métodos de contacto

#### 4. **Sistema de Contratos**
- **Contracts**: Contratos de alquiler con todas las condiciones
- **RentPaymentFrequencies**: Frecuencias de pago
- Soporte multimoneda
- Fechas de liquidación personalizadas

#### 5. **Sistema Transaccional**
- **Transactions**: Base de todas las transacciones financieras
- **SaleBills**: Facturas de venta con detalles completos
- **BillDetail**: Líneas de factura
- **PaymentMethods**: Métodos de pago soportados

#### 6. **Gestión de Inventario**
- **BusinessProducts**: Catálogo de productos por negocio
- **Inventory**: Control de stock por contrato
- **InventoryLogs**: Trazabilidad completa de movimientos

#### 7. **Cuentas por Cobrar**
- **AccountsReceivables**: Gestión de CxC
- **AccountReceivableLog**: Historial de cargos/pagos

#### 8. **Sistema de Auditoría**
- **SystemLogs**: Logs detallados del sistema
- **Checksums**: Validación de integridad en tablas críticas
- Trazabilidad de usuario, terminal y timestamp

---

## Estructura de la Base de Datos

### Tablas Principales (40+)

<details>
<summary>Ver lista completa de tablas</summary>

**Ubicaciones**
- Countries, States, Cities, Addresses

**Infraestructura**
- Buildings, BuildingArea, Markets, Spaces

**Negocios y Contratos**
- Business, LegalEntityTypes, BusinessRoles, BusinessCategories
- Contracts, RentPaymentFrequencies, Currencies

**Transacciones y Ventas**
- Transactions, TransactionTypes, PaymentMethods
- SaleBills, BillDetail

**Productos e Inventario**
- BusinessProducts, BusinessSaleItems, ProductCategories
- Inventory, InventoryLogs, InventoryLogTypes, UnitMeasures

**Finanzas**
- AccountsReceivables, AccountReceivableLog
- OperationalExpenses, OperationalExpenseTypes

**Sistema y Seguridad**
- Users, Roles, Permissions, Modules
- SystemLogs, SystemLogTypes, LogSources, LogLevels

**Relaciones Many-to-Many**
- UserBusiness, RolesPerUser, PermissionsPerRole
- CategoriesPerBusiness, ContactMethodsPerBusiness
- SpacesPerContract

</details>

---

## Características Implementadas

### ✅ Procedimientos Almacenados

#### 1. `registerSale`
Registra una venta con validaciones completas y auditoría.

**Parámetros:**
```sql
CALL registerSale(
    p_nombre_producto,      -- VARCHAR(60)
    p_nombre_tienda,        -- VARCHAR(50)
    p_cantidad_vendida,     -- INT
    p_monto_pagado,         -- FLOAT
    p_metodo_pago,          -- VARCHAR(30)
    p_confirmaciones_pago,  -- JSON
    p_numeros_referencia,   -- BIGINT
    p_cedula_cliente,       -- VARCHAR(20)
    p_nombre_cliente,       -- VARCHAR(60)
    p_descuentos_aplicados, -- FLOAT
    p_user_id,              -- INT
    p_computer_name         -- VARCHAR(100)
);
```

**Características:**
- ✅ Manejo exhaustivo de excepciones
- ✅ Validación de stock en tiempo real
- ✅ Cálculo automático de IVA (13%)
- ✅ Actualización atómica de inventario
- ✅ Generación automática de número de factura
- ✅ Logging completo (usuario, terminal, checksum)
- ✅ Control transaccional con ROLLBACK automático

#### 2. `settleCommerce` 
Liquida las cuentas de una tienda para el mes en curso.

**Funcionalidad:**
- Verificación de liquidación previa
- Cálculo de comisiones totales
- Ejecución de transacciones financieras
- Prevención de liquidación duplicada
- Auditoría completa

---

## Datos de Ejemplo

### Script de Inserción Automática

El sistema incluye un script que genera:
- ✅ 3 negocios con diferentes categorías
- ✅ 15 productos (5 por negocio)
- ✅ Inventario inicial realista por tipo de producto
- ✅ 200-280 compras aleatorias en 4 meses
- ✅ Distribución temporal realista (50-70 ventas/mes)
- ✅ Control de inventario para evitar números negativos
- ✅ Fechas aleatorias con horarios comerciales

**Negocios de ejemplo:**
1. **Juguetería Feliz** (Categoría: JUGUETES)
   - Set de Lego, Muñecas, Carros RC, Rompecabezas, Juegos de Mesa
   
2. **Panadería Dulce** (Categoría: PANADERIA)
   - Pan Francés, Croissants, Tortas, Galletas, Empanadas

3. **Librería Alfa** (Categoría: LIBRERIA)
   - Libros, Cuadernos, Bolígrafos, Mochilas, Calculadoras

---

## Instalación y Configuración

### Requisitos Previos
- MySQL 8.0 o superior
- MySQL Workbench (recomendado)
- 100MB de espacio en disco

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/merkadit.git
cd merkadit
```

2. **Crear la base de datos**
```sql
-- Ejecutar en MySQL Workbench o cliente MySQL
SOURCE tables.sql;
```

3. **Insertar datos de ejemplo**
```sql
SOURCE Ins.sql;
```

4. **Crear procedimientos almacenados**
```sql
SOURCE sp1.sql;
SOURCE sp2.sql
```

5. **Verificar instalación**
```sql
USE Merkadit_db;
SHOW TABLES;
SHOW PROCEDURE STATUS WHERE Db = 'Merkadit_db';
```

---

## Uso del Sistema

### Ejemplo 1: Registrar una Venta

```sql
CALL registerSale(
    'Set de Lego City',                          -- Producto
    'Juguetería Feliz',                          -- Tienda
    2,                                           -- Cantidad
    56500.0,                                     -- Monto (incluye IVA)
    'EFECTIVO',                                  -- Método de pago
    '{"confirmado": true, "caja": 1}',           -- Confirmación JSON
    123456789,                                   -- Referencia
    '304560789',                                 -- Cédula cliente
    'Juan Pérez González',                       -- Nombre cliente
    0.0,                                         -- Descuentos
    100,                                         -- ID cajero
    'CAJA-01-PC-PRINCIPAL'                       -- Terminal
);
```

### Ejemplo 2: Consultar Inventario

```sql
SELECT 
    b.name AS Negocio,
    bp.name AS Producto,
    i.quantity AS Stock,
    bp.price AS Precio,
    i.updatedAt AS UltimaActualizacion
FROM Inventory i
JOIN BusinessProducts bp ON i.businessProductId = bp.businessProductId
JOIN Business b ON bp.businessId = b.businessId
WHERE i.status = 'ACTIVE'
ORDER BY b.name, bp.name;
```

### Ejemplo 3: Reporte de Ventas Mensual

```sql
SELECT 
    b.name AS Negocio,
    DATE_FORMAT(t.createdAt, '%Y-%m') AS Mes,
    COUNT(*) AS TotalVentas,
    SUM(t.amount) AS TotalVendido,
    AVG(t.amount) AS VentaPromedio
FROM Transactions t
JOIN Business b ON t.businessId = b.businessId
WHERE t.transactionType = 1
GROUP BY b.businessId, DATE_FORMAT(t.createdAt, '%Y-%m')
ORDER BY Mes DESC, TotalVendido DESC;
```

---

## Modelo de Datos

### Diagrama ER (Conceptual)

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│  Buildings  │────────▶│ BuildingArea │────────▶│   Markets   │
└─────────────┘         └──────────────┘         └─────────────┘
                                                         │
                                                         ▼
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│  Business   │◀────────│   Contracts  │────────▶│   Spaces    │
└─────────────┘         └──────────────┘         └─────────────┘
      │                        │
      │                        │
      ▼                        ▼
┌─────────────┐         ┌──────────────┐
│  Inventory  │         │Transactions  │
└─────────────┘         └──────────────┘
      │                        │
      ▼                        ▼
┌─────────────┐         ┌──────────────┐
│   Products  │         │  SaleBills   │
└─────────────┘         └──────────────┘
```

---

## Seguridad

### Características de Seguridad Implementadas

- ✅ **Passwords hasheados**: SHA256 para almacenamiento seguro
- ✅ **Checksums**: Validación de integridad en transacciones críticas
- ✅ **Control de acceso**: Sistema de roles y permisos granular
- ✅ **Auditoría completa**: SystemLogs registra operaciones
- ✅ **Validación de entrada**: Procedimientos validan todos los parámetros

### Roles de los BUSINESS del Sistema

| Rol | Descripción | Permisos |
|-----|-------------|----------|
| **Administrador** | Gestiona contratos, inversiones, gastos | Control total del sistema |
| **Inquilino** | Gestiona su propio negocio | POS, inventario, reportes propios |


---

## Reportes Disponibles

### 1. Reporte de Negocios (Vista)
```sql
CREATE VIEW vw_business_report AS
SELECT 
    b.name AS business_name,
    s.code AS space_code,
    bldg.name AS building_name,
    MIN(t.createdAt) AS first_sale_date,
    MAX(t.createdAt) AS last_sale_date,
    COUNT(bd.billDetail_id) AS items_sold,
    SUM(t.amount) AS total_sales,
    c.feePercentage AS commission_rate,
    SUM(t.amount) * c.feePercentage AS commission_amount,
    c.rentAmount AS rent_amount
FROM Business b
JOIN Contracts c ON b.businessId = c.tenantBusinessId
JOIN SpacesPerContract spc ON c.contractId = spc.contractId
JOIN Spaces s ON spc.spaceId = s.spaceId
JOIN Markets m ON s.marketId = m.marketId
JOIN BuildingArea ba ON m.buildingArea = ba.buildingArea
JOIN Buildings bldg ON ba.buildingId = bldg.buildingId
JOIN Transactions t ON b.businessId = t.businessId
JOIN SaleBills sb ON t.TransactionId = sb.transactionId
JOIN BillDetail bd ON sb.saleBillId = bd.saleBillId
WHERE MONTH(t.createdAt) = MONTH(CURRENT_DATE)
  AND YEAR(t.createdAt) = YEAR(CURRENT_DATE)
GROUP BY b.businessId, s.spaceId;
```

### 2. Estado de Ocupación
```sql
SELECT 
    COUNT(*) as total_spaces,
    SUM(CASE WHEN status = 'AVAILABLE' THEN 1 ELSE 0 END) as available,
    SUM(CASE WHEN status = 'OCUPPIED' THEN 1 ELSE 0 END) as occupied,
    SUM(CASE WHEN status = 'UNDER_RENOVATION' THEN 1 ELSE 0 END) as renovation
FROM Spaces;
```

---

## Testing

### Pruebas con Postman

Colección de Postman incluida con endpoints para:
- ✅ Registro de ventas
- ✅ Consulta de inventario
- ✅ Liquidación de comercios
- ✅ Generación de reportes

**Importar colección:**
```bash
# ...
```

---

## Contribución

Este proyecto fue desarrollado como parte del curso de Bases de Datos I.

### Equipo de Desarrollo

- **Desarrolladores**: Alexander Bonilla, Mariano Soto y Andrés Rodríguez
- **Institución**: ITCR
- **Curso**: Bases de Datos I
- **Fecha**: 30 de septiembre 2025

---

##  Licencia

Sin licencia.

---

##  Estado del Proyecto

| Componente | Estado | Notas |
|------------|--------|-------|
| Diseño de BD | ✅ Completo | 
| Datos de ejemplo | ✅ Completo | 
| Procedimiento #1 | ✅ Completo | 
| Procedimiento #2 | ✅ Completo | 
| API REST | ✅ | Completo |
| Reportes | ✅ | Completo |

---

**Última actualización**: Septiembre 30, 2025
