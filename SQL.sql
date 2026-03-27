#Validaciones previas de las tablas
SELECT * FROM chocolate_sales.sales LIMIT 20;
select order_id, COUNT(*) as total from chocolate_sales.sales group by order_id order by total desc;
select * from chocolate_sales.sales where product_id = 'P0000';

#Query para obtener las ordenes con mayo el beneficio por orden
select order_id, profit, rank() over (order by profit desc) as ranking from chocolate_sales.sales order by ranking limit 20;

#Query para obtener el dia de mayor beneficio por producto por orden
with product_rank  as (
	select product_id,order_date,profit, rank() over (partition by product_id order by profit desc) as ranking from chocolate_sales.sales
	)
	select product_id, order_date,profit from product_rank where ranking = 1;

#Query para encontrar filas duplicadas
select 
	order_id,
	order_date,
	product_id,
	store_id,
	customer_id,
	quantity,
	unit_price,
	discount,
	revenue,cost,
	profit 
from chocolate_sales.sales 
group by 
	order_id,
	order_date,
	product_id,
	store_id,
	customer_id,
	quantity,
	unit_price,
	discount,
	revenue,cost,
	profit 
having count(*) > 1;

#Query para obtener la suma por store_id, product_id y adicionando el total por store_id
#SQL SERVER - ORACLE - POSTGRESQL
/*select store_id, product_id, sum(quantity) as total_products from chocolate_sales.sales 
group by ROLLUP (store_id,product_id);*/
#MYSQL
select
	store_id,
	product_id,
	sum(quantity) as total_products
from
	chocolate_sales.sales
group by
	store_id,
	product_id with rollup ;
