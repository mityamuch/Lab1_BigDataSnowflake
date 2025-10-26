-- Вставляем факты продаж
INSERT INTO sales (
    customer_id, seller_id, product_id, date_id, 
    quantity, total_price, original_sale_id
)
SELECT 
    c.customer_id,
    s.seller_id,
    p.product_id,
    dd.date_id,
    md.sale_quantity,
    md.sale_total_price,
    md.id
FROM mock_data md
LEFT JOIN customers c ON md.customer_email = c.email 
    AND md.customer_first_name = c.first_name 
    AND md.customer_last_name = c.last_name
LEFT JOIN sellers s ON md.seller_email = s.email 
    AND md.seller_first_name = s.first_name 
    AND md.seller_last_name = s.last_name
LEFT JOIN products p ON md.product_name = p.product_name
LEFT JOIN date_dim dd ON md.sale_date::DATE = dd.sale_date
WHERE md.sale_quantity IS NOT NULL AND md.sale_total_price IS NOT NULL;