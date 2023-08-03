SELECT *
FROM [pizza_sales_excel_file (2)]

-- Calculate the total revenue from the sale of pizzas

SELECT SUM(total_price) AS TotalRevenue
FROM [pizza_sales_excel_file (2)]

-- Calculate the average amount spent per order

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_order_amount
FROM [pizza_sales_excel_file (2)]

-- Total Pizzas sold

SELECT SUM(quantity) AS Pizzas_sold
FROM [pizza_sales_excel_file (2)]

--  Total orders

SELECT COUNT( DISTINCT order_id) AS Total_orders
FROM [pizza_sales_excel_file (2)]

-- Average pizzas per order

SELECT SUM(quantity) / COUNT( DISTINCT order_id) AS Avg_pizza_per_order
FROM [pizza_sales_excel_file (2)]

--Charts requirements:
-- Determine the daily trend of total orders over a specified period of time
--Helps identify any patterns or fluctuations of order volumes on a daily basis

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) as order_count
FROM [pizza_sales_excel_file (2)]
GROUP BY DATENAME(DW, order_date)
--The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG() to group the result-set by one or more columns.

-- Determine the monthly trend for total orders

SELECT DATENAME(Month, order_date) AS month_name, COUNT(DISTINCT order_id) AS Total_monthly_orders
FROM [pizza_sales_excel_file (2)]
GROUP BY DATENAME(Month, order_date)
ORDER BY Total_monthly_orders desc
--The ORDER BY keyword is used to sort the result-set in ascending or descending order.

--Percentage of sales by pizza category
--The idea here is to treat the total as a single number that we can directly use as the denominator in the division.
--The inline view SELECT SUM(total_price) FROM pizza_sales_excel_file  calculates the sum. We can then divide the individual values by this sum to obtain the percent to total for each row.


SELECT pizza_category, sum(total_price)*100 / (Select sum(total_price) from [pizza_sales_excel_file (2)]) AS Sales_percentage
FROM [pizza_sales_excel_file (2)]
GROUP BY pizza_category

-- To filter the result monthwise, use the WHERE clause

SELECT pizza_category, sum(total_price)*100 / (Select sum(total_price) from [pizza_sales_excel_file (2)] WHERE Month(order_date) = 12) AS Sales_percentage
FROM [pizza_sales_excel_file (2)]
WHERE Month(order_date) = 12
GROUP BY pizza_category

--percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)), CAST(sum(total_price) *100 / (select sum(total_price) from [pizza_sales_excel_file (2)]) AS DECIMAL(10,2)) AS Sales_percent
FROM [pizza_sales_excel_file (2)]
GROUP BY pizza_size 
ORDER BY Sales_percent DESC


--Top 5 best sellers by revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Revenue
FROM [pizza_sales_excel_file (2)]
GROUP BY pizza_name
ORDER BY Revenue DESC

--Top 5 best sellers by Total Quantity 
SELECT TOP 5 pizza_name, SUM(quantity) AS Quantity
FROM [pizza_sales_excel_file (2)]
GROUP BY pizza_name
ORDER BY Quantity DESC

--Top 5 best sellers by  total orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_orders
FROM [pizza_sales_excel_file (2)]
GROUP BY pizza_name
ORDER BY Total_orders DESC

