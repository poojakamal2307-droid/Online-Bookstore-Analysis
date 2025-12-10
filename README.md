# 📚 Online Bookstore Management System (SQL Project)

This project is a complete relational database system built to manage an online bookstore.  
It includes features like customer management, book inventory, order processing, stock updates, and reporting using SQL.

---

## ✅ Project Objectives

✔ Design a bookstore database  
✔ Manage books, customers, staff & orders  
✔ Automate stock updates using triggers  
✔ Perform sales & order insights using SQL queries  
✔ Practice indexing, stored procedures, and views  

---

## 🏗 Database & Table Structure

📌 **Database Used:** `Bookp_db`

### 📍 Tables Created:
| Table Name | Purpose |
|-----------|---------|
| customers | Stores customer personal details |
| books | Contains book info & stock levels |
| orders | Order summary (customer & date) |
| order_details | Book items purchased in each order |
| staff | Employee details (renamed from employees) |

---

## 🎯 CRUD Operations Performed

✔ Inserted sample records into all tables  
✔ Updated table structure using `ALTER`  
✔ Renamed table using `RENAME TABLE`  
✔ Validated email & duplicate detection  
✔ Filter queries using `WHERE`, `IN`, and `LIKE`

---

## 📊 SQL Analysis Included

| Analysis Category | Queries Performed |
|---|---|
| Sales Insights | Revenue per order |
| Inventory Checks | Low stock books |
| Customer Analytics | Order history, duplicate accounts |
| Book Performance | Best-selling books (quantity sold) |

🔹 Aggregate functions used:  
`SUM`, `AVG`, `MIN`, `MAX`, `COUNT`

🔹 Joins Used:  
`INNER JOIN`, `LEFT JOIN`

---

## ⚙️ Advanced SQL Features

| Feature | Purpose |
|--------|---------|
| Triggers | ✅ Auto stock update & negative stock prevention |
| Stored Procedures | ✅ Customer orders, stock update, low-stock list |
| Indexing | ✅ Performance improvement |
| Views | ✅ Quick reporting |
| Foreign Keys | ✅ Relationship integrity |

---

## 🧠 Stored Procedures Created
- `GetCustomerOrders()` → Fetches order history of a customer
- `UpdateBookStock()` → Updates stock level
- `LowStockBooks()` → Shows books below stock threshold

---

## 🚦 Triggers Implemented
| Trigger Name | Action |
|---|---|
| `trg_after_order_insert` | Decreases stock when new order placed |
| `trg_before_order_insert` | Prevents order if stock not enough |

---

## 🔍 Views for Reporting
- `view_customer_orders` → Customer | Book | Total Price | Date
- `view_low_stock_books` → Books with less than 5 stock

---

## 🛠 Tools Used
- MySQL / MariaDB
- MySQL Workbench / DBeaver

---

## 📂 Repository Files

| File | Description |
|------|-------------|
| `bookstore_project.sql` | SQL schema, data & analysis |
| `README.md` | Documentation file (this file) |

---

## ✅ Project Outcome

This project demonstrates end-to-end SQL skills including:

✔ Database modeling & constraints  
✔ Joining multiple tables  
✔ Sales reporting & inventory analytics  
✔ Automations through triggers  
✔ Industry-level stored procedures  


