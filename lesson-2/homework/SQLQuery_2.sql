
--Task1 

CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_identity (name) VALUES ('Alice');
INSERT INTO test_identity (name) VALUES ('Bob');
INSERT INTO test_identity (name) VALUES ('Charlie');
INSERT INTO test_identity (name) VALUES ('David');
INSERT INTO test_identity (name) VALUES ('Eve');

SELECT * FROM test_identity;
--USing delete will delete with specific condition and it can do it and identity also will continue as it goes not where it deleted we deleted 3 but added one it will continue with 6 not 3 
DELETE FROM test_identity WHERE id = 3;
INSERT INTO test_identity (name) VALUES ('Frank');
SELECT * FROM test_identity;
--TRuncate is different only deletes all information no condition can be given , but identity also start from begining 
TRUNCATE TABLE test_identity;
INSERT INTO test_identity (name) VALUES ('Grace');
SELECT * FROM test_identity;
-- DRop table it will delete table from database so i cannot use SELECT * FROM test_identity; here 
DROP TABLE test_identity;

--Task 2

CREATE TABLE data_types_demo
(
    name VARCHAR(50),                      
    description TEXT,                       
    age INT,                                
    price DECIMAL(10,2),                    
    is_available BIT,                       
    created_at DATETIME,                    
    event_date DATE,                        
    event_time TIME,                        
    rating FLOAT,                          
    large_number BIGINT,                    
    small_value SMALLINT 
);

INSERT INTO data_types_demo (name, description, age, price, is_available, created_at, event_date, event_time, rating, large_number, small_value)
VALUES 
('Product A', 'This is a sample product.', 25, 19.99, 1, GETDATE(), '2025-04-01', '12:30:00', 4.5, 9876543210, 10),
('Product B', 'Another example product.', 30, 29.99, 0, GETDATE(), '2025-04-02', '14:45:00', 3.8, 123456789, 5),
('Product C', 'More sample data.', 40, 49.95, 1, GETDATE(), '2025-04-03', '09:15:00', 4.9, 5555555555, 20);

SELECT * from data_types_demo;


--TASK3 

CREATE TABLE photos

(
    id INT IDENTITY PRIMARY KEY,
    image1 varbinary(MAX)
);
INSERT INTO photos(image1)
SELECT * from openrowset(
    bulk '/mnt/data/3.jpeg', single_blob
) as img;

create TABLE pythons
(
    id INT IDENTITY PRIMARY KEY,
    python varbinary(MAX)
);


INSERT INTO pythons(python)
SELECT * from openrowset(
    bulk '/mnt/data/compares.py', single_blob
) as python;
SELECT * FROM pythons
SELECT * from photos

--task 4

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    classes INT,
    tuition_per_class DECIMAL(10, 2),
    total_tuition AS (classes * tuition_per_class)  
);
INSERT INTO student (student_id, student_name, classes, tuition_per_class)
VALUES
(1, 'John Doe', 5, 1500.00),
(2, 'Jane Smith', 3, 1800.00),
(3, 'Alice Johnson', 4, 1700.00);

SELECT * from student

--TASK 5

CREATE TABLE worker (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

BULK INSERT worker
FROM '/mnt/data/workers.csv'  
WITH (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2          
);
select * from worker
