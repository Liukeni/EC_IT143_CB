-- Step 6: Load the table from the view
TRUNCATE TABLE t_VendorTotalSales;
INSERT INTO t_VendorTotalSales SELECT * FROM v_VendorTotalSales;