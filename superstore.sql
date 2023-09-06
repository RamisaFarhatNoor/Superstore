use global_superstore;

SELECT * FROM superstore;

SELECT 
    *
FROM
    superstore
ORDER BY 1;

-- Making sure if the order date is less than shipping date

SELECT 
    COUNT(*)
FROM
    superstore
WHERE
    order_date <= ship_date;
    
-- Result: the row count is the number of records in the dataset 


-- Cecking in=f the order ids are unique or not (primary key)

SELECT 
    order_id, COUNT(*) AS order_id_count
FROM
    superstore
GROUP BY order_id
HAVING order_id_count > 1;

-- Result: Not a primary key
SELECT 
    row_ID, order_id, COUNT(*) AS counts
FROM
    superstore
GROUP BY row_id , order_id
HAVING counts > 1;

-- Result: if needed the combination of row_ID and Order_ID as the compostie primary key

-- Average days to ship for each orderpriority

SELECT
    order_priority,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 2) AS average_days_to_ship
FROM
    superstore
GROUP BY
    order_priority
ORDER BY 
	average_days_to_ship;

-- Which regions bring the most profits?

SELECT 
    region, SUM(profit) AS sum_profit
FROM
    superstore
GROUP BY region
ORDER BY sum_profit DESC;

-- Top global products

SELECT 
    Sub_Category, product_id, SUM(quantity) AS total_quantities
FROM
    superstore
GROUP BY product_id , Sub_Category
ORDER BY total_quantities DESC;

-- Which Category brings the most sales and profits>

SELECT 
    category,
    SUM(sales) AS total_sale,
    SUM(profit) AS total_profit
FROM
    superstore
GROUP BY category
ORDER BY total_sale , total_profit;

-- Sales by market
SELECT 
    market, SUM(sales) AS total_sales
FROM
    superstore
GROUP BY market
ORDER BY total_sales DESC;

-- Net Profit margin of each customers
SELECT
    customer_id,
    (SUM(profit) / SUM(sales)) * 100 AS net_profit_margin
FROM
    superstore
GROUP BY
    customer_id
ORDER BY
    net_profit_margin DESC;



-- Total Orders by Order Priority in every country

SELECT 
    country, order_priority, COUNT(*) AS order_priority_count
FROM
    superstore
GROUP BY country , order_priority;

-- Total Orders by Ship Moder in every country

SELECT 
    country, ship_mode, COUNT(*) AS ship_mode_count
FROM
    superstore
GROUP BY country , ship_mode;



-- Customer repeats

SELECT 
    customer_id, country, region, COUNT(*) AS customer_repeats
FROM
    superstore
GROUP BY customer_id , country , region
ORDER BY customer_id;

-- Minimum and maximum shipping date for every ship mode

SELECT
    ship_mode,
    MIN(num_of_days) AS min_num_of_days,
    MAX(num_of_days) AS max_num_of_days
FROM
    (
        SELECT
            ship_mode,
            DATEDIFF(ship_date, order_date) AS num_of_days
        FROM
            superstore
    ) AS subquery_alias
GROUP BY
    ship_mode;

-- NUMBER OF EACH SEGMENTS IN EVERY COUNTRY AND THE SALES 
SELECT 
    country,
    segment,
    COUNT(*) AS segment_counts,
    SUM(sales) AS total_sales
FROM
    superstore
GROUP BY country , segment;


