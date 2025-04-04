create database Retail_sales;
use Retail_sales;

Create table  Retail_Sales_Data
						      (  Transactions_id Int primary key,
                                  Sale_date	date,
                                  Sale_time	time,
                                  Customer_id	int,
                                  Gender varchar(10),
                                  Age	int not null,
                                  Category	varchar(15),
                                  Quantiy	int,
                                  Price_per_unit float,
                                  Cost float,	
                                  Total_sale float
                                  );
select * from retail_sales_Data;

# Data Cleaning 
  # check  Duplicate ,Blank and Null values in Transactions because 'Transactions_id' in our Primary Key
select Transactions_id, count(*)
from retail_sales_data
Where Transactions_id is not null And Transactions_id <> ' '
group by Transactions_id
having count(*) >1;

# our data is full clean and well structure we move to our finding and Analysis




#Data Analysis & Business Key Problems & Answers--

#Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05;

select * 
from retail_sales_Data 
where sale_date = '2022-11-05';

#Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 more than 4 in the month of Nov-2022


SELECT * 
FROM retail_sales_Data
WHERE Category = 'Clothing'
AND Sale_date BETWEEN '2022-11-01' AND '2022-11-30'
having Quantiy >= 4;

#Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select Category, sum(Total_sale) as Total_Sales
from retail_sales_Data
group by Category;

 #Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select Category, avg(Age) as average_age
From retail_sales_Data
Where Category = 'Beauty';

#Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
From retail_sales_Data
Where Total_sale > 1000;

#Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

Select Gender, count(Transactions_id) as Total_number_of_transactions
From retail_sales_Data
group by Gender;

# Q.7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

     #Q.7.(a)average sale for each month
Select Month(Sale_date) as Month, Year(Sale_date) as Year, round(avg(Total_sale)) as Average_Sales
from retail_sales_Data
group by month(Sale_date), Year(Sale_date)
order by Year(Sale_date) asc;


#Q.7.(b)Find out best selling month in each year

with Monthly_Sales as 
                    ( select Year(Sale_date) as Year,
                             Month(sale_date) as Month,
                             avg(Total_sale) as Average_sale,
                             sum(Total_sale) as Total_sales
					 from retail_sales_Data
                     group by year(Sale_date), month(Sale_Date)
                    )
select Year, Month, round(Average_sale) as Average_Sale, round(Total_sales) as Total_Sale
From Monthly_Sales
where (year, Total_sales) in ( Select year, max(Total_sales) from Monthly_Sales Group by year)
order by Year, Month;

#Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 						

select Customer_id, sum(Total_sale) as Highest_Total_Sales
from retail_sales_Data
group by Customer_id
order by Highest_Total_Sales desc
Limit 5;

#Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

Select Category, count(distinct(Customer_id)) as Unique_customers
from retail_sales_Data
group by Category
order by Unique_customers desc;

#Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

Select
      case
        when extract(hour from Sale_time) <= 12 then 'Morning'
        when extract(hour from Sale_time) >12 And extract(hour from Sale_time) <= 17 then 'Afternoon'
        else 'Evening'
	end as Shift,
count(*) as Order_count
from retail_sales_data
group by Shift
order by Shift;
        



