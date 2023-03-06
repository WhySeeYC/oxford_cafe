# 2022-11-16 Functions
-- LENGTH() - Return the length of a string in bytes
SELECT LENGTH('CodeFirstGirls'), LENGTH('CodeFirstGirls_12345');

-- CONCAT() - Return concatenated string
SELECT CONCAT('Code', 'First', 'Girls') AS 'Concatenated Result'; 
SELECT CONCAT("Let's", ' ', 'learn', ' SQL') AS 'Concatenated Result';
SELECT CONCAT('Learn',' ','coding') AS 'Hello';

SELECT CONCAT('Learn', IFNULL(NULL, ' '), 'coding') AS 'Concatenated result' -- IFNULL can be used to check and replace the NULL value with either empty space or other stuff

SELECT CONCAT(item_name, COALESCE(main_ingredient, ' ')) FROM Backery.Savoury; -- COALESCE can be used to pass in a column that you don't necessarily know whether there is NULL value
-- The COALESCE function is useful in situations where you need to return a default value when a column is null

-- LCASE() -Return the argument in lowercase - Synonym for LOWER()
SELECT LCASE('CodeFirstGirls'), LOWER('LOWER CASE WORD');

-- UCASE() -Return the argument in uppercase - Synonym for UPPER()
SELECT UCASE('CodeFirstGirls'), UPPER('upper case word');

-- LEFT() - Return the leftmost number of characters as specified
SELECT LEFT('CodeFirstGirls', 4), LEFT('Database', 3);

-- RIGHT()- Return the specified rightmost number of characters
SELECT RIGHT('CodeFirstGirls', 5), RIGHT('Database', 4);

-- RTRIM() - Remove trailing spaces
SELECT RTRIM('   CodeFirstGirls   '), LENGTH(RTRIM('   CodeFirstGirls   ')), LENGTH(RTRIM('   CodeFirstGirls'));

-- LTRIM() - Remove leading spaces
SELECT LTRIM('   CodeFirstGirls   '), LENGTH(LTRIM('CodeFirstGirls   '));

-- TRIM() - Remove leading and trailing spaces
SELECT TRIM('   CodeFirstGirls   '), LENGTH(TRIM('CodeFirstGirls'));

-- STRCMP() returns 0 if the strings are the same
-- -1 if the first argument is smaller than the second according to the current sort order
-- 1 if the first argument is larger than the second according to the current sort order
SELECT 	STRCMP('MyCodeFirstGirls', 'CodeFirstGirls'), 
		STRCMP('CodeFirstGirls', 'MyCodeFirstGirls'), 
		STRCMP('CodeFirstGirls', 'CodeFirstGirls');

-- REVERSE() - Reverse the characters in a string
SELECT REVERSE('CodeFirstGirls');


-- RAND() - return a random floating-point value
SELECT RAND() AS RandomValue;
SELECT RAND(6) AS RandomValue; -- the 6 is the seed value, that basically make sure the result is reproduciable
SELECT CEILING(RAND()*888) AS RandomValue; -- CEILING - return the smallest integer value not less than the argument

-- ABS() returns absolute value
SELECT ABS(-5);

-- DEGREES() -- convert radians to degree
SELECT DEGREES(PI());

-- FLOOR() -- return the largest integer value not greater than the argument
SELECT FLOOR(12.34), FLOOR(-12.34);

-- POW() - return the argument raised to the specified power
SELECT POW(3, 2);
SELECT POWER(3, 2);


-- SQRT() - return the square root of the argument
SELECT SQRT(4);

-- Table column??
SELECT price,
    ROUND(price, 2) AS Price,
    price-0.10,
    CAST(price-0.10 AS (3, 1)), -- CAST()??
FROM shop;
---------

USE Customer;
-- Table Column
SELECT 	CONCAT(first_name, ' ', last_name) AS Concatenated_Full_Name,
		REVERSE(CONCAT(first_name, ' ', last_name)) AS Reversed_Full_Name
FROM Customer.customer; -- alternativly use any other DB populated with names (default db sakila.actor comes with names)

SELECT Customer.customer.first_name
FROM Customer.customer;




-- 2023-03-06 Courses:

-- ADDDATE() or DATE_ADD() - add time values to a date value
SELECT ADDDATE('2020-01-01', INTERVAL 15 DAY);
SELECT ADDDATE('2020-01-01', INTERVAL 2 WEEK);
SELECT ADDDATE('2020-01-01', INTERVAL 1 MONTH);


-- SUBDATE() or DATE_SUB() - opposite of ADDDATE()
SELECT SUBDATE('2020-01-01', INTERVAL 15 DAY);

-- Return the current date
SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE;

-- REturn the current time
SELECT CURRENT_TIME(), CURRENT_TIME, CURTIME();

-- Returns the current time and date
SELECT NOW(), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP;

-- Format Date and Time
SELECT DATE_FORMAT('2020-10-05 11:22:00', '%W %M %Y');
SELECT DATE_FORMAT('2020-10-05 11:22:00', '%d %b %Y %T %f');


-- CONVERT()
SELECT CONVERT('2019-08-10 14:47:22', DATE) AS DATE1,
       CONVERT('10-08-19', DATE) AS DATE2,
       CONVERT('100819', DATE) AS DATE3;


