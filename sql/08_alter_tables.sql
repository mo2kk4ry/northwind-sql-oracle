-- =============================================================
-- Northwind (NWIND) — 08. Change the table structure
-- Authors: Débora Akoua Kouassi & Sanaba Kanté
-- =============================================================

-- Add a ContactName column to Customers
ALTER TABLE Customers ADD (ContactName VARCHAR2(50));

-- Make the HomePage column of Suppliers longer
ALTER TABLE Suppliers MODIFY (HomePage VARCHAR2(200));

-- Disable the NOT NULL constraint on Employees.City
ALTER TABLE Employees DISABLE CONSTRAINT Employees_City_nn;

-- Make Orders.Freight mandatory
ALTER TABLE Orders MODIFY (Freight CONSTRAINT Orders_Freight_nn NOT NULL);

-- Add a unique telephone column to Shippers
ALTER TABLE Shippers ADD (Telephone VARCHAR2(15));
ALTER TABLE Shippers ADD CONSTRAINT Shippers_Telephone_uk UNIQUE (Telephone);
