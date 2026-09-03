
DESCRIBE super_store_dataset;


# What is the total sales, total profit, and average sales across the entire Superstore dataset?

Select Sum(sales) As Total_sales , Sum(profit) AS Total_Profit ,
Avg(sales) as Average_sales from super_store_dataset;


# Which product category generates the highest sales and profit?

Select category ,
Sum(sales) As Total_sales , Sum(Profit) As Total_Profit
from super_store_dataset
Group by Category
Order by Total_sales DESC;


# Which sub-categories generate the highest sales and profit?

Select sub_category , 
sum(sales) AS Total_sales ,
Sum(Profit) As Total_Profit
from super_store_dataset
Group by sub_category
Order by Total_sales DESC ;

# Which top 10 customers generate the highest total sales?

SELECT customer_name,
SUM(sales) AS Total_sales
FROM super_store_dataset
GROUP BY customer_name
ORDER BY Total_sales DESC
LIMIT 10;

# Which 10 customers generate the highest total profit?

Select customer_name ,
sum(Profit) AS Total_Profit
from super_store_dataset
Group by customer_name
order by Total_Profit DESC 
limit 10;

# Which regions generate the highest total sales and profit?

Select region ,
Sum(sales) AS Total_sales,
sum(Profit) AS Total_Profit
from super_store_dataset
Group by region
order by Total_sales DESC;

# Which markets generate the highest total sales and total profit?

Select market ,
Sum(sales) AS Total_sales,
sum(Profit) AS Total_Profit
from super_store_dataset
Group by market
order by Total_sales DESC;

# Which 10 products generate the highest total sales?

Select product_name ,
Sum(sales) AS Total_sales
from super_store_dataset
Group by product_name
order by Total_sales DESC
Limit 10;


# Which 10 products generate the highest total profit?

Select product_name ,
Sum(profit) AS Total_Profit
from super_store_dataset
Group by product_name
order by Total_Profit DESC
Limit 10;


# How did total sales change across different years?

Select year , sum(sales) AS Total_sales 
from super_store_dataset
Group by year 
Order by year ;

# How did total profit change across different years?

Select year , sum(profit) AS Total_Profit
from super_store_dataset
group by year
order by year ;

# Which shipping modes are used most frequently?

SELECT ship_mode, COUNT(DISTINCT order_number) AS Total_Orders
FROM super_store_dataset
GROUP BY ship_mode
ORDER BY Total_Orders DESC;

# How many orders are there for each order priority?

Select order_priority , COUNT(DISTINCT order_number) AS Total_Orders
from super_store_dataset
group by order_priority
order by Total_orders DESC ;

# What is the average discount offered for each product category?

Select category , avg(discount) AS Average_discount
from super_store_dataset
group by Category
order by Average_discount DESC ;


# Which product categories have the highest total quantity sold?

Select category ,  Sum(quantity) As Total_Quantity
from super_store_dataset
Group by category
order by Total_Quantity DESC ;


# Which categories have total sales greater than 1,000,000?

Select category , sum(sales) As total_sales
from super_store_dataset
group by category
HAVING SUM(sales) > 1000000
order by total_sales DESC ;


# Which sub-categories have total profit greater than 50,000?

Select sub_category,
Sum(profit) As Total_Profit
from super_store_dataset
group by sub_category
having sum(profit) > 50000
Order by Total_Profit DESC ;

# Which products have a negative total profit?

Select product_name , 
sum(profit) AS Total_Profit
from super_store_dataset
group by product_name
Having sum(profit) < 0
order by Total_Profit DESC ;

# Which customers have total sales greater than the average customer sales?

SELECT 
    customer_name,
    SUM(sales) AS Total_Sales
FROM super_store_dataset
GROUP BY customer_name
HAVING SUM(sales) >
(
    SELECT AVG(Total_Sales)
    FROM (
        SELECT 
            customer_name,
            SUM(sales) AS Total_Sales
        FROM super_store_dataset
        GROUP BY customer_name
    ) AS Customer_sales
)
ORDER BY Total_Sales DESC;

# Within each category, rank the products by their total sales, with the highest-selling product ranked #1. 

SELECT 
    category,
    product_name,
    SUM(sales) AS Total_Sales,
    RANK() OVER (
        PARTITION BY category 
        ORDER BY SUM(sales) DESC
    ) AS Sales_Rank
FROM super_store_dataset
GROUP BY category, product_name
ORDER BY category, Sales_Rank;


