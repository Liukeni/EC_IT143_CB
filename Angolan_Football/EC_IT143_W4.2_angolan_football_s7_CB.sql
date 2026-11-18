-- Step 7: Turn into a stored procedure
CREATE PROCEDURE sp_LoadTeamPlayerCount
AS
BEGIN
    TRUNCATE TABLE t_TeamPlayerCount;
    INSERT INTO t_TeamPlayerCount SELECT * FROM v_TeamPlayerCount;
END;