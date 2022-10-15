-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-15 12:37:34.952

-- tables
-- Table: DimBrand
CREATE TABLE DimBrand (
    BrandID int  NOT NULL,
    CompanyName varchar(255)  NOT NULL,
    CompanyAddress varchar(255)  NOT NULL,
    CONSTRAINT DimBrand_pk PRIMARY KEY (BrandID)
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

-- Table: DimProduct
CREATE TABLE DimProduct (
    ProductD int  NOT NULL,
    ProductName varchar(255)  NOT NULL,
    BrandID int  NOT NULL,
    StatusID int  NOT NULL,
    CONSTRAINT DimProduct_pk PRIMARY KEY (ProductD)
);

-- Table: DimStatus
CREATE TABLE DimStatus (
    StatusID int  NOT NULL,
    StatusName varchar(255)  NOT NULL,
    CONSTRAINT DimStatus_pk PRIMARY KEY (StatusID)
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

-- Table: DimWarehouse
CREATE TABLE DimWarehouse (
    WarehouseID int  NOT NULL,
    WarehouseName varchar(255)  NOT NULL,
    Country varchar(255)  NOT NULL,
    WarehouseAddress varchar(255)  NOT NULL,
    CONSTRAINT DimWarehouse_pk PRIMARY KEY (WarehouseID)
);

-- Table: FactTable
CREATE TABLE FactTable (
    ID int  NOT NULL,
    DateID int  NOT NULL,
    TimeID int  NOT NULL,
    WarehouseID int  NOT NULL,
    ProductD int  NOT NULL,
    CONSTRAINT FactTable_pk PRIMARY KEY (ID)
);

-- foreign keys
-- Reference: DimProduct_DimBrand (table: DimProduct)
ALTER TABLE DimProduct ADD CONSTRAINT DimProduct_DimBrand
    FOREIGN KEY (BrandID)
    REFERENCES DimBrand (BrandID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: DimProduct_DimStatus (table: DimProduct)
ALTER TABLE DimProduct ADD CONSTRAINT DimProduct_DimStatus
    FOREIGN KEY (StatusID)
    REFERENCES DimStatus (StatusID)  
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

-- Reference: FactTable_DimProduct (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimProduct
    FOREIGN KEY (ProductD)
    REFERENCES DimProduct (ProductD)  
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

-- Reference: FactTable_DimWarehouse (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimWarehouse
    FOREIGN KEY (WarehouseID)
    REFERENCES DimWarehouse (WarehouseID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

