# 🛒 E-Commerce SQL Analytics

A SQL-based data analysis project built on a synthetic E-Commerce database. This project demonstrates SQL skills by analyzing sales, customers, and products to generate meaningful business insights.

## 📖 Project Overview

The goal of this project is to analyze an e-commerce database using SQL and answer common business questions through well-structured queries.

The project covers:

- Sales Analysis
- Customer Analysis
- Product Analysis
- Database Views
- Foreign Key Constraints
- Query Optimization using Indexes

---

## 📂 Project Structure

```
Ecommerce-SQL-Analytics/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── Database/
│   ├── ForeignKeys.sql
│   ├── Indexes.sql
│   └── Views.sql
│
├── Analysis/
│   ├── Sales Analysis.sql
│   ├── Customer Analysis.sql
│   └── Product Analysis.sql
│
└── Dataset/
    ├── addresses.csv
    ├── categories.csv
    ├── customers.csv
    ├── order_items.csv
    ├── orders.csv
    ├── payments.csv
    ├── products.csv
    ├── reviews.csv
    ├── shipments.csv
    ├── suppliers.csv
```

---

## 🗄 Database Tables

The dataset consists of the following tables:

| Table | Description |
|---------|-------------|
| customers | Customer information |
| addresses | Customer addresses |
| orders | Customer orders |
| order_items | Products within each order |
| products | Product details |
| categories | Product categories |
| suppliers | Supplier information |
| payments | Payment records |
| shipments | Shipment details |
| reviews | Customer reviews |

---

## 📊 Analysis Performed

### Sales Analysis

- Total Revenue
- Total Orders
- Average Order Value
- Monthly Sales Trend
- Highest Revenue Orders

### Customer Analysis

- Total Customers
- Customer Distribution
- Repeat Customers
- Top Spending Customers
- Customer Lifetime Value

### Product Analysis

- Best Selling Products
- Products by Category
- Products by Supplier
- Unsold Products
- Highest Revenue Products

---

## ⚡ SQL Concepts Used

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- Aggregate Functions
- CASE Statements
- Common Table Expressions (CTEs)
- Window Functions
- Views
- Foreign Keys
- Indexes

---

## 🛠 Technologies Used

- SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)

---

## 📁 Dataset

This project uses a synthetic e-commerce dataset containing:

- 3,000 Customers
- 8,000 Orders
- 19,636 Order Items
- 1,200 Products
- 8,000 Payments
- 6,435 Shipments
- Additional supporting tables

The dataset is included in the `Dataset` folder.

---

## 🚀 How to Use

1. Import the CSV files into your SQL Server database.
2. Create the required tables.
3. Execute the scripts in the `Database` folder.
4. Run the analysis queries from the `Analysis` folder.

---

## 🎯 Learning Outcomes

Through this project, I practiced:

- Writing complex SQL queries
- Working with relational databases
- Creating Views and Foreign Keys
- Optimizing queries with Indexes
- Performing business-oriented data analysis

---

## 👨‍💻 Author

**Your Name**

GitHub: https://github.com/your-username

LinkedIn: https://linkedin.com/in/your-profile

---

## 📄 License

This project is licensed under the MIT License.
