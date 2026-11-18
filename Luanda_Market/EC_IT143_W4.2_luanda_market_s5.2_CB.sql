-- Step 5.2: Refine the table (Add Primary Key)
ALTER TABLE t_VendorTotalSales ADD CONSTRAINT PK_VendorTotalSales PRIMARY KEY (VendorName);