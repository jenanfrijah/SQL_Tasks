
-- CREATING DATABASE

CREATE DATABASE E_Commerce;
USE E_Commerce;


-- CREATING USERS TABLE

CREATE TABLE  users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    location VARCHAR(100)
);


-- CREATING CATEGORIES TABLE

CREATE TABLE  categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);


-- CREATING PRODUCTS TABLE

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


-- CREATING ORDERS TABLE

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- CREATING ORDER_ITEMS TABLE

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) AS (quantity * unit_price) STORED,
    product_id INT,
    order_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- DML: 

-- Insert users
INSERT INTO users (first_name, last_name, email, location) VALUES
('Ali', 'Yousef', 'aliyousef@gmail.com', 'Amman - Abdali'),
('Lara', 'Khalid', 'lara1@gmail.com', 'Irbid'),
('Sara', 'Waleed', 'sara1@gmail.com', 'Zarqa');

-- Insert categories
INSERT INTO categories (category_name, description) VALUES
('electronics', 'Devices and gadgets'),
('toys', 'Children toys and games'),
('books', 'All kinds of books');

-- Insert products
INSERT INTO products (product_name, price, description, category_id) VALUES
('Tooth brush', 3.5, 'A small toothbrush designed for gentle and effective daily cleaning.', 1),
('Dress', 15.8, 'A simple, elegant dress perfect for any occasion.', 2),
('Ring', 78.7, 'A delicate ring with a timeless, elegant design.', 3);

-- Insert orders
INSERT INTO orders (status, total_amount, shipping_address, user_id) VALUES
('pending', 20.00, 'Amman-abdali', 1),
('shipped', 42.00, 'Irbid', 2),
('shipped', 72.00, 'Zarqa', 3);

-- Insert order items
INSERT INTO order_items (quantity, unit_price, product_id, order_id) VALUES
(5, 2.5, 1, 1),
(7, 4.20, 1, 2),
(3, 2.8, 2, 3);


-- DML: UPDATE / DELETE

-- Update a product description
UPDATE products
SET description = 'A compact toothbrush for precise cleaning and easy handling.'
WHERE product_id = 1;

-- DELETE a order_item

DELETE FROM order_items WHERE product_id = 2;

DELETE FROM products WHERE product_id = 2;


-- SELECT Queries 

-- Select all products
SELECT * FROM products;

-- Select all users
SELECT * FROM users;

-- Join orders with users
SELECT o.order_id, u.user_id, u.first_name, u.last_name
FROM orders o
JOIN users u ON o.user_id = u.user_id;

-- Filter products using where 
SELECT product_name FROM products WHERE product_id = 2;

-- Sort users by first_name using order by
SELECT location, first_name, last_name FROM users ORDER BY first_name;

-- Limit results using limit 
SELECT first_name, last_name FROM users LIMIT 1;

-- Aggregate functions
SELECT COUNT(order_id) AS total_orders FROM orders;
SELECT AVG(subtotal) AS total_avg FROM order_items;

-- Left Join 
SELECT o.order_id, u.user_id, u.first_name
FROM orders o
LEFT JOIN users u ON o.user_id = u.user_id;

-- Inner Join 
SELECT c.category_id, c.category_name, p.product_name
FROM categories c
JOIN products p ON p.category_id = c.category_id;
