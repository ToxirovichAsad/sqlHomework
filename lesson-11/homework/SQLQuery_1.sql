--TASK1
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);


CREATE TABLE #EmployeeTransfers (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO  #EmployeeTransfers (EmployeeID,Name,Department,Salary)
SELECT
    EmployeeID,
    Name, 
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department
    END AS Department,
    Salary
FROM Employees;

SELECT * FROM #EmployeeTransfers;

--TASK2

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);



CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);


INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);


SELECT * FROM Orders_DB1;
SELECT * FROM Orders_DB2;



DECLARE @MissingOrders TABLE (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO @MissingOrders (OrderID, CustomerName, Product, Quantity)
SELECT o1.OrderID, o1.CustomerName, o1.Product, o1.Quantity
FROM Orders_DB1 o1
LEFT JOIN Orders_DB2 o2 ON o1.OrderID = o2.OrderID
WHERE o2.OrderID IS NULL;



SELECT * FROM @MissingOrders;

--TASK3


-- Step 1: Create the EmployeeWorkLog table
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

-- Step 2: Insert the data
INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked) VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

SELECT * FROM WorkLog;

CREATE VIEW vw_MonthlyWorkSummary AS
WITH 
EmployeeHours AS (
    SELECT 
        EmployeeID,
        EmployeeName,
        Department,
        SUM(HoursWorked) AS TotalHoursWorked
    FROM WorkLog
    GROUP BY EmployeeID, EmployeeName, Department
),

DepartmentTotal AS (
    SELECT 
        Department,
        SUM(HoursWorked) AS TotalHoursDepartment
    FROM WorkLog
    GROUP BY Department
),
DepartmentAverage AS (
    SELECT 
        Department,
        AVG(HoursWorked * 1.0) AS AvgHoursDepartment
    FROM WorkLog
    GROUP BY Department
)

SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.TotalHoursWorked,
    dt.TotalHoursDepartment,
    da.AvgHoursDepartment
FROM EmployeeHours e
JOIN DepartmentTotal dt ON e.Department = dt.Department
JOIN DepartmentAverage da ON e.Department = da.Department;


SELECT * FROM vw_MonthlyWorkSummary;
