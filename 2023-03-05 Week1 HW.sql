-- PARTS DATABASE CODE: --
CREATE DATABASE parts;
USE parts; 
CREATE TABLE SUPPLIER
(S_ID VARCHAR(2), SNAME VARCHAR(10),STATUS INT, CITY VARCHAR(10)); 
DESC SUPPLIER;  -- describe the SUPPLIER table --
INSERT INTO SUPPLIER (S_ID,SNAME,STATUS,CITY) 
SELECT 'S1','SMITH',20,'LONDON' 
UNION ALL 
SELECT 'S2','JONES',10,'PARIS' 
UNION ALL 
SELECT 'S3','BLAKE',30,'PARIS' 
UNION ALL 
SELECT 'S4','CLARK',20,'LONDON' 
UNION ALL 
SELECT 'S5', 'ADAMS',30,'ATHENS';

-- Find the name of each part where the weight is less than 14. --
SELECT par.PNAME, par.WEIGHT
FROM Part AS par
WHERE par.WEIGHT < 14;
# NUT, SCREW, Ruler



-- Find all unique supplier(s) where their status is equal to 30. --
SELECT DISTINCT S_ID, SNAME, Status, City
FROM Supplier
WHERE Status = 30;


-- Find out how many sales (amount) were recorded each week, per day
USE shop;
SHOW TABLES;
DESC SALES1;

SELECT s.Week, s.Day, SUM(s.SalesAmount)
FROM SALES1 AS s
GROUP BY s.Week, s.Day
ORDER BY s.Week, s.Day; # struggle to get the sorting to work as Day in ascending order



-- Change the name of salesperson Inga to be Annette instead, but only where Ignas Sales are <20.--

SET SQL_SAFE_UPDATES = 0;

DROP TABLE SALES1;
CREATE TABLE SALES1 (
    Store VARCHAR(20) NOT NULL,
    Week VARCHAR(20) NOT NULL,
    Day VARCHAR(20) NOT NULL,
    SalesPerson VARCHAR(20) NOT NULL,
    SalesAmount DECIMAL(6 , 2 ) NOT NULL,
    Month VARCHAR(20) NULL
); 

INSERT INTO  SALES1
(Store, Week, Day, SalesPerson, SalesAmount, Month) 
VALUES 
('London', '2', 'Monday', 'Frank', 56.25 , 'May'),
('London', '5', 'Tuesday', 'Frank', 74.32 , 'Sep'),
('London', '5', 'Monday', 'Bill', 98.42 , 'Sep'),
('London', '5', 'Saturday', 'Bill', 73.90 , 'Dec'),
('London', '1', 'Tuesday', 'Josie', 44.27 , 'Sep'),
('Dusseldorf', '4', 'Monday', 'Manfred', 77.00 , 'Jul'),
('Dusseldorf', '3', 'Tuesday', 'Igna', 9.99, 'Jun'),
('Dusseldorf', '4', 'Wednesday', 'Manfred', 86.81 , 'Jul'),
('London', '6', 'Friday', 'Josie', 74.02, 'Oct'),
('Dusseldorf', '1', 'Saturday', 'Manfred', 43.11, 'Apr');

UPDATE SALES1
SET SALES1.SalesPerson = 'Annette'
WHERE (SALES1.SalesPerson  = 'Igna') AND (SALES1.SalesAmount < 20); 

SELECT * FROM SALES1;

-- Find out how many sales the Dusseldolf office logged
SELECT Store, COUNT(Store)
FROM SALES1
WHERE Store = 'Dusseldorf';

-- Find the total sales amount by each person by day
SELECT sl.SalesPerson, sl.Day, SUM(sl.SalesAmount)
FROM SALES1 as sl
GROUP BY sl.SalesPerson, sl.Day
ORDER BY sl.SalesPerson, sl.Day;

-- Find out How much (sum) each person sold for between week2 and week 4
SELECT sl.SalesPerson, SUM(sl.SalesAmount)
FROM SALES1 as sl
WHERE sl.Week BETWEEN 2 AND 4
GROUP BY sl.SalesPerson;

