-- Step 6: Load the table from the view
TRUNCATE TABLE t_HelloWorld;
INSERT INTO t_HelloWorld SELECT * FROM v_HelloWorld;