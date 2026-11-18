-- Step 7: Turn into a stored procedure
CREATE PROCEDURE sp_LoadVendorTotalSales
AS
BEGIN
    TRUNCATE TABLE t_VendorTotalSales;
    INSERT INTO t_VendorTotalSales SELECT * FROM v_VendorTotalSales;
END;