use lab1;

--ex1
with result_ex1 AS (
	SELECT 
		p.price * od.quantity AS summarized_price,
		o.date AS order_date
	FROM [dbo].[pizzas] AS p
	JOIN [dbo].[order_details] AS od 
		ON od.pizza_id = p.pizza_id
	JOIN [dbo].[orders] AS o
		ON o.order_id = od.order_details_id
	WHERE date = '2015-02-18')

SELECT avg(summarized_price) AS average_order_price, order_date FROM result_ex1 GROUP BY order_date;


--ex2
WITH result_ex2 AS (
	SELECT 
		od.order_id
		,od.pizza_id
	FROM [dbo].[order_details] AS od
	JOIN [dbo].[orders] AS o 
		ON od.order_id = o.order_id
	JOIN [dbo].[pizzas] AS p
		ON od.pizza_id = p.pizza_id
	JOIN [dbo].[pizza_types] AS pt
		ON pt.pizza_type_id = p.pizza_type_id
	WHERE 
		o.date LIKE '2015-03%' AND pt.ingredients NOT LIKE '%Pineapple%')

SELECT order_id, STRING_AGG(pizza_id, ',') AS pizzas FROM result_ex2 GROUP BY order_id ORDER BY order_id;


--ex3
WITH result_ex3 AS (
	SELECT
		od.order_id
		,p.price * od.quantity AS order_price
	FROM [dbo].[order_details] AS od
	JOIN [dbo].[pizzas] AS p
		ON od.pizza_id = p.pizza_id
	JOIN [dbo].[orders] AS o
		ON o.order_id = od.order_id
	WHERE o.date LIKE '2015-02%')

SELECT TOP(10)
	order_id
	,order_price
	,RANK () OVER (ORDER BY order_price DESC) AS ranking
FROM result_ex3;


--ex4
WITH result_ex4 AS (
	SELECT
		od.order_id
		,p.price * od.quantity AS order_amount
		,o.date AS order_date
		,MONTH(o.date) AS order_month
	FROM [dbo].[order_details] AS od
	JOIN [dbo].[pizzas] AS p
		ON od.pizza_id = p.pizza_id
	JOIN [dbo].[orders] AS o
	ON o.order_id = od.order_id)

, extra_cte AS (
	SELECT
		AVG(order_amount) AS average_order_amount
		,order_month
	FROM result_ex4
	GROUP BY order_month)


SELECT
	res.order_id
	,res.order_amount
	,ex.average_order_amount
	,res.order_date
FROM result_ex4 AS res 
JOIN extra_cte AS ex
ON ex.order_month = res.order_month;


--ex5
WITH result_ex5 AS (
	SELECT
		od.quantity
		,o.time
		,o.date AS order_date
	FROM [dbo].[order_details] AS od
	JOIN [dbo].[orders] AS o
	ON o.order_id = od.order_id
	WHERE o.date = '2015-01-01')


SELECT 
	SUM(quantity) AS order_count
	,left(time, 2) AS order_hour 
FROM result_ex5
GROUP BY left(time, 2);


--ex6
WITH result_ex6 AS (
	SELECT
		pt.name AS pizza_name
		,od.quantity
		,o.date
	FROM [dbo].[order_details] AS od
	JOIN [dbo].[pizzas] AS p
		ON od.pizza_id = p.pizza_id
	JOIN [dbo].[orders] AS o
		ON o.order_id = od.order_id
	JOIN [dbo].[pizza_types] AS pt
		ON pt.pizza_type_id = p.pizza_type_id
	WHERE o.date LIKE '2015-01%')

SELECT 
	pizza_name
	,SUM(quantity) AS amount 
FROM result_ex6 
GROUP BY pizza_name 
ORDER BY amount DESC;


--ex7
WITH result_ex7 AS (
	SELECT
		p.pizza_id
		,od.quantity
		,o.date
	FROM [dbo].[order_details] AS od
	JOIN [dbo].[pizzas] AS p
		ON od.pizza_id = p.pizza_id
	JOIN [dbo].[orders] AS o
		ON o.order_id = od.order_id
	WHERE 
		o.date LIKE '2015-02%' OR o.date LIKE '2015-03%')

SELECT
	RIGHT(pizza_id, 1) AS pizza_size,
	SUM(quantity) AS amount
FROM result_ex7
GROUP BY RIGHT(pizza_id, 1);