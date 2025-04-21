

SELECT * FROM Shipments



WITH recorded AS (
    SELECT Num FROM Shipments
),
missing AS (
    SELECT 0 AS Num FROM generate_series(1, 7)
),
full_data AS (
    SELECT Num FROM recorded
    UNION ALL
    SELECT Num FROM missing
),
numbered AS (
    SELECT
        Num,
        ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM full_data
),
median_values AS (
    SELECT Num FROM numbered
    WHERE rn IN (20, 21)
)
SELECT AVG(Num * 1.0) AS median
FROM median_values;
