# 2022-11-02 Data Analysis
# operators: AND, OR, IS NOT
USE Backery;

# Find all savoury items that have either pork or beef filling.
SELECT sav.item_name
FROM savoury sav
WHERE sav.main_ingredient = 'pork'
OR sav.main_ingredient = 'beef';

# Find all sweet items that cost 50 cents or cheaper.
SELECT sw.item_name
FROM sweet sw
WHERE sw.price <= 0.5;

# Find all sweet items and their price, except for cannoli.
SELECT sw.item_name, sw.price
FROM sweet sw 
WHERE sw.item_name != 'cannoli';


-- perators: BETWEEN, NOT BETWEEN, LIKE, IN, IS --
# Like is especially helpful for searching patter in a column values
# It's like the regular expression

# Find all sweet items that start with the letter ‘c’
SELECT sw.item_name
FROM sweet sw
WHERE sw.item_name LIKE 'c%';


# Find all savoury items that cost more than £1, but less than £3
SELECT sav.price, sav.item_name
FROM savoury sav
WHERE sav.price BETWEEN 1 AND 3;

SELECT sav.price, sav.item_name
FROM savoury sav
WHERE sav.price >= 1 AND sav.price <= 3;

# See if Like operator can be used for numbers but not just varchar
SELECT sw.item_name, sw.price
FROM sweet sw
WHERE sw.price 
LIKE '0.%';

-- Aggregation and Order --
# ACE: ascending DESC: descending
# Groupby cluase should be put in the end
# The difference between the "HAVING" clause and "WHERE" clause is that
# HAVING filter data after data is grouped
# WHERE filter data before data is grouped
# HAVING filters records that work on summarised GROUP BY results.


CREATE DATABASE shop;
USE shop;

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
('Dusseldorf', '3', 'Tuesday', 'Inga', 9.99, 'Jun'),
('Dusseldorf', '4', 'Wednesday', 'Manfred', 86.81 , 'Jul'),
('London', '6', 'Friday', 'Josie', 74.02, 'Oct'),
('Dusseldorf', '1', 'Saturday', 'Manfred', 43.11, 'Apr');

# Find all sales records (and all columns) that took place in the London store, not in 
# December, but sales concluded by Bill or Frank for the amount higher than £50
 
 SELECT sl.Store, sl.Week, sl.Day, sl.SalesPerson, sl.SalesAmount, sl.Month
 FROM SALES1 sl
 WHERE sl.Store = 'London'
 AND sl.Month != 'Dec'
 AND sl.SalesPerson = 'Bill' OR sl.SalesPerson = 'Frank'
 AND sl.SalesAmount > '50.00';
 
 
-- Homework --
# Find out how many sales took place each week (in no particular order)
SELECT COUNT(sl.Week),
sl.week
FROM SALES1 as sl
GROUP BY  sl.Week;

# Find out how many sales took place each week (and present data by week in
# descending and then in ascending order)
SELECT COUNT(sl.Week),
sl.week
FROM SALES1 as sl
GROUP BY  sl.Week
ORDER BY sl.Week ASC;

SELECT COUNT(sl.Week),
sl.week
FROM SALES1 as sl
GROUP BY  sl.Week
ORDER BY sl.Week DESC;


# ??? Find out how many sales were recorded each week on different days of the week
SELECT sl.Week, COUNT(sl.Week), sl.Day
FROM SALES1 as sl
GROUP BY sl.Day, sl.Week;

SELECT sl.Week, COUNT(sl.Day)
FROM SALES1 sl
GROUP BY sl.Week
ORDER BY sl.Week;

SELECT COUNT(sl.Week), 
sl.Day
FROM SALES1 as sl
GROUP BY sl.Day;

# correct
SELECT s.Week, s.Day, COUNT(s.Day)
FROM SALES1 s
GROUP BY s.Week, s.Day
ORDER BY s.Week;

# correct
SELECT s.Week, s.Day, COUNT(s.Week) AS 'NUM_sales'
FROM SALES1 as s
GROUP BY s.Week , s.Day
ORDER BY s.Week , s.Day;


# We need to change salesperson's name Inga to Annette
SELECT *
FROM SALES1;

-- https://stackoverflow.com/questions/11448068/mysql-error-code-1175-during-update-in-mysql-workbench --
SET SQL_SAFE_UPDATES = 0;  -- toggle the safety mode off -- 

UPDATE SALES1
SET SALES1.SalesPerson = 'Annette'
WHERE (SALES1.SalesPerson = 'Inga');

SELECT sl.SalesPerson
FROM SALES1 as sl;

SET SQL_SAFE_UPDATES = 1;  -- turn the safety mode back on --



# Find out how many sales did Annette do
SELECT COUNT(sl.SalesPerson), sl.SalesPerson
FROM SALES1 as sl
WHERE sl.SalesPerson = 'Annette';
-- return 1 --



# Find the total sales amount by each person by day
SELECT SUM(sl.SalesAmount), sl.SalesPerson, sl.Day
FROM SALES1 as sl
GROUP BY sl.SalesPerson, sl.Day
ORDER BY sl.SalesPerson, sl.Day;



# How much (sum) each person sold for the given period
# given period: May - Oct 

SELECT SUM(sl.SalesAmount), sl.SalesPerson
FROM SALES1 as sl
WHERE sl.Month BETWEEN 'May' AND 'Oct'
GROUP BY sl.SalesPerson;

SELECT SUM(sl.SalesAmount), sl.SalesPerson
FROM SALES1 as sl
GROUP BY sl.SalesPerson
ORDER BY sl.SalesPerson;

SELECT *
FROM SALES1 as sl
WHERE CAST(sl.Month AS datetime) BETWEEN 'May' AND 'Oct';



# How much (sum) each person sold for the given period, including the number of sales per person, their average, lowest and highest sale amounts
SELECT SUM(sl.SalesAmount), sl.SalesPerson, COUNT(sl.SalesAmount), AVG(sl.SalesAmount), MIN(sl.SalesAmount), MAX(sl.SalesAmount)
FROM SALES1 as sl
WHERE sl.Month BETWEEN 'Apr' AND 'Dec'
GROUP BY sl.SalesPerson;
# ????? How to filter with BETWEEN operator when the Month column's datatype is varchar

# -- correct --
SELECT SUM(sl.SalesAmount) as 'SUM', 
sl.SalesPerson as 'Person', 
COUNT(sl.SalesAmount) as 'Num of sales', 
AVG(sl.SalesAmount) as 'Average Sales', 
MIN(sl.SalesAmount) as 'Minimum', 
MAX(sl.SalesAmount) as 'Maximum'
FROM SALES1 as sl
GROUP BY sl.SalesPerson
ORDER BY sl.SalesPerson;



# Find the total monetary sales amount achieved by each store
SELECT SUM(sl.SalesAmount), sl.Store
FROM SALES1 as sl
GROUP BY sl.Store
ORDER BY sl.Store;

# Find the number of sales by each person if they did less than 3 sales for the past period
SELECT COUNT(sl.SalesAmount), sl.SalesPerson
FROM SALES1 as sl
GROUP BY sl.SalesPerson
HAVING COUNT(sl.SalesAmount) < 3;


# Find the total amount of sales by month where combined total is less than £100
SELECT SUM(sl.SalesAmount), sl.Month
FROM SALES1 as sl
GROUP BY sl.Month
HAVING SUM(sl.SalesAmount) < 100;







