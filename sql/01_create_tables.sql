-- =============================================================
-- Northwind (NWIND) — 01. Create tables with constraints
-- Authors: Sanaba Kanté & Débora Akoua Kouassi — April 2026
-- Oracle SQL. Parent tables first, then child tables (FK order).
-- =============================================================

-- ================ PARENT TABLES ================

CREATE TABLE Categories (
    CategoryID    NUMBER        CONSTRAINT Categories_pk PRIMARY KEY,
    CategoryName  VARCHAR2(60)  CONSTRAINT Categories_CategoryName_NN NOT NULL
);

CREATE TABLE Customers (
    CustomerID    NUMBER        CONSTRAINT Customers_pk PRIMARY KEY,
    CustomerName  VARCHAR2(70)  CONSTRAINT Customers_CustomerName_NN NOT NULL,
    City          VARCHAR2(70)  CONSTRAINT Customers_City_NN NOT NULL,
    PostalCode    VARCHAR2(10)  CONSTRAINT Customers_PostalCode_NN NOT NULL,
    Country       VARCHAR2(70)  DEFAULT 'Canada' CONSTRAINT Customers_Country_NN NOT NULL,
    CONSTRAINT Customers_Postal_Code_chk CHECK (LENGTH(PostalCode) BETWEEN 3 AND 10)
);

CREATE TABLE Shippers (
    ShipperID     NUMBER         CONSTRAINT Shippers_pk PRIMARY KEY,
    CompanyName   VARCHAR2(100)  CONSTRAINT Shippers_CompanyName_NN NOT NULL
                                 CONSTRAINT Shippers_CompanyName_UK UNIQUE
);

CREATE TABLE Suppliers (
    SupplierID    NUMBER         CONSTRAINT Suppliers_pk PRIMARY KEY,
    SupplierName  VARCHAR2(100)  CONSTRAINT Suppliers_SupplierName_NN NOT NULL
                                 CONSTRAINT Suppliers_SupplierName_UK UNIQUE,
    City          VARCHAR2(70)   CONSTRAINT Suppliers_City_NN NOT NULL,
    PostalCode    VARCHAR2(10)   CONSTRAINT Suppliers_PostalCode_NN NOT NULL,
    Country       VARCHAR2(70)   CONSTRAINT Suppliers_Country_CHK
                                 CHECK (Country IN ('Canada', 'USA', 'Mexique')),
    HomePage      VARCHAR2(150)  CONSTRAINT Suppliers_HomePage_NN NOT NULL
);

CREATE TABLE Employees (
    EmployeeID  NUMBER        CONSTRAINT Employees_pk PRIMARY KEY,
    Last_Name   VARCHAR2(50)  CONSTRAINT Employees_Last_Name_nn NOT NULL,
    First_Name  VARCHAR2(50)  CONSTRAINT Employees_First_Name_nn NOT NULL,
    Title       VARCHAR2(35)  CONSTRAINT Employees_Title_nn NOT NULL,
    Birthdate   DATE          CONSTRAINT Employees_Birthdate_nn NOT NULL,
    HireDate    DATE          CONSTRAINT Employees_HireDate_nn NOT NULL,
    City        VARCHAR2(70)  CONSTRAINT Employees_City_nn NOT NULL,
    PostalCode  VARCHAR2(10)  CONSTRAINT Employees_PostalCode_nn NOT NULL,
    Country     VARCHAR2(70)  DEFAULT 'Canada',
    ReportsTo   NUMBER,
    -- Self-reference: each employee reports to another employee (the CEO reports to no one)
    CONSTRAINT Employees_ReportsTo_fk
        FOREIGN KEY (ReportsTo) REFERENCES Employees(EmployeeID),
    CONSTRAINT Employees_Birthdate_chk
        CHECK (Birthdate < TO_DATE('2005-01-01', 'YYYY-MM-DD')),
    -- An employee must be at least 16 years old when hired
    CONSTRAINT Employees_Birth_HireDate_chk
        CHECK (HireDate > ADD_MONTHS(Birthdate, 16 * 12))
);

-- ================ CHILD TABLES ================

CREATE TABLE Orders (
    OrderID       NUMBER  CONSTRAINT Orders_pk PRIMARY KEY,
    CustomerID    NUMBER  CONSTRAINT Orders_CustomerID_NN NOT NULL,
    EmployeeID    NUMBER  CONSTRAINT Orders_EmployeeID_NN NOT NULL,
    ShipVia       NUMBER  CONSTRAINT Orders_ShipVia_NN NOT NULL,
    OrderDate     DATE    DEFAULT SYSDATE CONSTRAINT Orders_OrderDate_NN NOT NULL,
    RequiredDate  DATE,
    ShippedDate   DATE,
    Freight       NUMBER  DEFAULT 10
                          CONSTRAINT Orders_Freight_CHK CHECK (Freight BETWEEN 10 AND 1000),
    CONSTRAINT Orders_RequiredDate_CHK CHECK (RequiredDate > OrderDate),
    CONSTRAINT Orders_ShippedDate_CHK  CHECK (ShippedDate > OrderDate AND ShippedDate <= RequiredDate),
    CONSTRAINT Orders_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT Orders_EmployeeID_FK FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT Orders_ShipVia_FK    FOREIGN KEY (ShipVia)    REFERENCES Shippers(ShipperID)
);

CREATE TABLE Products (
    ProductID        NUMBER         CONSTRAINT Products_pk PRIMARY KEY,
    ProductName      VARCHAR2(100)  CONSTRAINT Products_ProductName_NN NOT NULL,
    CategoryID       NUMBER         CONSTRAINT Products_CategoryID_NN NOT NULL,
    SupplierID       NUMBER         CONSTRAINT Products_SupplierID_NN NOT NULL,
    QuantityPerUnit  VARCHAR2(100),
    UnitPrice        NUMBER         CONSTRAINT Products_UnitPrice_NN NOT NULL
                                    CONSTRAINT Products_UnitPrice_CHK CHECK (UnitPrice > 0),
    UnitsInStock     NUMBER         CONSTRAINT Products_UnitsInStock_NN NOT NULL,
    ReorderLevel     NUMBER         DEFAULT 5
                                    CONSTRAINT Products_ReorderLevel_CHK CHECK (ReorderLevel > 0),
    Discontinued     CHAR(1)        DEFAULT 'N'
                                    CONSTRAINT Products_Discontinued_CHK CHECK (Discontinued IN ('O', 'N')),
    CONSTRAINT Products_StockLevel_CHK CHECK (UnitsInStock >= ReorderLevel),
    CONSTRAINT Products_CategoryID_FK FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT Products_Supplier_FK   FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE OrderDetails (
    OrderID    NUMBER NOT NULL,
    ProductID  NUMBER NOT NULL,
    UnitPrice  NUMBER NOT NULL
               CONSTRAINT OrderDetails_UnitPrice_CHK CHECK (UnitPrice > 0.25),
    Quantity   NUMBER DEFAULT 1 NOT NULL
               CONSTRAINT OrderDetails_Quantity_CHK CHECK (Quantity > 0),
    Discount   NUMBER DEFAULT 0 NOT NULL
               CONSTRAINT OrderDetails_Discount_CHK CHECK (Discount BETWEEN 0 AND 1),
    CONSTRAINT OrderDetails_pk PRIMARY KEY (OrderID, ProductID),
    -- ON DELETE CASCADE: deleting an order also deletes its detail lines,
    -- so no orphan rows are left behind.
    CONSTRAINT OrderDetails_OrderID_FK
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    CONSTRAINT OrderDetails_ProductID_FK
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
