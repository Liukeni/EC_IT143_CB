-- Step 3: Ad hoc query
SELECT V.VendorName, SUM(T.Amount_Kz) AS TotalSalesKz
FROM Luanda_Vendors V
LEFT JOIN Vendor_Transactions T ON V.VendorID = T.VendorID
GROUP BY V.VendorName;