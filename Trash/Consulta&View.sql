
UNLOCK TABLES;

-- Reporte de negocios por espacio/edificio (corte: mes actual)
-- Reporte "as of today" que incluye TODOS los Buildings y TODOS los Markets


-- Reporte de negocios por espacio/edificio (corte: mes actual)
WITH month_bounds AS (
  SELECT
    DATE_FORMAT(CURDATE(), '%Y-%m-01') AS month_start,
    LAST_DAY(CURDATE())                AS month_end
),
bill_totals AS (
  SELECT
    sb.contractId,
    MIN(sb.createdAt) AS first_sale_date,
    MAX(sb.createdAt) AS last_sale_date,
    SUM(sb.total)     AS total_sales_amount
  FROM SaleBills sb
  JOIN month_bounds mb
    ON sb.createdAt >= mb.month_start
   AND sb.createdAt <  mb.month_end + INTERVAL 1 DAY
  GROUP BY sb.contractId
),
items_sold AS (
  SELECT
    sb.contractId,
    COALESCE(SUM(bd.quantity), 0) AS number_items_sold
  FROM SaleBills sb
  JOIN BillDetail bd
    ON bd.saleBillId = sb.saleBillId
  JOIN month_bounds mb
    ON sb.createdAt >= mb.month_start
   AND sb.createdAt <  mb.month_end + INTERVAL 1 DAY
  GROUP BY sb.contractId
)
SELECT
  m.name                               AS Business,
  biz.name                             AS Store,
  bld.name                             AS Building,
  bt.first_sale_date                   AS first_sale_current_month,
  bt.last_sale_date                    AS last_sale_current_month,
  COALESCE(isold.number_items_sold, 0) AS items_sold_current_month,
  COALESCE(bt.total_sales_amount, 0)   AS total_sales_current_month,
  c.feePercentage                      AS owner_fee_percentage,
  ROUND(COALESCE(bt.total_sales_amount, 0) * (COALESCE(c.feePercentage,0)/100), 2)
                                       AS owner_fee_amount,
  c.rentAmount                         AS rental_fee_amount
FROM Buildings bld
LEFT JOIN BuildingArea ba   ON ba.buildingId = bld.buildingId
LEFT JOIN Markets m         ON m.buildingArea = ba.buildingArea
LEFT JOIN Spaces s          ON s.marketId = m.marketId
LEFT JOIN SpacesPerContract spc
       ON spc.spaceId = s.spaceId
      AND spc.status = 'ACTIVE'
LEFT JOIN Contracts c
       ON c.contractId = spc.contractId
      AND c.status = 'ACTIVE'
LEFT JOIN Business biz      ON biz.businessId = c.tenantBusinessId
LEFT JOIN bill_totals bt    ON bt.contractId  = c.contractId
LEFT JOIN items_sold isold  ON isold.contractId = c.contractId
WHERE biz.businessId IS NOT NULL   -- 🔑 Solo filas con Store asociada
ORDER BY
  bld.name, m.name, s.code, Store;
  
-- VIEW
-- Opcional: si ya existe
DROP VIEW IF EXISTS BusinessReport;

CREATE ALGORITHM=MERGE
SQL SECURITY DEFINER
VIEW BusinessReport AS
SELECT
  m.name                                AS Business,        -- Market
  biz.name                              AS Store,           -- Negocio (tenant)
  bld.name                              AS Building,
  bt.first_sale_date                    AS first_sale_current_month,
  bt.last_sale_date                     AS last_sale_current_month,
  COALESCE(isold.number_items_sold, 0)  AS items_sold_current_month,
  COALESCE(bt.total_sales_amount, 0)    AS total_sales_current_month,
  c.feePercentage                       AS owner_fee_percentage,
  ROUND(COALESCE(bt.total_sales_amount, 0) * (COALESCE(c.feePercentage,0)/100), 2)
                                        AS owner_fee_amount,
  c.rentAmount                          AS rental_fee_amount
FROM Buildings bld
LEFT JOIN BuildingArea ba    ON ba.buildingId = bld.buildingId
LEFT JOIN Markets m          ON m.buildingArea = ba.buildingArea
LEFT JOIN Spaces s           ON s.marketId = m.marketId
LEFT JOIN SpacesPerContract spc
       ON spc.spaceId = s.spaceId
      AND spc.status  = 'ACTIVE'
LEFT JOIN Contracts c
       ON c.contractId = spc.contractId
      AND c.status     = 'ACTIVE'
LEFT JOIN Business biz       ON biz.businessId = c.tenantBusinessId
LEFT JOIN (
    SELECT
      sb.contractId,
      MIN(sb.createdAt) AS first_sale_date,
      MAX(sb.createdAt) AS last_sale_date,
      SUM(sb.total)     AS total_sales_amount
    FROM SaleBills sb
    WHERE sb.createdAt >= DATE_FORMAT(CURDATE(), '%Y-%m-01')
      AND sb.createdAt <  (LAST_DAY(CURDATE()) + INTERVAL 1 DAY)
    GROUP BY sb.contractId
) bt                          ON bt.contractId = c.contractId
LEFT JOIN (
    SELECT
      sb.contractId,
      COALESCE(SUM(bd.quantity), 0) AS number_items_sold
    FROM SaleBills sb
    JOIN BillDetail bd ON bd.saleBillId = sb.saleBillId
    WHERE sb.createdAt >= DATE_FORMAT(CURDATE(), '%Y-%m-01')
      AND sb.createdAt <  (LAST_DAY(CURDATE()) + INTERVAL 1 DAY)
    GROUP BY sb.contractId
) isold                       ON isold.contractId = c.contractId
WHERE biz.businessId IS NOT NULL;  -- Solo filas con Store asociada

SELECT * 
FROM BusinessReport
ORDER BY Building, Business, Store;


