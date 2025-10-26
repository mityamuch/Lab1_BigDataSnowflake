-- Вставляем категории питомцев
INSERT INTO pet_categories (pet_type)
SELECT DISTINCT customer_pet_type 
FROM mock_data 
WHERE customer_pet_type IS NOT NULL
ON CONFLICT (pet_type) DO NOTHING;

-- Вставляем поставщиков
INSERT INTO suppliers (
    supplier_name, supplier_contact, supplier_email, 
    supplier_phone, supplier_address, supplier_city, supplier_country
)
SELECT DISTINCT 
    supplier_name, supplier_contact, supplier_email,
    supplier_phone, supplier_address, supplier_city, supplier_country
FROM mock_data 
WHERE supplier_name IS NOT NULL
ON CONFLICT DO NOTHING;

-- Вставляем магазины
INSERT INTO stores (
    store_name, store_location, store_city, 
    store_state, store_country, store_phone, store_email
)
SELECT DISTINCT 
    store_name, store_location, store_city,
    store_state, store_country, store_phone, store_email
FROM mock_data 
WHERE store_name IS NOT NULL
ON CONFLICT DO NOTHING;

-- Вставляем покупателей
INSERT INTO customers (
    first_name, last_name, age, email, country, postal_code,
    pet_category_id, pet_name, pet_breed
)
SELECT DISTINCT 
    md.customer_first_name,
    md.customer_last_name,
    md.customer_age,
    md.customer_email,
    md.customer_country,
    md.customer_postal_code,
    pc.pet_category_id,
    md.customer_pet_name,
    md.customer_pet_breed
FROM mock_data md
LEFT JOIN pet_categories pc ON md.customer_pet_type = pc.pet_type
WHERE md.customer_first_name IS NOT NULL AND md.customer_last_name IS NOT NULL
ON CONFLICT DO NOTHING;

-- Вставляем продавцов
INSERT INTO sellers (
    first_name, last_name, email, country, postal_code, store_id
)
SELECT DISTINCT 
    md.seller_first_name,
    md.seller_last_name,
    md.seller_email,
    md.seller_country,
    md.seller_postal_code,
    s.store_id
FROM mock_data md
LEFT JOIN stores s ON md.store_name = s.store_name
WHERE md.seller_first_name IS NOT NULL AND md.seller_last_name IS NOT NULL
ON CONFLICT DO NOTHING;

-- Вставляем продукты
INSERT INTO products (
    product_name, product_category, price, weight, color, size,
    brand, material, description, rating, reviews, release_date,
    expiry_date, supplier_id, pet_category_id
)
SELECT DISTINCT 
    md.product_name,
    md.product_category,
    md.product_price,
    md.product_weight,
    md.product_color,
    md.product_size,
    md.product_brand,
    md.product_material,
    md.product_description,
    md.product_rating,
    md.product_reviews,
    md.product_release_date::DATE,
    md.product_expiry_date::DATE,
    sup.supplier_id,
    pc.pet_category_id
FROM mock_data md
LEFT JOIN suppliers sup ON md.supplier_name = sup.supplier_name
LEFT JOIN pet_categories pc ON md.pet_category = pc.pet_type
WHERE md.product_name IS NOT NULL
ON CONFLICT DO NOTHING;

-- Заполняем таблицу дат
INSERT INTO date_dim (sale_date, day, month, year, quarter, day_of_week)
SELECT DISTINCT 
    sale_date::DATE,
    EXTRACT(DAY FROM sale_date::DATE),
    EXTRACT(MONTH FROM sale_date::DATE),
    EXTRACT(YEAR FROM sale_date::DATE),
    EXTRACT(QUARTER FROM sale_date::DATE),
    EXTRACT(DOW FROM sale_date::DATE)
FROM mock_data 
WHERE sale_date IS NOT NULL
ON CONFLICT DO NOTHING;