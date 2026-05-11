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