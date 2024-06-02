--1).Retrieve all columns for all records in the dataset.
select * from sales

--2).How many unique countries are represented in the dataset?
select count(distinct country) from sales

--3)Select the names of all the customers on the 'Retail' channel.
select customername from sales
where subchannel = 'Retail'

--4).Find the total quantity sold for the ' Antibiotics' product class
select productclass,sum(quantity)
from sales
where productclass = 'Antibiotics'
group BY productclass

--5).List all the distinct months present in the dataset.
select distinct month from sales

--6).Calculate the total sales for each year.
select year,sum(sales) from sales
group by year

--7).Find the customer with the highest sales value.
select customername,sum(sales) as Total_sales
from sales 
GROUP BY customername
ORDER BY Total_sales desc
limit 1;

--8).Get the names of all employees who are Sales Reps and are managed by 'James Goodwill'.
select salesrepname from sales
where manager = 'James Goodwill'

--9).Retrieve the top 5 cities with the highest sales.
select city,sum(sales) as Total_sales
from sales
group by city
ORDER BY Total_sales desc
limit 5;

--10).Calculate the average price of products in each sub-channel.
select subchannel,avg(price) as avg_price
from sales
group by subchannel
