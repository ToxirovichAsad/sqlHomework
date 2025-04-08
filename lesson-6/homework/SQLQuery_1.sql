-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Insert data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT,
    Salary INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert data into Employees
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data into Projects
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);

--TASK1
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees AS e
INNER JOIN 
    Departments AS d ON e.DepartmentID = d.DepartmentID;
--TASK 2
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees AS e
LEFT JOIN 
    Departments AS d ON e.DepartmentID = d.DepartmentID;

--TASK 3
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees AS e
RIGHT JOIN 
    Departments AS d ON e.DepartmentID = d.DepartmentID;

--TASK 4
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees AS e
FULL JOIN 
    Departments AS d ON e.DepartmentID = d.DepartmentID;
--TASK 5
SELECT 
    d.DepartmentName ,
    SUM(e.Salary)as TotalSalary 
FROM 
    Departments AS d
LEFT JOIN 
    Employees AS e ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;
--TASK6
SELECT 
  Departments.DepartmentName,
  Projects.ProjectName
FROM Departments CROSS JOIN Projects;

--TASk7 
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName,
    p.ProjectName
FROM 
    Employees AS e
LEFT JOIN 
    Departments AS d ON e.DepartmentID = d.DepartmentID
LEFT JOIN 
    Projects AS p ON e.EmployeeID = p.EmployeeID;
