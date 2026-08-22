
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

Select customer_name ,
sum(sales) As Total_sales
from super_store_dataset
Group by customer_name
order by Total_sales DESC 
limit 10;

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
Order by Total_sales ;

# How did total profit change across different years?

Select year , sum(profit) AS Total_Profit
from super_store_dataset
group by year
order by Total_Profit;

# Which shipping modes are used most frequently?

SELECT ship_mode, COUNT(order_number) AS Total_Orders
FROM super_store_dataset
GROUP BY ship_mode
ORDER BY Total_Orders DESC;

# How many orders are there for each order priority?

Select order_priority , count(order_number) As Total_orders
from super_store_dataset
group by order_priority
order by Total_orders;

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


SELECT customer_name, SUM(sales) AS Total_Sales
from super_store_dataset
group by customer_name
Having sum(sales) >
(
Select avg(Total_customers) 
from (
Select customer_name , Sum(sales) AS total_customers
from super_store_dataset
group by customer_name ) AS Customer_sales
)
Order by Total_Sales DESC ; 

# Within each category, rank the products by their total sales, with the highest-selling product ranked #1. 

Select category , product_name , Total_sales,
Rank() Over ( partition by category order by total_sales  DESC) AS Sales_Rank
from (
Select category , Product_name , 
sum(sales) AS total_sales 
from super_store_dataset
Group by Category , product_name) AS Customer_table ;





































