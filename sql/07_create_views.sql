-- =============================================================
-- Northwind (NWIND) — 07. Read-only views
-- Authors: Débora Akoua Kouassi & Sanaba Kanté
-- =============================================================

-- Products with their supplier and category (3-table join)
CREATE OR REPLACE VIEW products_view AS
SELECT p.ProductID, p.ProductName, s.SupplierName, s.Country, s.City, c.CategoryName
FROM Products p
INNER JOIN Suppliers  s ON p.SupplierID = s.SupplierID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WITH READ ONLY;

SELECT * FROM products_view;

-- What each customer bought (4-table join)
CREATE OR REPLACE VIEW achat_client_view AS
SELECT c.CustomerName, p.ProductName, od.Quantity, od.UnitPrice, o.OrderDate
FROM Customers c
INNER JOIN Orders       o  ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID    = od.OrderID
INNER JOIN Products     p  ON od.ProductID = p.ProductID
WITH READ ONLY;

SELECT * FROM achat_client_view;

-- Orders handled and average quantity sold per employee (aggregate view)
CREATE OR REPLACE VIEW employe_view AS
SELECT e.Last_Name,
       e.City,
       COUNT(o.OrderID)  AS "Nombre de commandes",
       AVG(od.Quantity)  AS "Quantite moyenne vendue"
FROM Employees e
INNER JOIN Orders       o  ON e.EmployeeID = o.EmployeeID
INNER JOIN OrderDetails od ON o.OrderID    = od.OrderID
GROUP BY e.Last_Name, e.City
WITH READ ONLY;

SELECT * FROM employe_view;
