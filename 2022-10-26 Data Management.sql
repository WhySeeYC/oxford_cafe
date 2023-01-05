CREATE DATABASE Parts;

USE Parts;
CREATE TABLE Supplier
(S_ID VARCHAR(2),
SNAME VARCHAR(10),
Status INT,
City VARCHAR(10));

CREATE TABLE Part
(P_ID CHAR(2),
PNAME CHAR(10),
COLOUR CHAR(10),
WEIGHT INT,
CITY CHAR(10));

CREATE TABLE Project
(J_ID CHAR(2),
JNAME CHAR(10),
City CHAR(10));

CREATE TABLE Supply
(S_ID CHAR(2),
P_ID CHAR(2),
J_ID CHAR(2), 
Quantity INT);

INSERT INTO Supplier
(S_ID, SNAME, Status, City)
VALUES
('S1', 'Smith', 20, 'London'),
('S1', 'Jones', 10, 'Paris'),
('S3', 'Black', 30, 'Paris'),
('S4', 'Clark', 20, 'London'),
('S5', 'Adams', 30, 'Athens');



INSERT INTO Part
(P_ID, PNAME, COLOUR, WEIGHT, City)
VALUES
('P1', 'NUT', 'Red', 12, 'London'),
('P2', 'Bolt', 'Blue', 17, 'Rome'),
('P3', 'SCREW', 'Red', 14, 'London'),
('P4', 'SCREW', 'Blue', 12, 'Paris'),
('P6', 'COG', 'Red', 19, 'London');


INSERT INTO Project
(J_ID, JNAME, CITY)
VALUES
('J1', 'SPORTER', 'Paris'),
('J2', 'DISPLAY', 'Rome'),
('J3', 'OCR', 'Athens'),
('J4', 'CONSOLE', 'Athens'),
('J5', 'Raid', 'London'),
('J6', 'EDS', 'Oslo'),
('J7', 'TAPE', 'London');

INSERT INTO Supply
(S_ID, P_ID, J_ID, QUANTITY)
VALUES
('S1', 'P1', 'J1', 200),
('S1', 'P1', 'J4', 700),
('S2', 'P3', 'J1', 400),
('S2', 'P3', 'J2', 200),
('S2', 'P3', 'J3', 200),
('S2', 'P3', 'J4', 500),
('S2', 'P3', 'J5', 600),
('S2', 'P3', 'J6', 400),
('S2', 'P3', 'J7', 800),
('S2', 'P5', 'J2', 100),
('S3', 'P3', 'J1', 200),
('S3', 'P4', 'J2', 500),
('S4', 'P6', 'J3', 300),
('S4', 'P6', 'J7', 300),
('S5', 'P2', 'J2', 200),
('S5', 'P2', 'J4', 100),
('S5', 'P5', 'J5', 500),
('S5', 'P5', 'J7', 100),
('S5', 'P6', 'J2', 200),
('S5', 'P1', 'J4', 100),
('S5', 'P3', 'J4', 200),
('S5', 'P4', 'J4', 800),
('S5', 'P5', 'J4', 400),
('S5', 'P6', 'J4', 500);

SELECT DISTINCT p.PNAME 
FROM Part as p; # we call the Part table p


SELECT DISTINCT p.P_ID, p.PNAME
FROM Part as p;


/* Refer to the table 'projects' and return all projects that are run in London.*/
SELECT DISTINCT prj.J_ID, prj.JNAME, prj.City
FROM Project as prj
WHERE prj.City = 'London';


# constraints: NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY, DEFAULT

CREATE DATABASE Customer;
USE Customer;

# drop table customer;
CREATE TABLE  customer
(customer_id INT NOT NULL Primary Key, # required and apply a primary key
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50));


CREATE TABLE address (
    address_id INTEGER NOT NULL,
    building_number VARCHAR(55) NOT NULL,
    street VARCHAR(55) NOT NULL,
    city VARCHAR(55),
    post_code VARCHAR(55) NOT NULL,
    country VARCHAR(55),
    CONSTRAINT PK_Address PRIMARY KEY (address_id)
);


CREATE TABLE email_address (
    email_address_id INTEGER NOT NULL,
    email_address_customer_id INTEGER,
    email_address VARCHAR(55) NOT NULL,
    CONSTRAINT PK_email_address PRIMARY KEY (email_address_id)
);

CREATE TABLE phone_number (
    phone_number_id INTEGER NOT NULL,
    phone_number_customer_id INTEGER NOT NULL,
    phone_number VARCHAR(55) NOT NULL,
    CONSTRAINT PK_phone_number PRIMARY KEY (phone_number_id)
);

CREATE TABLE orders (
    order_id INTEGER NOT NULL,
    orders_customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    CONSTRAINT PK_order_id PRIMARY KEY (order_id)
);


INSERT INTO address 
(address_id, building_number, street, city, post_code, country) 
VALUES 
(1, '20', 'Birch Alley', 'London', 'SE24 0AB', 'UK'),
(2, '17', 'Oak Street', 'London', 'SE25 0XY', NULL);

INSERT INTO customer 
(customer_id, first_name, last_name) 
VALUES 
(1, 'Jon', 'Flanders'),
(2, 'Sam', 'Smith');

INSERT INTO email_address 
(email_address_id, email_address_customer_id, email_address)
 VALUES 
 (1, 2, 'ssmith@mail.com'),
 (2, 1, 'jon@mail.com');
 
 
 INSERT INTO phone_number 
 (phone_number_id, phone_number_customer_id, phone_number) 
 VALUES 
 (1, 1, '555-1212'),
 (2, 2, '555-3344');
 
 
 INSERT INTO orders 
 (order_id, orders_customer_id, order_date) 
 VALUES 
 (1, 1, '2019-08-20'),
 (2, 2, '2019-03-15');


# DDL: Data Definition Language: SELECT, INSERT, UPDATE, DELETE

UPDATE orders
SET 
orders.order_id  = 4
WHERE 
orders.order_date = '2019-03-15';

# how to find the database on the side


# TODO: Find the name and weight of read red part
USE Parts;

SELECT p.PNAME, p.WEIGHT
FROM Part p
WHERE p.COLOUR = "Red";


# TODO: find all unique seupplier(s) from London

 

