# 2022-11-09 Data Analysis for Complex Structures
# Practice Inner and Outter join

CREATE DATABASE JOINS_PRACTICE;

USE JOINS_PRACTICE;

-- Create table 1
CREATE TABLE Table1_fruit_basket
(ID INT, Fruit VARCHAR(50));

INSERT INTO Table1_fruit_basket 
(ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(4, 'orange'),
(5, 'banana');


-- Create table 2
CREATE TABLE Table2_fruit_basket
(ID INT, Fruit VARCHAR(50));

INSERT INTO Table2_fruit_basket 
(ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(6, 'melon'),
(7, 'peach'),
(8, 'plum');

-- INNER JOIN -- 
SELECT t1.*, t2.*
FROM  
	Table1_fruit_basket t1
		INNER JOIN
	Table2_fruit_basket t2
		ON # the ON clause is like we need to meet the following condition
        t1.ID  = t2.ID;

SELECT 
	t1.ID AS T1_ID, 
	t2.ID AS T2_ID,
    t1.Fruit AS T1_Fruit,
    t2.Fruit AS T2_Fruit
FROM  
	Table1_fruit_basket t1
		INNER JOIN
	Table2_fruit_basket t2
		ON 
        t1.ID  = t2.ID;



-- LEFT JOIN --
SELECT 
	t1.ID AS T1_ID, 
	t2.ID AS T2_ID,
    t1.Fruit AS T1_Fruit,
    t2.Fruit AS T2_Fruit
FROM  
	Table1_fruit_basket t1
		LEFT JOIN
	Table2_fruit_basket t2
		ON 
        t1.ID  = t2.ID;


-- RIGHT JOIN --
SELECT 
	t1.ID AS T1_ID, 
    t1.Fruit AS T1_Fruit,
    t2.ID AS T2_ID,
    t2.Fruit AS T2_Fruit
FROM  
	Table1_fruit_basket t1
		LEFT JOIN
	Table2_fruit_basket t2
		ON 
        t1.ID  = t2.ID;


-- UNION --
# 2 set of query
SELECT * FROM Table1_fruit_basket t1
LEFT JOIN Table2_fruit_basket t2 ON t1.ID = t2.ID
UNION
SELECT * FROM Table1_fruit_basket t1
RIGHT JOIN Table2_fruit_basket t2 ON t1.ID = t2.ID;

# this way the table will not be separate out side-by-side
SELECT * FROM Table1_fruit_basket t1
UNION
SELECT * FROM Table2_fruit_basket t2;

SELECT * FROM Table1_fruit_basket t1
UNION ALL # this way the duplicate will be dropped
SELECT * FROM Table2_fruit_basket t2;


-- CROSS JOIN --
SELECT t1.*, t2.*
FROM  
	Table1_fruit_basket t1
	CROSS JOIN
	Table2_fruit_basket t2;


-- SUBQUERY --
CREATE DATABASE employees;
USE employees;
CREATE TABLE employee
(EmployeeID int(11) NOT NULL,
  Name varchar(55),
  ManagerID int(11),
  PRIMARY KEY (`EmployeeID`)
);

INSERT INTO Employee
(EmployeeID, Name, ManagerID)
VALUES
(1, 'Mike', 3),
(2, 'David', 3),
(3, 'Roger', NULL),
(4, 'Marry',2),
(5, 'Joseph',2),
(7, 'Ben',2);

-- SUBQUERY EXAMPLE Find the customer whose phone number is 555-3344
USE customer;
SELECT first_name, surname
FROM customer.customer c
WHERE c.customer_id IN 
	(SELECT ph.phone_number_customer_id
        FROM  customer.phone_number ph
        WHERE ph.phone_number = '555-3344');


-- Homework --
# use the database called parts.
USE Parts;

SELECT p.*
FROM Part as p;

SELECT pro.*
FROM Project as pro;

SELECT s.*
FROM Supplier as s;

SELECT sp.*
FROM Supply as sp;


# 1. Find the name and status of each supplier who supplies project J2
-- The Supply table has S_ID, P_ID. The name and status are at  Supplier table--
SELECT Supplier.SNAME, Supplier.Status, Supplier.S_ID
FROM Supplier
WHERE Supplier.S_ID IN
	(SELECT Supply.S_ID
		FROM Supply
		WHERE Supply.P_ID = 'P2'); # note that this only give the unique results


-- I thought about left join first and filter but don't know how to write the subquery after the joined tables --
SELECT  Supply.*, Supplier.*
FROM Supply 
	LEFT JOIN
    Supplier 
    ON Supply.S_ID = Supplier.S_ID; # Using left join revealed that there are actually 2 records of SNAME=Adams, Status=30, S_ID=S5




# 2. Find the name and city of each project supplied by a London-based supplier
-- Both the Supplier table and Project table have City column --
-- Project name and city are in Project table --

SELECT Project.JNAME, Project.City
FROM Project
WHERE Project.City in
	(SELECT Supplier.City
    FROM SUpplier
    WHERE Supplier.City = 'London');


SELECT Supplier.*, Project.*
FROM Supplier
	LEFT JOIN
	Project
    ON Supplier.City = Project.City;


# 3. Find the name and city of each project not supplied by a London-based supplier
SELECT Project.JNAME, Project.City
FROM Project
WHERE Project.City NOT IN
	(SELECT Supplier.City
    FROM SUpplier
    WHERE Supplier.City = 'London');



# 4. Find the supplier name, part name and project name for each case where a supplier supplies 
# a project with a part, but also the supplier city, project city and part city are the same.
-- 3 tables to join: Supplier(SNMAE), Part(PNMAE), Project(JNAME). The Primary key of these three table are in Supply table--
Use Parts;

SELECT Supplier.SNAME as Supplier_Name, 
	   Part.PNAME as Part_Name, 
       Project.JNAME as Project_Name,
       Supplier.City as Supplier_City,
       Part.CITY as Part_City,
       Project.City as Project_City
FROM Supplier, Part, Project
WHERE (Supplier.City = Part.CITY) AND (Part.CITY = Project.City) AND (Supplier.City = Project.City)
ORDER BY Project.City;

# not sure how to verify this query's result
# Faridat's code
select *
from Supply spy 
inner join
Supplier spr
on spy.S_ID = spr.s_id
inner join part p 
on spy.p_ID = p.p_id
inner join project prj 
on spy.j_ID = prj.j_id
WHERE spr.city = p.city 
and p.city = prj.city;
