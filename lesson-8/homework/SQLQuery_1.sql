-- Create the table
CREATE TABLE Groupings (
    [Step Number] INT,
    Status VARCHAR(10)
);

-- Insert the data
INSERT INTO Groupings ([Step Number], Status) VALUES
(1, 'Passed'),
(2, 'Passed'),
(3, 'Passed'),
(4, 'Passed'),
(5, 'Failed'),
(6, 'Failed'),
(7, 'Failed'),
(8, 'Failed'),
(9, 'Failed'),
(10, 'Passed'),
(11, 'Passed'),
(12, 'Passed');

SELECT * FROM Groupings

SELECT 
  MIN([Step Number]) AS [Min Step Number],
  MAX([Step Number]) AS [Max Step Number],
  Status,
  COUNT(*) AS [Consecutive Count]
FROM (
  SELECT 
    [Step Number],
    Status,
    ROW_NUMBER() OVER (ORDER BY [Step Number]) 
    - ROW_NUMBER() OVER (PARTITION BY Status ORDER BY [Step Number]) AS grp
  FROM Groupings
) AS sub
GROUP BY Status, grp
ORDER BY [Min Step Number];


CREATE TABLE dbo.EMPLOYEES_N (
    EMPLOYEE_ID INT NOT NULL,
    FIRST_NAME VARCHAR(20),
    HIRE_DATE DATE NOT NULL
);
INSERT INTO dbo.EMPLOYEES_N (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE) VALUES
(1, 'Alice', '1975-06-01'),
(2, 'Bob', '1976-08-12'),
(3, 'Charlie', '1977-05-09'),
(4, 'David', '1979-03-15'),
(5, 'Eve', '1980-11-20'),
(6, 'Frank', '1982-01-11'),
(7, 'Grace', '1983-07-22'),
(8, 'Hank', '1984-02-05'),
(9, 'Ivy', '1985-04-19'),
(10, 'Jack', '1990-10-30'),
(11, 'Karen', '1997-09-18');

SELECT * FROM EMPLOYEES_N
SELECT      CAST(MIN(year) AS VARCHAR(4)) + ' - ' + CAST(MAX(year) AS VARCHAR(4)) AS [Years]

FROM (
    SELECT 
        y.year,
        y.year - ROW_NUMBER() OVER (ORDER BY y.year) AS grp
    FROM (
        SELECT TOP (YEAR(GETDATE()) - 1975 + 1) 
               1974 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS year
        FROM sys.all_objects a CROSS JOIN sys.all_objects b
    ) y
    WHERE y.year NOT IN (
        SELECT DISTINCT YEAR(HIRE_DATE) FROM dbo.EMPLOYEES_N
    )
)AS MissingYears
GROUP BY grp
ORDER BY MIN([year]);