DROP Table IF Exists Employees
CREATE TABLE Employees
(
    EmployeeId INT,
    Name VARCHAR(50),
    Department    VARCHAR(50),
    Salary        DECIMAL(10,2),
    HireDate      DATE

)
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate)
VALUES
    (1, 'Alice Johnson', 'HR', 55000.00, '2020-03-15'),
    (2, 'Bob Smith', 'IT', 72000.50, '2018-07-01'),
    (3, 'Charlie Brown', 'Finance', 63000.75, '2019-09-23'),
    (4, 'Diana White', 'Marketing', 58000.00, '2021-06-10'),
    (5, 'Ethan Davis', 'IT', 80000.00, '2017-11-05'),
    (6, 'Fiona Green', 'Sales', 49000.00, '2022-02-20'),
    (7, 'George Martin', 'HR', 60000.25, '2019-04-30'),
    (8, 'Hannah Lewis', 'IT', 85000.00, '2016-12-12'),
    (9, 'Ian Walker', 'Finance', 70000.00, '2015-08-19'),
    (10, 'Jessica Carter', 'Marketing', 56000.00, '2020-01-14'),
    (11, 'Kevin Turner', 'IT', 92000.00, '2014-05-27'),
    (12, 'Laura Scott', 'Sales', 52000.50, '2023-03-17'),
    (13, 'Michael Adams', 'Finance', 65000.00, '2021-09-05'),
    (14, 'Nancy Harris', 'HR', 58000.00, '2018-06-29'),
    (15, 'Oliver Young', 'IT', 87000.75, '2019-10-10'),
    (16, 'Paula Wright', 'Marketing', 53000.00, '2022-04-21'),
    (17, 'Quentin Brooks', 'Sales', 48000.00, '2023-08-30'),
    (18, 'Rachel Evans', 'Finance', 71000.00, '2017-02-11'),
    (19, 'Samuel Baker', 'IT', 94000.00, '2013-11-07'),
    (20, 'Tina Collins', 'HR', 60000.00, '2020-05-06'),
    (21, 'Ulysses Foster', 'Marketing', 57000.50, '2019-12-18'),
    (22, 'Victoria Reed', 'Finance', 69000.00, '2016-09-25'),
    (23, 'William Price', 'IT', 99000.00, '2012-07-15'),
    (24, 'Xander Hall', 'Sales', 53000.00, '2021-03-09'),
    (25, 'Yasmine King', 'HR', 62000.75, '2017-07-22'),
    (26, 'Zachary Moore', 'Finance', 68000.00, '2015-05-01'),
    (27, 'Ava Nelson', 'Marketing', 55000.00, '2023-01-20'),
    (28, 'Benjamin Perez', 'IT', 91000.00, '2014-02-14'),
    (29, 'Chloe Ramirez', 'Sales', 49000.00, '2022-06-05'),
    (30, 'Daniel Ross', 'HR', 60500.00, '2020-10-03');
--1
SELECT *,
    ROW_NUmber() OVER(ORDER by Salary) AS RANk
From Employees
--2
SELECT EmployeeID, Name, Department, Salary, HireDate 
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY Salary) AS ranking
    FROM Employees
) AS RankedEmployees
WHERE ranking IN (
    SELECT ranking 
    FROM (
        SELECT DENSE_RANK() OVER (ORDER BY Salary) AS ranking
        FROM Employees
    ) AS SalaryRanks
    GROUP BY ranking
    HAVING COUNT(*) > 1
)
ORDER BY ranking, Salary;
--3
SELECT EmployeeID, Name, Department, Salary, HireDate
FROM (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank <= 2
ORDER BY Department, SalaryRank;
--4
SELECT EmployeeID, Name, Department, Salary,HireDate
FROM (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank = 1
ORDER BY Department, SalaryRank;

--5

SELECT EmployeeID, Name, Department, Salary,HireDate,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY Salary) AS RunningTotal
FROM Employees
ORDER BY Department, Salary;
--6
SELECT DISTINCT Department, 
       SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees
ORDER BY Department;

--7
SELECT DISTINCT Department, 
       Cast((AVG(Salary) OVER (PARTITION BY Department) )AS DECIMAL(10,2))As Average_Salary
FROM Employees
ORDER BY Department;
--8
SELECT EmployeeID, Name, Department, Salary,HireDate,
       CAST((Salary - AVG(Salary) OVER (PARTITION BY Department) )AS decimal(10,2) )AS Difference_avg
FROM Employees
ORDER BY Department, Salary;
--9
SELECT *,
       CAST(AVG(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS DECIMAL(10,2)) AS Moving_Average
FROM Employees
ORDER BY Department, Salary;
--10

SELECT SUM(Salary) 
FROM (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RowNum
    FROM Employees
) AS Ranks
WHERE RowNum <= 3;
--11
SELECT *,
       CAST(AVG(Salary) OVER (ORDER BY EmployeeID) AS DECIMAL(10,2)) AS Moving_Average
FROM Employees
ORDER BY EmployeeID;
--12
SELECT *,
       MAX(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS Moving_MAXIMUM
FROM Employees
ORDER BY EmployeeID;

--13


SELECT *, 
       CAST((Salary / SUM(Salary) OVER (PARTITION BY Department)) * 100 AS DECIMAL(10,2)) AS Percentage_of_IT
FROM Employees
ORDER BY Department;

    

