-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-15 11:42:10.009

-- tables
-- Table: DimClient
CREATE TABLE DimClient (
    ClientID int  NOT NULL,
    ClientName varchar(255)  NOT NULL,
    ClientAddress varchar(255)  NOT NULL,
    NIP int  NOT NULL,
    CONSTRAINT DimClient_pk PRIMARY KEY (ClientID)
);

-- Table: DimDate
CREATE TABLE DimDate (
    DateID int  NOT NULL,
    Date date  NOT NULL,
    Day int  NOT NULL,
    Month int  NOT NULL,
    Year int  NOT NULL,
    CONSTRAINT DimDate_pk PRIMARY KEY (DateID)
);

-- Table: DimFruit
CREATE TABLE DimFruit (
    FruitID int  NOT NULL,
    FruitName varchar(255)  NOT NULL,
    FruitCategory int  NOT NULL,
    PricePerKg decimal(5,2)  NOT NULL,
    CONSTRAINT DimFruit_pk PRIMARY KEY (FruitID)
);

-- Table: DimOrderDetails
CREATE TABLE DimOrderDetails (
    OrderDetailsID int  NOT NULL,
    OrderPrice decimal(5,2)  NOT NULL,
    FruitAmount varchar(255)  NOT NULL,
    CONSTRAINT DimOrderDetails_pk PRIMARY KEY (OrderDetailsID)
);

-- Table: DimPlace
CREATE TABLE DimPlace (
    PlaceID int  NOT NULL,
    PlaceName varchar(255)  NOT NULL,
    PlaceAddress varchar(255)  NOT NULL,
    CONSTRAINT DimPlace_pk PRIMARY KEY (PlaceID)
);

-- Table: DimTable
CREATE TABLE DimTable (
    TimeID int  NOT NULL,
    Time time  NOT NULL,
    Hour int  NOT NULL,
    Minutes int  NOT NULL,
    Seconds int  NOT NULL,
    CONSTRAINT DimTable_pk PRIMARY KEY (TimeID)
);

-- Table: FactTable
CREATE TABLE FactTable (
    OrderID int  NOT NULL,
    DateID int  NOT NULL,
    TimeID int  NOT NULL,
    ClientID int  NOT NULL,
    OrderDetailsID int  NOT NULL,
    FruitID int  NOT NULL,
    PlaceID int  NOT NULL,
    CONSTRAINT FactTable_pk PRIMARY KEY (OrderID)
);

-- foreign keys
-- Reference: DimCourierCompany_FactSales (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT DimCourierCompany_FactSales
    FOREIGN KEY (OrderDetailsID)
    REFERENCES DimOrderDetails (OrderDetailsID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: DimProduct_FactSales (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT DimProduct_FactSales
    FOREIGN KEY (FruitID)
    REFERENCES DimFruit (FruitID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactSales_DimClient (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactSales_DimClient
    FOREIGN KEY (ClientID)
    REFERENCES DimClient (ClientID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactTable_DimDate (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimDate
    FOREIGN KEY (DateID)
    REFERENCES DimDate (DateID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactTable_DimPlace (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimPlace
    FOREIGN KEY (PlaceID)
    REFERENCES DimPlace (PlaceID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactTable_DimTable (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimTable
    FOREIGN KEY (TimeID)
    REFERENCES DimTable (TimeID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

