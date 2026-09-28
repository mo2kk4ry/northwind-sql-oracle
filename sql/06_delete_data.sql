-- =============================================================
-- Northwind (NWIND) — 06. Empty all tables
-- Authors: Débora Akoua Kouassi & Sanaba Kanté
-- TRUNCATE for the detail table, DELETE for the others, children first.
-- =============================================================
TRUNCATE TABLE OrderDetails;
DELETE FROM Orders;
DELETE FROM Products;

DELETE FROM Shippers;
DELETE FROM Customers;
DELETE FROM Employees;
DELETE FROM Categories;
DELETE FROM Suppliers;

COMMIT;
