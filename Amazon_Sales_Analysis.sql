use amazon_sales_analysis;
show tables;
select * from amazon_products;
select * from amazon_categories;
# List the total number of products found on Amazon
select count(asin) as total_products from amazon_products;
# How much sales were made by Amazon in September
select sum(round(price*boughtinlastmonth)) from amazon_products;
# How many product categories are there in amazon
select count(id) as 'No of prodct categories' from amazon_categories;
# Name top 5 selling products in terms of sales
select title,round(price*boughtinlastmonth) from amazon_products  order by round(price*boughtinlastmonth) desc limit 5  ;
with products as(
select title as product,category_name as category,round(price*boughtinlastmonth) as sales,dense_rank() 
over(order by round(price*boughtinlastmonth) desc) as rankk from amazon_products p inner join amazon_categories a on 
p.category_id=a.id 
)
select product,category,sales,rankk from products where rankk<=5;
# Name top 5 selling products categories
select category_name,sum(round(price*boughtinlastmonth)) from amazon_products p join amazon_categories 
c on p.category_id=c.id group by category_name order by sum(round(price*boughtinlastmonth)) desc
limit 5;
with category as(
select category_name as category,sum(round(price*boughtinlastmonth)) as sales,dense_rank()
 over(order by sum(round(price*boughtinlastmonth))) as rannk from amazon_products p inner join amazon_categories a on 
p.category_id=a.id group by category_name
)
select category,sales,rannk from category where rannk<=5;
# how many products made over 0.1 million in sales?What is the contribution of these products in overall sales?
with products as(
 select count(round(price*boughtinlastmonth)) as prodcount,
 sum(round(price*boughtinlastmonth)) as sales from amazon_products where round(price*boughtinlastmonth)>100000 
 ),
 total as
 (
 select  sum(round(price*boughtinlastmonth)) as TotalSales from amazon_products
 )
 select *,round((sales/totalsales)*100,2) as contribution from products,total;
 # how many products got above 4 star rating on amazon?
 select count(stars) as prodcount,stars as ratings from amazon_products where stars>=4 group by stars;
 #testing
 select count(round(price*boughtinlastmonth)) as prodcount,
 sum(round(price*boughtinlastmonth)) as sales from amazon_products where round(price*boughtinlastmonth)>100000 ;
 select count(round(price*boughtinlastmonth)) as prodcount from amazon_products where round(price*boughtinlastmonth)>100000 ;
 
 


