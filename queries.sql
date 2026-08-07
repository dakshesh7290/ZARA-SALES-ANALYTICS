-- ============================================================
-- Zara Sales Analysis — SQL Queries (SQLite)
-- Dataset: zara_sales (252 rows, product catalog snapshot)
-- ============================================================

-- Row count sanity check
SELECT COUNT(*) FROM zara_sales;


-- ------------------------------------------------------------
-- Query 1: Top-selling categories
-- Revenue and units sold, grouped by product category (terms)
-- ------------------------------------------------------------
SELECT "terms",
       SUM("Sales Volume") AS total_units,
       SUM(price * "Sales Volume") AS total_revenue
FROM zara_sales
GROUP BY "terms"
ORDER BY total_revenue DESC;

-- Result:
-- jackets   | 259468 units | $26,581,815.87
-- sweaters  | 75242  units | $4,090,631.48
-- shoes     | 57906  units | $3,754,837.63
-- t-shirts  | 53637  units | $3,696,806.25
-- jeans     | 13320  units | $864,385.25


-- ------------------------------------------------------------
-- Query 2: Revenue by section (substitute for region-wise revenue
-- — dataset has no region field, so section (MAN/WOMAN) is used)
-- ------------------------------------------------------------
SELECT "section",
       SUM("Sales Volume") AS total_units,
       SUM(price * "Sales Volume") AS total_revenue
FROM zara_sales
GROUP BY "section"
ORDER BY total_revenue DESC;

-- Result:
-- MAN   | 396199 units | $35,712,663.03
-- WOMAN | 63374  units | $3,275,813.45
-- Note: WOMAN is represented only by the sweaters category in this dataset.


-- ------------------------------------------------------------
-- Query 3: Revenue by shelf position (substitute for month-over-month
-- growth — dataset is a single-day snapshot with no date range)
-- ------------------------------------------------------------
SELECT "Product Position",
       SUM("Sales Volume") AS total_units,
       SUM(price * "Sales Volume") AS total_revenue,
       AVG(price * "Sales Volume") AS avg_revenue_per_product
FROM zara_sales
GROUP BY "Product Position"
ORDER BY total_revenue DESC;

-- Result:
-- Aisle           | 177396 units | $15,481,438.43 | avg $159,602.46
-- End-cap         | 152930 units | $12,546,465.81 | avg $145,889.14
-- Front of Store  | 129247 units | $10,960,572.24 | avg $158,848.87


-- ------------------------------------------------------------
-- Query 4: Average price and revenue by category x section
-- (substitute for AOV by store — dataset has no store field)
-- ------------------------------------------------------------
SELECT "terms", "section",
       AVG(price) AS avg_price,
       AVG(price * "Sales Volume") AS avg_revenue_per_product,
       COUNT(*) AS product_count
FROM zara_sales
GROUP BY "terms", "section"
ORDER BY avg_revenue_per_product DESC;

-- Result:
-- jackets  | MAN   | avg price $105.76 | avg revenue $189,870.11 | 140 products
-- shoes    | MAN   | avg price $64.87  | avg revenue $121,123.79 | 31 products
-- sweaters | MAN   | avg price $75.93  | avg revenue $116,402.58 | 7 products
-- t-shirts | MAN   | avg price $67.43  | avg revenue $115,525.20 | 32 products
-- jeans    | MAN   | avg price $63.92  | avg revenue $108,048.16 | 8 products
-- sweaters | WOMAN | avg price $50.53  | avg revenue $96,347.45  | 34 products
