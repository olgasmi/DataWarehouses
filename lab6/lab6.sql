--ex1
WITH cte AS (
	SELECT 
		SUM(SalesAmount) AS amount,
		DAY(OrderDate) AS order_day
	FROM [dbo].[FactInternetSales]
	GROUP BY DAY(OrderDate))

SELECT 
	amount,
	AVG(amount)
	OVER ( ORDER BY order_day
	ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS moving_average,
	order_day
FROM cte
ORDER BY order_day

--ex2
SELECT DISTINCT SalesTerritoryKey FROM [dbo].[FactInternetSales] WHERE YEAR(OrderDate) = '2011' ORDER BY SalesTerritoryKey --columns names

SELECT 
	OrderDateMonth AS month_of_year,
	ISNULL([0], 0) AS [0], 
	ISNULL([1], 0) AS [1],
	ISNULL([2], 0) AS [2],
	ISNULL([3], 0) AS [3],
	ISNULL([4], 0) AS [4],
	ISNULL([5], 0) AS [5],
	ISNULL([6], 0) AS [6],
	ISNULL([7], 0) AS [7],
	ISNULL([8], 0) AS [8],
	ISNULL([9], 0) AS [9],
	ISNULL([10], 0) AS [10]
FROM
(
	SELECT 
		SalesTerritoryKey,
		SUM(SalesAmount) AS SumSalesAmount,
		MONTH(OrderDate) AS OrderDateMonth
	FROM [dbo].[FactInternetSales]
	WHERE YEAR(OrderDate) = '2011'
	group by MONTH(OrderDate), SalesTerritoryKey
) AS SourceTable
PIVOT
(
	SUM(SumSalesAmount)
	FOR SalesTerritoryKey IN ([0], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
) AS PivotTable

--ex3
SELECT
	OrganizationKey,
	DepartmentGroupKey,
	SUM(Amount) AS SumAmount
FROM [dbo].[FactFinance]
GROUP BY ROLLUP(OrganizationKey, DepartmentGroupKey)
ORDER BY OrganizationKey

--ex4
SELECT
	OrganizationKey,
	DepartmentGroupKey,
	SUM(Amount) AS SumAmount
FROM [dbo].[FactFinance]
GROUP BY CUBE(OrganizationKey, DepartmentGroupKey)
ORDER BY OrganizationKey

--ex5
WITH cte AS (
	SELECT 
		OrganizationKey, 
		SUM(Amount) AS SumAmount 
	FROM [dbo].[FactFinance] 
	WHERE YEAR(Date) = '2012' 
	GROUP BY OrganizationKey
),
Percentiles AS
(SELECT 
	c.OrganizationKey,
	o.OrganizationName,
	c.SumAmount,
	PERCENT_RANK() OVER (ORDER BY c.SumAmount) AS Percentile
FROM cte c
JOIN [dbo].[DimOrganization] o
ON o.OrganizationKey = c.OrganizationKey)

SELECT * FROM Percentiles ORDER BY OrganizationKey

--ex6
WITH cte AS (
	SELECT 
		OrganizationKey, 
		SUM(Amount) AS SumAmount 
	FROM [dbo].[FactFinance] 
	WHERE YEAR(Date) = '2012' 
	GROUP BY OrganizationKey
),
ex6 AS
(SELECT 
	c.OrganizationKey,
	o.OrganizationName,
	c.SumAmount,
	PERCENT_RANK() OVER (ORDER BY c.SumAmount) AS Percentile,
	STDEV(c.SumAmount) OVER (ORDER BY c.OrganizationKey) AS StdDev
FROM cte c
JOIN [dbo].[DimOrganization] o
ON o.OrganizationKey = c.OrganizationKey)

SELECT * FROM ex6