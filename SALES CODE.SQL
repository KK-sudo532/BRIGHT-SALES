SELECT(*)
FROM sales. sales_case_study_2;

SELECT(*)
FROM sales.sales_case_study_2
WHERE Date IS NULL;

SELECT(*)
FROM sales.sales_case_study_2
WHERE Sales is NULL;

SELECT(*)
FROM sales.sales_case_study_2
WHERE 'Cost Of Sales' is NULL;

SELECT(*)
FROM sales.sales_case_study_2
WHERE 'Quantity Sold' is NULL;

--------------------------------------------------------------------------
--1. What is the daily sales price per unit?
SELECT
  Date,
  Sales,
  `Quantity Sold`,
  Sales / `Quantity Sold` AS sales_price_per_unit
FROM sales.sales_case_study_2;

--------------------------------------------------------------------------
--2. What is the average unit sales price of this product?
SELECT
  AVG(Sales / `Quantity Sold`) AS average_sales_price_per_unit
FROM sales.sales_case_study_2;

--------------------------------------------------------------------------
--3. What is the daily % gross profit?
SELECT
  Date,
  Sales,
  `Cost Of Sales`,
  (Sales - `Cost Of Sales`) / Sales * 100 AS gross_profit_percentage
FROM sales.sales_case_study_2;

--------------------------------------------------------------------------
--4. What is the daily % gross profit per unit?

SELECT
  Date,
  Sales,
  `Cost Of Sales`,
  ((Sales - `Cost Of Sales`) / Sales * 100) / `Quantity Sold` AS gross_profit_percentage_per_unit
FROM sales.sales_case_study_2;

--------------------------------------------------------------------------
--5. Pick any 3 periods during which this product was on promotion/special: What was the Price Elasticity of Demand during each of these periods?  
--In your opinion, does this product perform better or worse when sold at a promotional price?

-- Step 1: Identify 3 periods with significant price drops (potential promotions)

WITH price_per_unit AS (
  SELECT
    Date,
    Sales,
    `Quantity Sold`,
    Sales / `Quantity Sold` AS unit_price
  FROM sales.sales_case_study_2
);

promo_periods AS (
  SELECT
    Date,
    unit_price,
    `Quantity Sold`,
    LAG(unit_price) OVER (ORDER BY Date) AS previous_unit_price,
    LAG(`Quantity Sold`) OVER (ORDER BY Date) AS previous_quantity_sold
  FROM price_per_unit
);

-- Select 3 periods with largest price drops
selected_promos AS (
  SELECT
    Date,
    unit_price,
    previous_unit_price,
    `Quantity Sold`,
    previous_quantity_sold,
    (previous_unit_price - unit_price) AS price_drop
  FROM promo_periods
  WHERE previous_unit_price IS NOT NULL
  ORDER BY price_drop DESC
  LIMIT 3
);

SELECT
  Date,
  previous_unit_price AS price_before,
  unit_price AS price_after,
  previous_quantity_sold AS quantity_before,
  `Quantity Sold` AS quantity_after,

  -- Calculate % change in quantity and price
  (quantity_after - quantity_before) / quantity_before AS percentage_change_quantity,
  (price_after - price_before) / price_before AS percentage_change_price,
  
  -- Price Elasticity of Demand formula
  ((quantity_after - quantity_before) / quantity_before) / ((price_after - price_before) / price_before) AS price_elasticity_of_demand
FROM selected_promos;

----

WITH price_per_unit AS (
  SELECT
    Date,
    Sales,
    `Quantity Sold`,
    Sales / `Quantity Sold` AS unit_price
  FROM sales.sales_case_study_2
),
promo_periods AS (
  SELECT
    Date,
    unit_price,
    `Quantity Sold`,
    LAG(unit_price) OVER (ORDER BY Date) AS previous_unit_price,
    LAG(`Quantity Sold`) OVER (ORDER BY Date) AS previous_quantity_sold
  FROM price_per_unit
),
-- Select 3 periods with largest price drops
selected_promos AS (
  SELECT
    Date,
    unit_price,
    previous_unit_price,
    `Quantity Sold`,
    previous_quantity_sold,
    (previous_unit_price - unit_price) AS price_drop
  FROM promo_periods
  WHERE previous_unit_price IS NOT NULL
  ORDER BY price_drop DESC
  LIMIT 3
)
SELECT
  Date,
  previous_unit_price AS price_before,
  unit_price AS price_after,
  previous_quantity_sold AS quantity_before,
  `Quantity Sold` AS quantity_after,
  (quantity_after - quantity_before) / quantity_before AS percentage_change_quantity,
  (price_after - price_before) / price_before AS percentage_change_price,
  ((quantity_after - quantity_before) / quantity_before) / ((price_after - price_before) / price_before) AS price_elasticity_of_demand
