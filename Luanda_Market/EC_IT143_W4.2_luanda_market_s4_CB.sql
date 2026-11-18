-- Step 4: Create the view
CREATE VIEW v_VendorTotalSales AS
SELECT V.VendorName, SUM(T.Amount_Kz) AS TotalSalesKz
FROM Luanda_Vendors V
LEFT JOIN Vendor_Transactions T ON V.VendorID = T.VendorID
GROUP BY V.VendorName;