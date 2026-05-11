
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