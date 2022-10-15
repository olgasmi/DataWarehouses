-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-15 11:45:45.717

-- tables
-- Table: DimClient
CREATE TABLE DimClient (
    ClientID int  NOT NULL,
    ClientIName varchar(255)  NOT NULL,
    ClientISurname varchar(255)  NOT NULL,
    ClientIAddress varchar(255)  NOT NULL,
    ClientITelephoneNumber int  NOT NULL,
    CONSTRAINT DimClient_pk PRIMARY KEY (ClientID)
);

-- Table: DimCourierCompany
CREATE TABLE DimCourierCompany (
    CourierCompanyID int  NOT NULL,
    CourierCompanyName varchar(255)  NOT NULL,
    CourierCompanyAddress varchar(255)  NOT NULL,
    NIP int  NOT NULL,
    CONSTRAINT DimCourierCompany_pk PRIMARY KEY (CourierCompanyID)
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
    ISBN int  NOT NULL,
    Publisher varchar(255)  NOT NULL,
    Title varchar(255)  NOT NULL,
    Author varchar(255)  NOT NULL,
    NumberOfPages int  NOT NULL,
    CONSTRAINT DimProduct_pk PRIMARY KEY (ISBN)
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

-- Table: FactSales
CREATE TABLE FactSales (
    OrderID int  NOT NULL,
    CourierCompanyID int  NOT NULL,
    DateID int  NOT NULL,
    TimeID int  NOT NULL,
    ClientID int  NOT NULL,
    ISBN int  NOT NULL,
    CONSTRAINT FactSales_pk PRIMARY KEY (OrderID)
);

-- foreign keys
-- Reference: FactSales_DimClient (table: FactSales)
ALTER TABLE FactSales ADD CONSTRAINT FactSales_DimClient
    FOREIGN KEY (ClientID)
    REFERENCES DimClient (ClientID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactSales_DimCourierCompany (table: FactSales)
ALTER TABLE FactSales ADD CONSTRAINT FactSales_DimCourierCompany
    FOREIGN KEY (CourierCompanyID)
    REFERENCES DimCourierCompany (CourierCompanyID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactSales_DimDate (table: FactSales)
ALTER TABLE FactSales ADD CONSTRAINT FactSales_DimDate
    FOREIGN KEY (DateID)
    REFERENCES DimDate (DateID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactSales_DimProduct (table: FactSales)
ALTER TABLE FactSales ADD CONSTRAINT FactSales_DimProduct
    FOREIGN KEY (ISBN)
    REFERENCES DimProduct (ISBN)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactSales_DimTable (table: FactSales)
ALTER TABLE FactSales ADD CONSTRAINT FactSales_DimTable
    FOREIGN KEY (TimeID)
    REFERENCES DimTable (TimeID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

