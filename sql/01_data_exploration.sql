--Exploring Data Tables
/*
SELECT * FROM olist_customers
SELECT * FROM olist_orders
SELECT * FROM olist_order_items
SELECT * FROM olist_order_payments
SELECT * FROM olist_order_reviews
SELECT * FROM olist_products
SELECT * FROM olist_sellers
SELECT * FROM olist_geolocation
SELECT * FROM product_category_name_translation
*/
-------------------------------------------------
--Basic Data Exploratioin
-- How many orders per status?
SELECT order_status, COUNT(*) as order_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as pct
FROM olist_orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Date range of the dataset
SELECT MIN(order_purchase_timestamp) as first_order,
       MAX(order_purchase_timestamp) as last_order,
       COUNT(DISTINCT customer_id) as unique_customers
FROM olist_orders;
--------------------------------------------------

--Revenue Analysis
-- Monthly revenue trend
SELECT
    DATETRUNC(month, o.order_purchase_timestamp) as Month,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) as gross_revenue,
    ROUND(AVG(oi.price + oi.freight_value), 2) as avg_order_value
FROM olist_orders o
JOIN olist_order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATETRUNC(month, o.order_purchase_timestamp)
ORDER BY DATETRUNC(month, o.order_purchase_timestamp);

-- Revenue by payment type
SELECT
    p.payment_type,
    COUNT(DISTINCT p.order_id) as orders,
    ROUND(SUM(p.payment_value), 2) as total_revenue,
    ROUND(AVG(p.payment_installments), 1) as avg_installments
FROM olist_order_payments p
GROUP BY payment_type
ORDER BY total_revenue DESC;
--------------------------------------------------
--Custometers Segmentation 
-- Customers by state (top 10)
SELECT TOP 10
    c.customer_state,
    COUNT(DISTINCT c.customer_id) as customers,
    ROUND(SUM(oi.price), 2) as revenue,
    ROUND(AVG(oi.price), 2) as avg_spend
FROM olist_customers c
JOIN olist_orders o ON c.customer_id = o.customer_id
JOIN olist_order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC;
--------------------------------------------------
--Product Performance 
-- Top 10 categories by revenue
SELECT TOP 10
    t.product_category_name_english AS category_english,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(AVG(rev.review_score), 2) AS avg_review_score
FROM olist_order_items oi
JOIN olist_products p 
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t 
    ON p.product_category_name = t.product_category_name
LEFT JOIN olist_order_reviews rev 
    ON oi.order_id = rev.order_id
GROUP BY t.product_category_name_english
ORDER BY revenue DESC;
-------------------------------------------------------------

--Delievery Performance
-- Average delivery time vs estimate, by state
WITH delivery_stats AS (
    SELECT
        c.customer_state,
        DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) AS actual_days,
        DATEDIFF(day, o.order_purchase_timestamp, o.order_estimated_delivery_date) AS estimated_days,
        DATEDIFF(day, o.order_delivered_customer_date, o.order_estimated_delivery_date) AS days_diff
    FROM olist_orders o
    JOIN olist_customers c 
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
)

SELECT
    customer_state,
    COUNT(*) AS total_deliveries,

    ROUND(AVG(actual_days), 1) AS avg_actual_days,
    ROUND(AVG(estimated_days), 1) AS avg_estimated_days,
    ROUND(AVG(days_diff), 1) AS avg_days_early_or_late,

    -- % Late deliveries
    ROUND(100.0 * SUM(CASE WHEN days_diff < 0 THEN 1 ELSE 0 END) / COUNT(*), 2) 
        AS pct_late,

    -- % Early deliveries
    ROUND(100.0 * SUM(CASE WHEN days_diff > 0 THEN 1 ELSE 0 END) / COUNT(*), 2) 
        AS pct_early,

    -- % On-time deliveries
    ROUND(100.0 * SUM(CASE WHEN days_diff = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) 
        AS pct_on_time,

    -- Avg delay only for late deliveries
    ROUND(AVG(CASE WHEN days_diff < 0 THEN ABS(days_diff) END), 1) 
        AS avg_late_days

FROM delivery_stats
GROUP BY customer_state
ORDER BY pct_late DESC;