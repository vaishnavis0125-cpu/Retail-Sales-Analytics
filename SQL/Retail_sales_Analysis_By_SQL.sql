-- Creating Database
CREATE DATABASE retail_sales_analysis;

-- Displaying Tables in the database.
SHOW TABLES;

-- Displaying the Dataset with the table features.
SELECT * FROM retail_data_cleaned;
DESCRIBE retail_data_cleaned;

-- Add Year, Month and Day Columns.
UPDATE retail_data_cleaned
SET
    Year = YEAR(STR_TO_DATE(trans_date, '%d-%m-%Y')),
    Month = MONTHNAME(STR_TO_DATE(trans_date, '%d-%m-%Y')),
    Day = DAYNAME(STR_TO_DATE(trans_date, '%d-%m-%Y'));
   
-- Populate Year, Month and Day Columns.
UPDATE retail_data_cleaned
SET
   Year = YEAR(trans_date),
   Month = MONTHNAME(trans_date),
   Day = DAYNAME(trans_date);

-- Calculate the total sales revenue generated.
SELECT 
SUM(tran_amount) AS Total_Revenue
FROM retail_data_cleaned;

-- Calculate the total no. of transaction
SELECT 
COUNT(*) AS Total_Transactions
FROM retail_data_cleaned;

-- Calculate the average amount spent per transaction
SELECT 
AVG(tran_amount) AS Average_Transaction_Value
FROM retail_data_cleaned;

-- Identify customers contributing the highest revenue.
SELECT
customer_id, SUM(tran_amount) AS Total_Revenue
FROM retail_data_cleaned
GROUP BY customer_id
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Find customers with the highest number of purchase.
SELECT 
customer_id,
count(*) AS Purchase_Frequency
FROM retail_data_cleaned
GROUP BY customer_id
ORDER BY Purchase_Frequency DESC
LIMIT 10;

-- Analyse yearly sales performance.
SELECT
Year,
SUM(tran_amount) AS Total_Revenue
FROM retail_data_cleaned
GROUP BY Year;

-- Analyse Monthly sales trends.
SELECT
Month, SUM(tran_amount) AS Total_Revenue
FROM retail_data_cleaned
GROUP BY Month
ORDER BY Month;

-- Identify the busiest shopping days.
SELECT 
Day,
SUM(tran_amount) AS Total_Revenue
FROM retail_data_cleaned
GROUP BY Day
ORDER BY Day;

-- Mearure customer response to the marketing campaign.
SELECT
response,
COUNT(*) AS Coustomer_Count,
ROUND(Count(*) * 100.0/ 
(SELECT COUNT(*) FROM retail_data_cleaned),2) AS Percentage
FROM retail_data_cleaned
GROUP BY response;

-- Compare spending between customers who responded and those who did not.
SELECT
RESPONSE,
ROUND(AVG(tran_amount),2) AS Average_Spending
FROM retail_data_cleaned
GROUP BY response;

-- Highest Transaction made
SELECT 
MAX(tran_amount) AS Highest_Transaction
FROM retail_data_cleaned;

-- Lowest Transaction made.
SELECT
MIN(tran_amount) AS Lowest_Transaction
FROM retail_data_cleaned;

-- Unique Customers
SELECT
COUNT(DISTINCT customer_id) AS Unique_Customers
FROM retail_data_cleaned;

-- Monthally Transactions
SELECT 
Month,
COUNT(*) AS Total_Transactions
FROM retail_data_cleaned
GROUP BY Month
ORDER BY Month;

-- Analyse total spending per customer.
SELECT
customer_id,
SUM(tran_amount) AS Lifetime_Value
FROM retail_data_cleaned
GROUP BY customer_id
ORDER BY Lifetime_Value DESC;
