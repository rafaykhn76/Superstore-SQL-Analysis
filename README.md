# Superstore Sales Analysis — SQL Project

## 📊 Project Overview

This project analyzes the Superstore dataset using SQL to identify
sales performance, profitability, customer performance, product
performance, and other business insights.

The project contains 20 SQL analysis questions covering basic,
intermediate, and advanced SQL concepts.

---

## 🛠️ Tools Used

- MySQL
- MySQL Workbench
- SQL

---

## 📂 Dataset

The analysis was performed using the Superstore sales dataset.

The dataset contains information about:

- Orders
- Customers
- Products
- Categories
- Sales
- Profit
- Quantity
- Discounts
- Regions
- Markets
- Shipping modes
- Order priorities

---

## 🎯 Project Objectives

The main objectives of this project were to:

- Analyze overall sales and profitability
- Identify high-performing categories and sub-categories
- Find top customers by sales and profit
- Identify top-performing products
- Compare regional and market performance
- Analyze yearly sales and profit
- Analyze shipping modes and order priorities
- Analyze discounts and quantity sold
- Identify products generating negative profit
- Compare customer sales against average customer sales
- Rank products within each category

---

## 🔎 SQL Questions

The project answers the following 20 business questions:

1. What is the total sales, total profit, and average sales across the entire dataset?
2. Which product category generates the highest sales and profit?
3. Which sub-categories generate the highest sales and profit?
4. Which top 10 customers generate the highest total sales?
5. Which 10 customers generate the highest total profit?
6. Which regions generate the highest total sales and profit?
7. Which markets generate the highest total sales and profit?
8. Which 10 products generate the highest total sales?
9. Which 10 products generate the highest total profit?
10. How did total sales change across different years?
11. How did total profit change across different years?
12. Which shipping modes are used most frequently?
13. How many orders are there for each order priority?
14. What is the average discount offered for each product category?
15. Which product categories have the highest total quantity sold?
16. Which categories have total sales greater than 1,000,000?
17. Which sub-categories have total profit greater than 50,000?
18. Which products have a negative total profit?
19. Which customers have total sales greater than the average customer sales?
20. How can products be ranked by total sales within each category?

---

## 💡 SQL Concepts Demonstrated

This project demonstrates practical use of:

- `SELECT`
- `SUM()`
- `AVG()`
- `COUNT()`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- `HAVING`
- Subqueries
- Nested subqueries
- Aggregate functions
- Window functions
- `RANK()`
- `PARTITION BY`
- Column aliases
- Filtering aggregated results

---

## 📈 Advanced SQL

The final question uses a window function to rank products
within each category based on total sales.

```sql
RANK() OVER (
    PARTITION BY category
    ORDER BY Total_Sales DESC
)