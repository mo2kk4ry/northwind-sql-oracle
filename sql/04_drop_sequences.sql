-- =============================================================
-- Northwind (NWIND) — 04. Drop sequences
-- Resets the database completely before re-creating it.
-- =============================================================
DROP SEQUENCE EmployeeID_seq;
DROP SEQUENCE CustomerID_seq;
DROP SEQUENCE OrderID_seq;
DROP SEQUENCE ProductID_seq;
DROP SEQUENCE ShipperID_seq;
DROP SEQUENCE SupplierID_seq;
DROP SEQUENCE CategoryID_seq;

-- Check the remaining sequences
SELECT sequence_name FROM USER_SEQUENCES;
