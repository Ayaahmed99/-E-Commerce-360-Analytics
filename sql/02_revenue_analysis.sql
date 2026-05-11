
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