FROM selected_promos;

----------------------------------------------------------------------------- In your opinion, does this product perform better or worse when sold at a promotional price?
-- (Interpretation: If PED < -1, demand is elastic and sales increase significantly with price cuts; if PED > -1, demand is inelastic.)


WITH price_per_unit AS (
  SELECT
    Date,
    Sales,
    `Quantity Sold`,
    Sales / `Quantity Sold` AS unit_price
  FROM sales.sales_case_study_2
),
promo_periods AS (
  SELECT
    Date,
    unit_price,
    `Quantity Sold`,
    LAG(unit_price) OVER (ORDER BY Date) AS previous_unit_price,
    LAG(`Quantity Sold`) OVER (ORDER BY Date) AS previous_quantity_sold
  FROM price_per_unit
),
price_drop_periods AS (
  SELECT
    Date,
    unit_price,
    previous_unit_price,
    `Quantity Sold`,
    previous_quantity_sold,
    (previous_unit_price - unit_price) AS price_drop,
    (unit_price - previous_unit_price) / previous_unit_price AS pct_change_price,
    (`Quantity Sold` - previous_quantity_sold) / previous_quantity_sold AS pct_change_quantity
  FROM promo_periods
  WHERE previous_unit_price IS NOT NULL AND unit_price < previous_unit_price
)
SELECT
  COUNT(*) AS promotions,
  AVG(
    pct_change_quantity / NULLIF(pct_change_price, 0)
  ) AS avg_price_elasticity_of_demand,
  CASE
    WHEN AVG(pct_change_quantity / NULLIF(pct_change_price, 0)) < -1 THEN 'Performs better (elastic demand)'
    ELSE 'Performs worse or inelastic'
  END AS performance_during_promos
FROM price_drop_periods;

---------------------------------------------------------------------------6. Please derive any other interesting insight you can from the dataset provided. This can include: Interesting visuals 
--Reports
--Dashboards
--KPIs or metrics
--6. Additional Insights: Monthly Sales Trend, Gross Profit, and Top Sales Days

-- A. Monthly Sales and Gross Profit Trend
SELECT
  DATE_TRUNC('month', Date) AS month,
  SUM(Sales) AS total_sales,
  SUM(`Cost Of Sales`) AS total_cost,
  SUM(Sales - `Cost Of Sales`) AS gross_profit,
  SUM(Sales - `Cost Of Sales`) / SUM(Sales) * 100 AS gross_profit_margin_pct
FROM sales.sales_case_study_2
GROUP BY DATE_TRUNC('month', Date)
ORDER BY month;

-- B. Top 5 Days with Highest Sales
SELECT
  Date,
  Sales,
  `Quantity Sold`,
  Sales / `Quantity Sold` AS unit_price
FROM sales.sales_case_study_2
ORDER BY Sales DESC
LIMIT 5;

-- C. Days with Negative or Zero Gross Profit (Potential Losses)
SELECT
  Date,
  Sales,
  `Cost Of Sales`,
  (Sales - `Cost Of Sales`) AS gross_profit
FROM sales.sales_case_study_2
WHERE (Sales - `Cost Of Sales`) <= 0
ORDER BY Date;

-- D. KPI: Overall Gross Profit Margin
SELECT
  SUM(Sales - `Cost Of Sales`) / SUM(Sales) * 100 AS overall_gross_profit_margin_percentage
FROM sales.sales_case_study_2;

-- E. KPI: Average Daily Quantity Sold
SELECT
  AVG(`Quantity Sold`) AS average_daily_quantity_sold
FROM sales.sales_case_study_2;
