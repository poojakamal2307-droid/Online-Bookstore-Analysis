CREATE DATABASE IF NOT EXISTS Bookp_db;
USE Bookp_db;

-- TABLES
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(8,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100),
    city VARCHAR(50)
);


INSERT INTO customers (first_name, last_name, email, city) VALUES
('John', 'Doe', 'john@example.com', 'Mumbai'),
('Jane', 'Smith', 'jane@example.com', 'Delhi'),
('Amit', 'Verma', 'amit@example.com', 'Mumbai'),
('Sara', 'Khan', 'sara@example.com', 'Chennai'),
('John', 'Doe', 'john@example.com', 'Mumbai'); 

INSERT INTO books (title, author, genre, price, stock) VALUES
('SQL Mastery', 'Alan Doe', 'Education', 499.99, 10),
('Learn Python', 'Linda Ray', 'Programming', 599.00, 5),
('HTML & CSS', 'Mark Otto', 'Web', 350.00, 20),
('Java Basics', 'Sun Dev', 'Programming', 700.00, 2),
('Data Science 101', 'Nina Data', 'Data', 999.00, 1);

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2025-07-01'),
(2, '2025-07-02'),
(1, '2025-07-05');
    
INSERT INTO order_details (order_id, book_id, quantity)
VALUES 
    (1, 4, 2),
    (2, 3, 1),
    (3, 5, 2);

INSERT INTO employees (emp_name, city) VALUES
('Ravi Kumar', 'Mumbai'),
('Anjali Mehra', 'Delhi');


SELECT * FROM customers;
SELECT * FROM books;
SELECT * FROM orders;
SELECT * FROM order_details; 
SELECT * FROM employees;

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customers;

SELECT DISTINCT city FROM customers;

SELECT * FROM customers WHERE city IN ('Delhi', 'Mumbai');

SELECT b.title, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN books b ON od.book_id = b.book_id
GROUP BY b.title;

SELECT AVG(price) AS average_price FROM books;

SELECT email, COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

SELECT * FROM books WHERE price > 500;

-- Change stock column name
ALTER TABLE books CHANGE stock stock_quantity INT;

SELECT * FROM books WHERE stock_quantity < 10;

SELECT od.order_id, SUM(od.quantity * b.price) AS total_amount
FROM order_details od
JOIN books b ON od.book_id = b.book_id
GROUP BY od.order_id;

SELECT od.order_id, MIN(od.quantity * b.price) AS total_amount
FROM order_details od
JOIN books b ON od.book_id = b.book_id
GROUP BY od.order_id;

SELECT od.order_id, MAX(od.quantity * b.price) AS total_amount
FROM order_details od
JOIN books b ON od.book_id = b.book_id
GROUP BY od.order_id;

SELECT b.title
FROM books b
LEFT JOIN order_details od ON b.book_id = od.book_id
WHERE od.book_id IS NULL;

-- Employees table updates
ALTER TABLE employees ADD COLUMN email VARCHAR(100);
RENAME TABLE employees TO staff;

-- ❌ Removed invalid DROP TABLE bookstore_db (no such table)
-- DROP TABLE bookstore_db;   <-- removed

-- TRIGGER 1 – Update Stock After Order
DELIMITER $$

CREATE TRIGGER trg_after_order_insert
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE books
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE book_id = NEW.book_id;
END $$

DELIMITER ;

-- TRIGGER 2 – Prevent Negative Stock
DELIMITER $$

CREATE TRIGGER trg_before_order_insert
BEFORE INSERT ON order_details
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;

    SELECT stock_quantity INTO available_stock
    FROM books
    WHERE book_id = NEW.book_id;

    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough stock available!';
    END IF;
END $$

DELIMITER ;

-- PROCEDURE 1 – Get All Orders of a Customer
DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT o.order_id, o.order_date, b.title, od.quantity, (b.price * od.quantity) AS total_price
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN books b ON b.book_id = od.book_id
    WHERE o.customer_id = cust_id;
END $$

DELIMITER ;

CALL GetCustomerOrders(1);

-- PROCEDURE 2 – Update Book Stock
DELIMITER $$

CREATE PROCEDURE UpdateBookStock(IN bookId INT, IN newStock INT)
BEGIN
    UPDATE books
    SET stock_quantity = newStock
    WHERE book_id = bookId;
END $$

DELIMITER ;

CALL UpdateBookStock(2, 25);

-- PROCEDURE 3 – Show Low Stock Books
DELIMITER $$

CREATE PROCEDURE LowStockBooks()
BEGIN
    SELECT book_id, title, stock_quantity
    FROM books
    WHERE stock_quantity < 5;
END $$

DELIMITER ;

CALL LowStockBooks();

#index

CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_books_price ON books(price);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_details_quantity ON order_details(quantity);

#view

CREATE VIEW view_customer_orders AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    b.title AS book_title,
    od.quantity,
    (b.price * od.quantity) AS total_price,
    o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN books b ON od.book_id = b.book_id;

CREATE VIEW view_low_stock_books AS
SELECT book_id, title, stock_quantity
FROM books
WHERE stock_quantity < 5;

SELECT * FROM view_customer_orders;
SELECT * FROM view_low_stock_books;

