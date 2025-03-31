--Task 1 not null 
CREATE TABLE student (
    id INT,
    name VARCHAR(255),
    age INT
);


ALTER TABLE student 
ALTER COLUMN id INT NOT NULL;

--Task 2 UNIQUE Constraint 
CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(255),
    price DECIMAL
);

ALTER TABLE [dbo].[product] DROP CONSTRAINT [UQ__product__47027DF4BA117085];

ALTER TABLE [dbo].[product]
ADD CONSTRAINT UQ__product__just_product UNIQUE (product_id);


ALTER TABLE [dbo].[product]
ADD CONSTRAINT UQ__product__both_name_id UNIQUE (product_id,product_name);

--Task 3 PRIMARY KEY Constraint
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name  VARCHAR(255),
    order_date DATE
);

ALTER TABLE orders
DROP CONSTRAINT [PK__orders__4659622934F871C7];

ALTER TABLE orders 
ADD CONSTRAINT PK_orders PRIMARY KEY (order_id);

--Task 4 

CREATE TABLE category(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);


CREATE TABLE item(
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    category_id INT 
    CONSTRAINT foreign_key_item FOREIGN KEY (category_id) REFERENCES category(category_id)
);

ALTER TABLE item 
DROP CONSTRAINT foreign_key_item;

ALTER TABLE item 
ADD CONSTRAINT foreign_key_item FOREIGN KEY (category_id) REFERENCES category(category_id);

--TASK 5 CHECK Constraint

CREATE TABLE account (
    account_id INT PRIMARY KEY,
    balance DECIMAL,
    account_type VARCHAR(255),
    CONSTRAINT check_balance CHECK(balance>=0),
    CONSTRAINT check_values CHECK (account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account 
DROP CONSTRAINT check_balance;

ALTER TABLE account 
ADD CONSTRAINT check_balance CHECK(balance>=0);

ALTER TABLE account 
DROP CONSTRAINT check_values;

ALTER TABLE account 
ADD CONSTRAINT check_values CHECK (account_type IN ('Saving', 'Checking'));

--TASK 6 
CREATE TABLE customer(
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255) DEFAULT 'unknown' 
    
);

ALTER TABLE customer 
DROP CONSTRAINT DF__customer__city__6477ECF3;

ALTER TABLE customer 
ADD CONSTRAINT DF__customer__city DEFAULT 'unknown' FOR city;

--Task 7 

CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    amount DECIMAL(10,2)
);

INSERT INTO invoice (amount) VALUES (100.50);
INSERT INTO invoice (amount) VALUES (200.75);
INSERT INTO invoice (amount) VALUES (150.25);
INSERT INTO invoice (amount) VALUES (300.60);
INSERT INTO invoice (amount) VALUES (250.90);


SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 500.00);

SET IDENTITY_INSERT invoice OFF;

SELECT * FROM invoice;


--TASK 8 

CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    genre VARCHAR(100) DEFAULT 'Unknown',
    CONSTRAINT not_empty CHECK (LEN(title) > 0),  
    CONSTRAINT not_zero_books CHECK (price > 0)
);
INSERT INTO books (title, price, genre) VALUES ('The Great Gatsby', 15.99, 'Classic');
INSERT INTO books (title, price, genre) VALUES ('1984', 12.50, 'Dystopian');
INSERT INTO books (title, price, genre) VALUES ('The Catcher in the Rye', 18.00, 'Fiction');
INSERT INTO books (title, price) VALUES ('To Kill a Mockingbird', 20.00);  -- Uses default genre
INSERT INTO books (title, price, genre) VALUES ('Moby-Dick', 25.99, 'Adventure');

--Task 9 

CREATE TABLE Book(
    book_id INT  PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    published_year INT
);
CREATE TABLE Member(
    member_id INT  PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(255)
);
CREATE TABLE Loan(
    loan_id INT  PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE DEFAULT NULL,
    CONSTRAINT foreign_key_book FOREIGN KEY (book_id) REFERENCES Book(book_id),
    CONSTRAINT foreign_key_member FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

INSERT INTO Book (book_id, title, author, published_year) 
VALUES (1, '1984', 'George Orwell', 1949),
       (2, 'To Kill a Mockingbird', 'Harper Lee', 1960),
       (3, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925);

INSERT INTO Member (member_id, name, email, phone_number) 
VALUES (1, 'Alice Johnson', 'alice@example.com', '123-456-7890'),
       (2, 'Bob Smith', 'bob@example.com', '987-654-3210');

INSERT INTO Loan (loan_id, book_id, member_id, loan_date) 
VALUES (1, 1, 1, '2025-03-31'),  -- Alice borrows "1984"
       (2, 2, 2, '2025-03-30');  -- Bob borrows "To Kill a Mockingbird"

UPDATE Loan 
SET return_date = '2025-04-05' 
WHERE loan_id = 1;


SELECT * FROM Loan;
SELECT * FROM Member;
SELECT * FROM Book;


