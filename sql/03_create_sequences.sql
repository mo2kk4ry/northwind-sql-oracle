-- =============================================================
-- Northwind (NWIND) — 03. Sequences that generate primary keys
-- Author: Sanaba Kanté
-- Each table has its own start value and increment.
-- =============================================================
CREATE SEQUENCE SupplierID_seq START WITH 1   INCREMENT BY 1  MAXVALUE 500;
CREATE SEQUENCE CategoryID_seq START WITH 1   INCREMENT BY 1  MAXVALUE 400;
CREATE SEQUENCE EmployeeID_seq START WITH 1   INCREMENT BY 1  MAXVALUE 777;
CREATE SEQUENCE CustomerID_seq START WITH 100 INCREMENT BY 5  MAXVALUE 8000;
CREATE SEQUENCE ShipperID_seq  START WITH 10  INCREMENT BY 10 MAXVALUE 3000;
CREATE SEQUENCE ProductID_seq  START WITH 10  INCREMENT BY 5  MAXVALUE 10000;
CREATE SEQUENCE OrderID_seq    START WITH 1   INCREMENT BY 1  MAXVALUE 99999;