-- For float(M, D), double(M, D), DECIMAL(M, D), M must >= D
SELECT CONVERT('11.1', DECIMAL(3, 1)) AS Dec1;



-- Example of CASE Operator

SET @Var = 5; -- try changing the number to different values

SELECT 
    CASE @Var
        WHEN 1 THEN 'one'
        WHEN 2 THEN 'two'
        ELSE 'higher than 2'
    END AS TheNumberIs;


-- Example of Case Operator
SET @Var = 5; -- try changing the number to different 
SELECT 
    CASE
        WHEN @Var = 1 THEN 'one'
        WHEN @Var = 2 THEN 'two'
        ELSE '2+'
    END AS TheNumberIs;

-- you can also do this
SET @Var = 1; -- try changing the number to different 
SELECT 
    CASE @Var
        WHEN 1 THEN 'one'
        WHEN 2 THEN 'two'
        ELSE '2+'
    END AS TheNumberIs;


-- Multiple conditions
SET @Var1 = 11;
SET @Var2 = 12;
SELECT 
    CASE
        WHEN (@Var1 = 11 AND @Var2 = 13) THEN 'one' -- the () contains 2 expressions
        WHEN @Var2 = 12 THEN 'two'
        ELSE '2+'
    END AS TheNumberIs;


-- Example of IF functions
SELECT IF(1 > 2, 2, 3); -- statement, result if True, result if False

SELECT IF(1 < 2, 'yes', 'no'); -- statement, result if True, result if False

SELECT IF(YEAR(NOW()) = 2020, 'yes', 'no') AS 'RESULT';
SELECT IF(YEAR(NOW()) = 2023, 'yes', 'no') AS 'RESULT';


-- Example of IFNULL Function
SELECT IFNULL(1, 0);
SELECT IFNULL(NULL, 0);
SELECT 1 / 0;  -- can't divide anything with zero
SELECT IFNULL(1 / 0, 'Yes');

-- Example of NULLIF Function
-- compare two expressions and returns NULL if they are equal. Otherwise return first expression
SELECT NULLIF(1, 1);
SELECT NULLIF(5, 2);



-- START TRANSACTION and BEGIN and BEGIN WORK perfrom the same action. Sequence of actions need to be in order

START TRANSACTION;
---
<
get latest booking number, 
increase it by one, 
insert a new booking into a table, 
check that it is available, 
insert booking info into another table
>
---
COMMIT;

-- Practice TRANSCATION

CREATE DATABASE bank;

USE bank;
DROP TABLE accounts;

USE bank;
CREATE TABLE accounts
(account_number INT NOT NULL,
account_holder_name VARCHAR(50),
account_holder_surname VARCHAR(50),
balance INT,
overdraft_allowed BOOLEAN);

USE bank;
INSERT INTO accounts
(account_number, account_holder_name, account_holder_surname, balance, overdraft_allowed)
VALUES
(111112, 'Julie', 'Smith', 150, TRUE),
(111113, 'James', 'Andrews', 20, FALSE),
(111114, 'Jack', 'Oakes', -70, true),
(111115, 'Jasper', 'Wolf', 200, true);

-- quick check
SELECT balance FROM bank.accounts
WHERE account_number = 111112 AND account_holder_surname = 'Smith';

-- step 1, to set the variable to be one of the column, use :=
@moneyAvailable:= balance
-- The symbol ":=" in MySQL is called the assignment operator. It is used to assign a value to a user-defined variable or to assign the result of an expression to a column alias in a SELECT statement. For example, if you want to assign a value to a user-defined variable named "x", you can use the := operator as follows: SET @x := 10;


USE bank;
SELECT * FROM accounts;
-- 1. start a new transaction
START TRANSACTION;

SELECT 
    @moneyAvailable:=IF(balance > 0, balance, 0) AS MONEY
FROM
    bank.accounts
WHERE
    account_number = 111112
        AND account_holder_surname = 'Smith';
        
--------
SET @TransferAmount = 50;

-- can also do
SET @TransferAmount = IF(@moneyAvailable >= 50, 50, 0)

--------
USE bank;
UPDATE accounts 
SET 
    balance = balance - 50 -- 50 or @TransferAmount
WHERE
    account_number = 111112
        AND account_holder_surname = 'Smith';
        
--------
USE bank;
UPDATE accounts 
SET 
    balance = balance + 50 -- 50 or @TransferAmount
WHERE
    account_number = 111115
        AND account_holder_surname = 'Wolf';

--------
USE bank;
select *
from accounts;

-- 2. (optional) Try Rollback to see how it works
ROLLBACK;

-- 3. commit changes 
COMMIT;


---------------------------------------------------
-- Index -> this ensure the search of database become more efficient
-- The cost of index is that it require extra storage

CREATE INDEX idx_name
ON table_name

USE shop;
DESC SALES1;

SELECT * FROM shop.SALES1
WHERE SalesPerson = 'Frank';

CREATE INDEX sales_person_index
ON shop.SALES1(SalesPerson);

ALTER TABLE shop.SALES1
DROP index sales_person_index;



