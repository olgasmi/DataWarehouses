USE [lab5]

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

CREATE TABLE [dbo].[DIMOrderDetails] (
	[OrderDetailsKey] int IDENTITY(1,1),
	[order_details_id] [varchar](50) NULL,
	[order_id] [varchar](50) NULL,
	[pizza_id] [varchar](50) NULL,
	[quantity] [varchar](50) NULL,
	[EffStartDate] date,
	[EffEndDate] date
)


CREATE TABLE [dbo].[DIMOrders] (
	[OrdersKey] int IDENTITY(1,1),
	[order_id] [varchar](50) NULL,
	[date] [varchar](50) NULL,
	[customer_id] [varchar](50) NULL,
	[time] [varchar](50) NULL,
	[carrier_id] [varchar](50) NULL,
	[EffStartDate] date,
	[EffEndDate] date
)


CREATE TABLE [dbo].[DIMPizzaTypes] (
	[PizzaTypes] int IDENTITY(1,1),
	[pizza_type_id] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[category] [varchar](50) NULL,
	[ingredients] [varchar](300) NULL,
	[EffStartDate] date,
	[EffEndDate] date
)


CREATE TABLE [dbo].[DIMPizzas] (
	[PizzasKey] int IDENTITY(1,1),
	[pizza_id] [varchar](50) NULL,
	[pizza_type_id] [varchar](50) NULL,
	[size] [varchar](50) NULL,
	[price] [varchar](50) NULL,
	[EffStartDate] date,
	[EffEndDate] date
)


CREATE TABLE [dbo].[DIMState](
	[StateKey] [int] IDENTITY(1,1) NOT NULL,
	[id] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[EffStartDate] [date] NULL,
	[EffEndDate] [date] NULL
)

