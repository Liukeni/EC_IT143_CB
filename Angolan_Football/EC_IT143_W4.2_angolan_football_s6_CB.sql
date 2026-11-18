-- Step 6: Load the table from the view
TRUNCATE TABLE t_TeamPlayerCount;
INSERT INTO t_TeamPlayerCount SELECT * FROM v_TeamPlayerCount;