-- For each store --
SELECT sl.Store as 'Store', 
SUM(sl.SalesAmount) as 'Total of sales', 
COUNT(sl.SalesAmount) as 'Num of sales', 
AVG(sl.SalesAmount) as 'Average Sales', 
MIN(sl.SalesAmount) as 'Lowest', 
MAX(sl.SalesAmount) as 'Highest'
FROM SALES1 as sl
GROUP BY sl.Store
ORDER BY sl.Store;


-- Find the number of sales by each person if they had more than 2 sales or equal to 2
SELECT sl.SalesPerson as 'Sales Person', 
COUNT(sl.SalesAmount) as 'Sale counts'
FROM SALES1 as sl
GROUP BY sl.SalesPerson
HAVING COUNT(sl.SalesAmount) > 2 OR COUNT(sl.SalesAmount) = 2;



-- Find the number of sales by each person, but only if they made less than £300 worth of sales in the past period
SELECT sl.SalesPerson as 'Sales Person',
COUNT(sl.SalesAmount) as 'Sales Count'
FROM SALES1 as sl
GROUP BY sl.SalesPerson
HAVING SUM(sl.SalesAmount) < 300;

-- Return the PartID, Colour and Supplier name and Project name , where the supplie's surname containes "LA" and the Supplier city is not Athens. Ensure values are unique
USE Parts;
DESC Part; -- PartID, Colour, 
DESC Project; -- JNAME
DESC Supplier; -- SNAME, City
DESC Supply;

-- Found a pattern of repeated project and parts with alternating supplier (who's name containes LA)
SELECT Part.P_ID as 'PartID',
	   Part.COLOUR as 'Colour',
       Supplier.SNAME as 'Supplier name',
       Project.JNAME as 'Project name'
FROM Part, Supplier, Project
WHERE (Supplier.SNAME LIKE '%la%') AND (Supplier.City != 'Athens');

SELECT Part.P_ID as 'PartID',
	   Part.COLOUR as 'Colour',
       Supplier.SNAME as 'Supplier name',
       Supplier.City as 'City',
       Project.JNAME as 'Project name'
FROM Supply
	INNER JOIN Part
		ON Supply.P_ID = Part.P_ID
	INNER JOIN Supplier
		ON Supply.S_ID = Supplier.S_ID
	INNER JOIN Project
		ON Supply.J_ID = Project.J_ID
WHERE (Supplier.SNAME LIKE '%la%') AND (Supplier.City != 'Athens');
       

-- Return the supplier name, part name, and project name for each case where the following are true
-- The supplier supplies a project with a part
-- And where the supplier's city project city and part city are all different
SELECT Supplier.SNAME as 'Supplier Name', 
	   Part.PNAME as 'Part Name', 
       Project.JNAME as 'Project Name',
       Supplier.City as 'Supplier City',
       Part.CITY as 'Part City',
       Project.City as 'Project City'
FROM Supplier, Part, Project
WHERE (Supplier.City != Part.CITY) AND (Part.CITY != Project.City) AND (Supplier.City != Project.City)
ORDER BY Project.City;
-- Not sure whether this is  (188 rows were generated)


SELECT Supplier.SNAME as 'Supplier Name', 
	   Part.PNAME as 'Part Name', 
       Project.JNAME as 'Project Name',
       Supplier.City as 'Supplier City',
       Part.CITY as 'Part City',
       Project.City as 'Project City'
FROM Supply
	INNER JOIN Part
		ON Supply.P_ID = Part.P_ID
	INNER JOIN Supplier
		ON Supply.S_ID = Supplier.S_ID
	INNER JOIN Project
		ON Supply.J_ID = Project.J_ID
WHERE (Supplier.City != Part.CITY) AND (Part.CITY != Project.City) AND (Supplier.City != Project.City)
ORDER BY Project.City;

