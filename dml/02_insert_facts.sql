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
LEFT JOIN customers c ON TRIM(LOWER(md.customer_email)) = TRIM(LOWER(c.email))
    AND TRIM(LOWER(md.customer_first_name)) = TRIM(LOWER(c.first_name))
    AND TRIM(LOWER(md.customer_last_name)) = TRIM(LOWER(c.last_name))
LEFT JOIN sellers s ON TRIM(LOWER(md.seller_email)) = TRIM(LOWER(s.email))
    AND TRIM(LOWER(md.seller_first_name)) = TRIM(LOWER(s.first_name))
    AND TRIM(LOWER(md.seller_last_name)) = TRIM(LOWER(s.last_name))
LEFT JOIN products p ON TRIM(LOWER(md.product_name)) = TRIM(LOWER(p.product_name))
LEFT JOIN date_dim dd ON md.sale_date::DATE = dd.sale_date
WHERE md.sale_quantity IS NOT NULL
  AND md.sale_total_price IS NOT NULL
  AND c.customer_id IS NOT NULL
  AND s.seller_id IS NOT NULL
  AND p.product_id IS NOT NULL
  AND dd.date_id IS NOT NULL;