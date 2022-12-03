--create database project_staging;

--create database project_prod;

--creating DIM tables

USE project_prod;

CREATE TABLE [dbo].[DIMCustomers] (
	[CustomerKey] int IDENTITY(1,1),
	[id] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[street] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[country] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[EffStartDate] date,
	[EffEndDate] date
)

CREATE TABLE [dbo].[DIMCarrier] (
	[CarrierKey] int IDENTITY(1,1),
	[carrier_id] [varchar](50) NULL,
	[carrier_name] [varchar](50) NULL,
	[address] [varchar](50) NULL,
	[tax_id] [varchar](50) NULL,
	[contact_person] [varchar](50) NULL,
	[EffStartDate] date,
	[EffEndDate] date
)


GO
--checking start date
USE [project_staging]
SELECT * FROM [dbo].[sales] ORDER BY date ASC

GO

--dim date
USE [project_prod]
GO
--delete table [dbo].[DIMDate]

DECLARE @StartDate  date = '20050101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 13, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS	
(
  SELECT
	DateKey			= DATEPART(YEAR, d) * 10000 + DATEPART(MONTH, d) * 100 + DATEPART(DAY, d),
    TheDate         = CONVERT(date, d),
	TheDay			= DATEPART(DAY, d),
	TheWeek         = DATEPART(WEEK, d),
	TheMonth		= DATEPART(MONTH, d),
    TheQuarter      = DATEPART(Quarter, d),
    TheYear         = DATEPART(YEAR, d)
  FROM d
),
dim AS
(
  SELECT * FROM src
)
SELECT * INTO [dbo].[DIMDate] FROM dim
ORDER BY TheDate
OPTION (MAXRECURSION 0);


SELECT * FROM [dbo].[DIMDate]
GO


---------------------queries---------------------

SELECT * FROM dbo.factSalesFinal
GO
--1
--suma trasakcji dla ka¿dego dnia w styczniu 2005
WITH cte AS (
	SELECT	
		SUM(CAST(fs.amount AS DECIMAL(10,2))) AS SumAmount,
		d.TheDay AS OrderDay
	FROM [dbo].[factSalesFinal] fs
	JOIN [dbo].[DIMDate] d
	ON d.DateKey = fs.DateKey
	WHERE d.TheMonth = 1 AND d.TheYear = 2005
	GROUP BY d.TheDay)

--œrednia krocz¹ca dla danego dnia oraz trzech poprzednich
SELECT 
	SumAmount,
	AVG(SumAmount)
	OVER ( ORDER BY OrderDay ROWS BETWEEN 3 PRECEDING AND CURRENT ROW ) AS MovingAverage,
	OrderDay
FROM cte
ORDER BY OrderDay

GO


--2
--roczny ranking sprzedazy dla kazdego z dostawcow 
SELECT
	c.carrier_name AS CarrierName,
	SUM(CAST(fs.amount AS DECIMAL(10,2))) AS SumAmount,
	d.TheYear,
	PERCENT_RANK() OVER ( PARTITION BY d.TheYear ORDER BY SUM(CAST(fs.amount AS DECIMAL(10,2))) ) AS Rank
FROM [dbo].[factSalesFinal] fs
JOIN [dbo].[DIMDate] d
ON fs.DateKey = d.DateKey
JOIN [dbo].[DIMCarrier] c
ON fs.CarrierKey = c.CarrierKey
GROUP BY carrier_name, d.TheYear
ORDER BY d.TheYear, Rank

GO


--3
--percentyl dostawcy biorac pod uwage sumaryczna sprzedaz w 2005 roku oraz odchylenie standardowe
SELECT
	c.carrier_name AS CarrierName,
	SUM(CAST(fs.amount AS DECIMAL(10,2))) AS SumAmount,
	PERCENT_RANK() OVER ( ORDER BY SUM(CAST(fs.amount AS DECIMAL(10,2))) ) AS Percentile,
	STDEV(SUM(CAST(fs.amount AS DECIMAL(10,2)))) OVER ( ORDER BY SUM(CAST(fs.amount AS DECIMAL(10,2))) ) AS StdDev
FROM [dbo].[factSalesFinal] fs
JOIN [dbo].[DIMDate] d
ON fs.DateKey = d.DateKey
JOIN [dbo].[DIMCarrier] c
ON fs.CarrierKey = c.CarrierKey
WHERE d.TheYear = 2005
GROUP BY carrier_name
