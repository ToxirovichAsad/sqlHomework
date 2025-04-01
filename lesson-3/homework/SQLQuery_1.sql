DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

DROP TABLE IF EXISTS Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

DROP TABLE IF EXISTS Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'Alice', 'Johnson', 'IT', 75000, '2020-03-15'),
(2, 'Bob', 'Smith', 'HR', 68000, '2018-07-21'),
(3, 'Charlie', 'Brown', 'Finance', 82000, '2019-05-10'),
(4, 'David', 'White', 'IT', 91000, '2021-08-25'),
(5, 'Eva', 'Green', 'Marketing', 72000, '2017-11-30'),
(6, 'Frank', 'Black', 'Sales', 65000, '2016-06-14'),
(7, 'Grace', 'Adams', 'HR', 71000, '2019-09-03'),
(8, 'Hank', 'Miller', 'IT', 95000, '2022-01-17'),
(9, 'Ivy', 'Clark', 'Operations', 70000, '2015-04-28'),
(10, 'Jack', 'Wilson', 'Marketing', 78000, '2018-12-05'),
(11, 'Kate', 'Evans', 'Sales', 66000, '2020-02-18'),
(12, 'Liam', 'Thompson', 'Finance', 87000, '2019-06-22'),
(13, 'Mia', 'Roberts', 'HR', 72000, '2016-10-12'),
(14, 'Noah', 'Martin', 'IT', 98000, '2023-05-19'),
(15, 'Olivia', 'Hall', 'Finance', 76000, '2021-07-11'),
(16, 'Paul', 'Scott', 'Sales', 64000, '2015-03-07'),
(17, 'Quinn', 'Baker', 'Operations', 82000, '2017-09-26'),
(18, 'Ryan', 'Carter', 'Marketing', 73000, '2022-11-09'),
(19, 'Sophia', 'Lewis', 'Finance', 89000, '2018-08-15'),
(20, 'Tom', 'Walker', 'IT', 102000, '2014-05-29');

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(1, 'John Doe', '2023-03-01', 2240.06, 'Pending'),
(2, 'Jane Smith', '2023-02-25', 8650.36, 'Shipped'),
(3, 'Michael Brown', '2023-03-05', 6464.58, 'Delivered'),
(4, 'Emily Johnson', '2023-02-20', 9217.81, 'Cancelled'),
(5, 'Chris Evans', '2023-03-10', 6715.86, 'Pending'),
(6, 'Emma Wilson', '2023-02-15', 3184.34, 'Shipped'),
(7, 'Daniel Martinez', '2023-03-03', 9860.68, 'Delivered'),
(8, 'Sophia Lopez', '2023-02-28', 1753.45, 'Pending'),
(9, 'William Clark', '2023-02-18', 8632.4, 'Shipped'),
(10, 'Olivia White', '2023-03-06', 8686.59, 'Cancelled'),
(11, 'Jacob Adams', '2023-02-14', 7470.55, 'Pending'),
(12, 'Lucas Turner', '2023-03-08', 7179.9, 'Shipped'),
(13, 'Ava Stewart', '2023-02-22', 7535.41, 'Delivered'),
(14, 'Mia Hall', '2023-03-04', 7307.54, 'Pending'),
(15, 'Benjamin Murphy', '2023-02-16', 4220.73, 'Cancelled'),
(16, 'James Parker', '2023-03-02', 3153.19, 'Shipped'),
(17, 'Charlotte Nelson', '2023-02-27', 3591.88, 'Delivered'),
(18, 'Ethan Carter', '2023-03-07', 5219.01, 'Pending'),
(19, 'Grace Baker', '2023-02-19', 9078.54, 'Shipped'),
(20, 'Noah Thompson', '2023-02-21', 6040.24, 'Delivered');

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 799.99, 10),
(3, 'Headphones', 'Accessories', 99.99, 5),
(4, 'Backpack', 'Bags', 49.95, 12),
(5, 'Smartwatch', 'Electronics', 199.99, 7),
(6, 'Coffee Maker', 'Home Appliances', 89.50, 0),
(7, 'Bluetooth Speaker', 'Electronics', 129.99, 14),
(8, 'Running Shoes', 'Footwear', 75.00, 8),
(9, 'Desk Lamp', 'Furniture', 45.00, 11),
(10, 'Wireless Keyboard', 'Accessories', 59.99, 0),
(11, 'Tablet', 'Electronics', 499.99, 6),
(12, 'Office Chair', 'Furniture', 225.00, 15),
(13, 'Microwave Oven', 'Home Appliances', 149.99, 4),
(14, 'Yoga Mat', 'Fitness', 30.00, 19),
(15, 'Treadmill', 'Fitness', 999.99, 3),
(16, 'Winter Jacket', 'Clothing', 120.00, 12),
(17, 'Electric Guitar', 'Music', 350.00, 9),
(18, 'Gaming Console', 'Electronics', 499.99, 15),
(19, 'Cooking Pan Set', 'Kitchen', 89.99, 10),
(20, 'Sunglasses', 'Accessories', 75.50, 0);


--Task1 
SELECT * FROM Employees

SELECT TOP 10 PERCENT * 
FROM Employees 
ORDER BY Salary DESC;


SELECT * FROM Employees
Order BY Department;



SELECT Department, AVG(Salary) AS Average_Salary FROM Employees
GROUP BY Department;


SELECT Department, 
       AVG(Salary) AS AverageSalary,
       CASE 
           WHEN AVG(Salary) > 80000 THEN 'High'
           WHEN AVG(Salary) BETWEEN 50000 AND 80000 THEN 'Medium'
           ELSE 'Low'
       END AS SalaryCategory
FROM Employees
GROUP BY Department 
ORDER BY AverageSalary DESC;


SELECT Department, AVG(Salary) AS AverageSalary FROM Employees
GROUP BY Department 
ORDER BY AverageSalary DESC;

SELECT * FROM Employees
ORDER BY EmployeeID
OFFSET 2 ROWS
FETCH NEXT 5 ROWS ONLY;


--TASK 2 
SELECT * FROM Orders
SELECT 
    CustomerName,
    CASE 
        WHEN [Status] IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN [Status] IN ('Pending') THEN 'Pending'
        WHEN [Status] IN ('Cancelled') THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(OrderID) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY CustomerName, 
    CASE 
        WHEN [Status] IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN [Status] IN ('Pending') THEN 'Pending'
        WHEN [Status] IN ('Cancelled') THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;


--TASK3

SELECT * FROM Products

SELECT DISTINCT Category FROM Products

SELECT Category, 
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category
ORDER BY Category;


SELECT *,
       IIF(
           Stock = 0, 'Out of stock',
           IIF(Stock BETWEEN 1 AND 10, 'Low stock', 'In stock')
       ) AS InventoryStatus
FROM Products;

SELECT * FROM Products
ORDER BY Price DESC
OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY;
