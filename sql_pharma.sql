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

--11).Join the 'Employees' table with the 'Sales' table to get the name of the Sales Rep and the corresponding sales records.

--Note:There is only one table in the given dataset, so can't perform join operation
select salesrepname,sum(sales)
from sales
group BY salesrepname

--12).Retrieve all sales made by employees from ' Rendsburg ' in the year 2018.
select * from sales
where city = 'Rendsburg' and year = 2018

--13).Calculate the total sales for each product class, for each month, and order the results by year, month, and product class.
select productclass,month,sum(sales) as Total_sales
from sales
group by year,month,productclass
order BY year,month,productclass

--14).Find the top 3 sales reps with the highest sales in 2019.
select salesrepname,sum(sales) as Total_sales from sales
where year = 2019
group by salesrepname
order by Total_sales desc
limit 3;

--15).Calculate the monthly total sales for each sub-channel, and then calculate the average
--monthly sales for each sub-channel over the years.
with monthly_total_sales as
(
    select year,month,subchannel,sum(sales) as Total_sales
    from sales
    group by year,month,subchannel  
),
average_monthly_sales as
(
    select subchannel,avg(Total_sales) as Avg_monthly_sales
    from monthly_total_sales
    group by subchannel
)
select subchannel,Avg_monthly_sales
from average_monthly_sales

--16).Create a summary report that includes the total sales, average price, and total quantity
--sold for each product class.
select productclass,sum(sales) as Total_sales,avg(price) as Average_Price,sum(quantity) as Total_quantity
from sales
group by productclass

--17).Find the top 5 customers with the highest sales for each year.
with ranked_customer as 
(
    select year,customername,sales,row_number() over(partition by year order by sales desc) as rank 
    from sales
)
select year,customername,sales
from ranked_customer
where rank<=5

--18).Calculate the year-over-year growth in sales for each country.
with yearly_sales as   
(
    select country,year,sum(sales) as Total_sales
    from sales
    group by country,year
),
yearly_sales_growth as
(
    select ys1.country,ys1.year,ys1.Total_sales AS CurrentYearSales,
    ys2.Total_sales AS PreviousYearSales,
    case 
        when ys2.Total_sales is null then null
        else ((ys1.Total_sales - ys2.Total_sales)/ys2.Total_sales) * 100
    end as YoYgrowth
    from yearly_sales ys1
    left join
    yearly_sales ys2 on ys1.country = ys2.country and ys1.year = ys2.year + 1
)
select country,year,CurrentYearSales,PreviousYearSales,YoYgrowth
from yearly_sales_growth
order by country,year

--19).List the months with the lowest sales for each year
with monthly_sales as
(
    select year,month,sum(sales) as Total_sales
    from sales
    group by year,month
),
ranked_monthly_sales AS
(
    select year,month,Total_sales,
    rank() over(partition by year ORDER BY Total_sales) as sales_rank
    from monthly_sales
)
select year,month,Total_sales
from ranked_monthly_sales
where sales_rank = 1
ORDER BY year,month

--20).Calculate the total sales for each sub-channel in each country, and then find the country
--with the highest total sales for each sub-channel.
with subchannel_sales as
(
    select country,subchannel,sum(sales) as Total_sales
    from sales
    group by country,subchannel
),
ranked_subchannel_sales as
(
    select country,subchannel,Total_sales,
    rank() over(partition by subchannel ORDER BY Total_sales desc) as sales_rank
    from subchannel_sales
)
select subchannel,country,Total_sales
from ranked_subchannel_sales
where sales_rank = 1
ORDER BY subchannels