# For each customer, assign a row number to their orders
# based on sales from highest to lowest.

SELECT customer_name,order_number, sales,
ROW_NUMBER() OVER (PARTITION BY customer_name ORDER BY sales DESC) AS Row_Num
FROM super_store_dataset
ORDER BY customer_name, Row_Num;


# For each customer, rank their orders by sales
# from highest to lowest.

SELECT customer_name,order_number,sales,
RANK() OVER (PARTITION BY customer_name ORDER BY sales DESC) AS Sales_Rank
FROM super_store_dataset
ORDER BY customer_name, Sales_Rank;


# Rank customers by their total sales.

SELECT customer_name,SUM(sales) AS Total_Sales,
RANK() OVER (ORDER BY SUM(sales) DESC) AS Sales_Rank
FROM super_store_dataset
GROUP BY customer_name
ORDER BY Sales_Rank;


# Find the highest-sales order for each customer.

WITH Customer_Orders AS
(
SELECT customer_name, order_number, sales,
ROW_NUMBER() OVER ( PARTITION BY customer_name ORDER BY sales DESC) AS Row_Num
FROM super_store_dataset
)
SELECT customer_name, order_number,sales
FROM Customer_Orders
WHERE Row_Num = 1
ORDER BY customer_name;

# Show the top 3 highest-sales orders for each customer.

WITH Customer_Orders AS
(
SELECT customer_name, order_number, sales,
ROW_NUMBER() OVER ( PARTITION BY customer_name ORDER BY sales DESC) AS Row_Num
FROM super_store_dataset
)
SELECT customer_name, order_number, sales, Row_Num
FROM Customer_Orders
WHERE Row_Num <= 3
ORDER BY customer_name, Row_Num;


# Show each order along with the average sales for that customer.

SELECT customer_name, order_number, sales,
AVG(sales) OVER ( PARTITION BY customer_name ) AS Customer_Avg_Sales
FROM super_store_dataset
ORDER BY customer_name, order_number;


# Show a running total of sales for each customer,
# ordered by order date.

SELECT customer_name, order_number, order_date, sales,
SUM(sales) OVER ( PARTITION BY customer_name ORDER BY order_date, order_number
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total_Sales
FROM super_store_dataset
ORDER BY customer_name, order_date, order_number;


# Find the lowest-sales order for each customer.

WITH Customer_Orders AS
(
SELECT customer_name, order_number, sales,
ROW_NUMBER() OVER ( PARTITION BY customer_name ORDER BY sales ASC ) AS Row_Num
FROM super_store_dataset
)
SELECT customer_name, order_number, sales
FROM Customer_Orders
WHERE Row_Num = 1
ORDER BY customer_name;


# Display each order along with the total number of orders
# placed by that customer.

SELECT customer_name, order_number, sales, COUNT(*) OVER (
PARTITION BY customer_name ) AS Total_Customer_Orders
FROM super_store_dataset
ORDER BY customer_name, order_number;


# Rank all orders from the highest sales to the lowest sales.

SELECT order_number, customer_name, sales,
RANK() OVER ( ORDER BY sales DESC) AS Sales_Rank
FROM super_store_dataset
ORDER BY Sales_Rank;


# For each customer, display their order sales,
# highest sale, and average sale.

SELECT customer_name, order_number,sales,
MAX(sales) OVER ( PARTITION BY customer_name) AS Highest_Customer_Sale,
AVG(sales) OVER (PARTITION BY customer_name) AS Average_Customer_Sale
FROM super_store_dataset
ORDER BY customer_name, sales DESC;


# Find the second-highest sales order for each customer.

WITH Customer_Orders AS
(
SELECT customer_name, order_number, sales,
ROW_NUMBER() OVER ( PARTITION BY customer_name ORDER BY sales DESC) AS Row_Num
FROM super_store_dataset
)
SELECT customer_name, order_number, sales
FROM Customer_Orders
WHERE Row_Num = 2
ORDER BY customer_name;


# Find the top 2 highest-sales orders for each customer.

WITH Customer_Orders AS
(
SELECT  customer_name, order_number, sales,
ROW_NUMBER() OVER ( PARTITION BY customer_name ORDER BY sales DESC) AS Row_Num
FROM super_store_dataset
)
SELECT customer_name, order_number, sales, Row_Num
FROM Customer_Orders
WHERE Row_Num <= 2
ORDER BY customer_name, Row_Num;
