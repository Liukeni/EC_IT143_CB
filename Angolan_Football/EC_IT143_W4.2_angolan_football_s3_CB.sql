-- Step 3: Ad hoc query
SELECT T.TeamName, COUNT(P.PlayerID) AS PlayerCount
FROM Angolan_Teams T
LEFT JOIN Angolan_Players P ON T.TeamID = P.TeamID
GROUP BY T.TeamName;