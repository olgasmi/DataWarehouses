-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-15 12:22:12.86

-- tables
-- Table: DimDate
CREATE TABLE DimDate (
    DateID int  NOT NULL,
    Date date  NOT NULL,
    Day int  NOT NULL,
    Month int  NOT NULL,
    Year int  NOT NULL,
    CONSTRAINT DimDate_pk PRIMARY KEY (DateID)
);

-- Table: DimEmployeeInfo
CREATE TABLE DimEmployeeInfo (
    EmployeeInfoID int  NOT NULL,
    Salary decimal(10,2)  NOT NULL,
    PESEL int  NOT NULL,
    Address varchar(255)  NOT NULL,
    CONSTRAINT DimEmployeeInfo_pk PRIMARY KEY (EmployeeInfoID)
);

-- Table: DimFeedback
CREATE TABLE DimFeedback (
    FeedbackID int  NOT NULL,
    Rate int  NOT NULL,
    Current boolean  NOT NULL,
    CONSTRAINT DimFeedback_pk PRIMARY KEY (FeedbackID)
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
    EmployeeID int  NOT NULL,
    DateID int  NOT NULL,
    TimeID int  NOT NULL,
    EmployeeInfoID int  NOT NULL,
    FeedbackID int  NOT NULL,
    CONSTRAINT FactTable_pk PRIMARY KEY (EmployeeID)
);

-- foreign keys
-- Reference: FactTable_DimDate (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimDate
    FOREIGN KEY (DateID)
    REFERENCES DimDate (DateID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactTable_DimEmployeeInfo (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimEmployeeInfo
    FOREIGN KEY (EmployeeInfoID)
    REFERENCES DimEmployeeInfo (EmployeeInfoID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FactTable_DimFeedback (table: FactTable)
ALTER TABLE FactTable ADD CONSTRAINT FactTable_DimFeedback
    FOREIGN KEY (FeedbackID)
    REFERENCES DimFeedback (FeedbackID)  
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

