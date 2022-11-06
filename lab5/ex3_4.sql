--ex3
CREATE CLUSTERED INDEX idx_customer_state ON [dbo].[DIMCustomers] ([state])

IF EXISTS
(
  SELECT 1 FROM sys.indexes
  WHERE name='idx_customer_state' AND object_id = OBJECT_ID('[dbo].[DIMCustomers]')
)
BEGIN
     PRINT 'Clustered index "idx_customer_state" exists'
END

--ex4
CREATE VIEW carrier_factTable WITH SCHEMABINDING AS (
	SELECT 
		ft.[order_details_id],
		ft.[order_id],
		ft.[pizza_id],
		ft.[quantity],
		ft.[date],
		ft.[time],
		c.[carrier_id],
		c.[carrier_name],
		c.[address],
		c.[tax_id],
		c.[contact_person]
	FROM [dbo].[carrier] c
	JOIN [dbo].[FactTable] ft
	ON c.[carrier_id] = ft.[carrier_id]
)

SELECT TOP (1000) [order_details_id]
      ,[order_id]
      ,[pizza_id]
      ,[quantity]
      ,[date]
      ,[time]
      ,[carrier_id]
      ,[carrier_name]
      ,[address]
      ,[tax_id]
      ,[contact_person]
 FROM [lab5].[dbo].[carrier_factTable]


CREATE UNIQUE CLUSTERED INDEX idx_carrier_factTable ON [dbo].[carrier_factTable] (
	   [order_details_id]
      ,[order_id]
      ,[pizza_id]
      ,[quantity]
      ,[date]
      ,[time]
      ,[carrier_id]
      ,[carrier_name]
      ,[address]
      ,[tax_id]
      ,[contact_person]
)

IF EXISTS
(
  SELECT 1 FROM sys.indexes
  WHERE name='idx_carrier_factTable' AND object_id = OBJECT_ID('[dbo].[carrier_factTable]')
)
BEGIN
     PRINT 'Clustered unique index "idx_carrier_factTable" exists'
END