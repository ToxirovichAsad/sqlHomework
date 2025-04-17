CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

--Task1
SELECT 
    e.EmployeeID,
    e.ManagerID,
    e.JobTitle,
    CASE 
        WHEN e.ManagerID IS NULL THEN 0
        WHEN m.ManagerID IS NULL THEN 1
        WHEN mm.ManagerID IS NULL THEN 2
        ELSE 3
    END AS Depth
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
LEFT JOIN Employees mm ON m.ManagerID = mm.EmployeeID
ORDER BY e.EmployeeID;

--Task2

DECLARE @N1 INT = 10;

WITH FactorialCTE AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM FactorialCTE
    WHERE Num + 1 <= @N1
)

SELECT * FROM FactorialCTE
OPTION (MAXRECURSION 1000);

--Task3 

DECLARE @N INT = 10;

WITH FibonacciCTE AS (
     SELECT 
        1 AS Position, 
        1 AS FibPrev, 
        1 AS FibCurr
        UNION ALL
        SELECT 
        Position + 1,
        FibCurr,
        FibPrev + FibCurr
    FROM FibonacciCTE
    WHERE Position + 1 <= @N
)
SELECT 
    Position, 
    FibPrev AS Fib
FROM FibonacciCTE
ORDER BY Position
OPTION (MAXRECURSION 1000);
