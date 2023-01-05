# 2022-11-16 Functions
-- LENGTH() - Return the length of a string in bytes
SELECT LENGTH('CodeFirstGirls'), LENGTH('CodeFirstGirls_12345');

-- CONCAT() - Return concatenated string
SELECT CONCAT('Code', 'First', 'Girls') AS 'Concatenated Result'; 
SELECT CONCAT("Let's", ' ', 'learn', ' SQL') AS 'Concatenated Result';
SELECT CONCAT('Learn',' ','coding') AS 'Hello';

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

USE Customer;
-- Table Column
SELECT 	CONCAT(first_name, ' ', last_name) AS Concatenated_Full_Name,
		REVERSE(CONCAT(first_name, ' ', last_name)) AS Reversed_Full_Name
FROM Customer.customer; -- alternativly use any other DB populated with names (default db sakila.actor comes with names)

SELECT Customer.customer.first_name
FROM Customer.customer;


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

--------
USE bank;
UPDATE accounts 
SET 
    balance = balance - 50
WHERE
    account_number = 111112
        AND account_holder_surname = 'Smith';
        
--------
USE bank;
UPDATE accounts 
SET 
    balance = balance + 50
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


