-- Step 7: Turn into a stored procedure
CREATE PROCEDURE sp_LoadHelloWorld
AS
BEGIN
    TRUNCATE TABLE t_HelloWorld;
    INSERT INTO t_HelloWorld SELECT * FROM v_HelloWorld;
END;