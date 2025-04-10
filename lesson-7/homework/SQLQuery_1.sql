CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);
SELECT * FROM OrderDetails
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Customers
--Task1
SELECT c.CustomerName,o.OrderID ,o.OrderDate
FROM Customers as c
LEFT JOIN Orders as o 
ON c.CustomerID = o.CustomerID;
--Task2 
SELECT *
FROM Customers AS c
LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
--Task3 

SELECT od.OrderID, p.ProductName, od.Quantity 
FROM OrderDetails as od 
JOIN Products as p ON od.ProductID = p.ProductID
--Task4
SELECT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(*) > 1;


--Task5

SELECT od.OrderID, od.ProductID, od.Price
FROM OrderDetails od
WHERE od.Price = (
    SELECT MAX(Price)
    FROM OrderDetails
    WHERE OrderID = od.OrderID
);
--Task6
SELECT o.OrderID, o.CustomerID, o.OrderDate AS Latest_Order
FROM Orders o
WHERE o.OrderDate = (
    SELECT MAX(OrderDate)
    FROM Orders
    WHERE CustomerID = o.CustomerID
);

--Task7 

SELECT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(DISTINCT CASE WHEN p.Category <> 'Electronics' THEN p.Category END) = 0;

--Task8
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Stationery';
--Task9

SELECT c.CustomerID, c.CustomerName, 
       SUM(od.Quantity * od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;





