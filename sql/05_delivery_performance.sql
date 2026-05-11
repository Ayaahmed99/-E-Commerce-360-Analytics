
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