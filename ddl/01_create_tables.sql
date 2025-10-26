-- Таблица категорий питомцев
CREATE TABLE IF NOT EXISTS pet_categories (
    pet_category_id SERIAL PRIMARY KEY,
    pet_type VARCHAR(100) UNIQUE NOT NULL
);

-- Таблица поставщиков
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    supplier_contact VARCHAR(255),
    supplier_email VARCHAR(255),
    supplier_phone VARCHAR(100),
    supplier_address TEXT,
    supplier_city VARCHAR(100),
    supplier_country VARCHAR(100)
);

-- Таблица магазинов
CREATE TABLE IF NOT EXISTS stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    store_location VARCHAR(255),
    store_city VARCHAR(100),
    store_state VARCHAR(100),
    store_country VARCHAR(100),
    store_phone VARCHAR(100),
    store_email VARCHAR(255)
);

-- Таблица покупателей
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    age INTEGER,
    email VARCHAR(255),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    pet_category_id INTEGER REFERENCES pet_categories(pet_category_id),
    pet_name VARCHAR(100),
    pet_breed VARCHAR(100)
);

-- Таблица продавцов
CREATE TABLE IF NOT EXISTS sellers (
    seller_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    store_id INTEGER REFERENCES stores(store_id)
);

-- Таблица продуктов
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_category VARCHAR(100),
    price DECIMAL(10,2),
    weight DECIMAL(10,2),
    color VARCHAR(50),
    size VARCHAR(50),
    brand VARCHAR(100),
    material VARCHAR(100),
    description TEXT,
    rating DECIMAL(3,2),
    reviews INTEGER,
    release_date DATE,
    expiry_date DATE,
    supplier_id INTEGER REFERENCES suppliers(supplier_id),
    pet_category_id INTEGER REFERENCES pet_categories(pet_category_id)
);

-- Таблица дат
CREATE TABLE IF NOT EXISTS date_dim (
    date_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    day_of_week INTEGER NOT NULL
);

-- Фактовая таблица продаж
CREATE TABLE IF NOT EXISTS sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    seller_id INTEGER REFERENCES sellers(seller_id),
    product_id INTEGER REFERENCES products(product_id),
    date_id INTEGER REFERENCES date_dim(date_id),
    quantity INTEGER NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    original_sale_id INTEGER
);