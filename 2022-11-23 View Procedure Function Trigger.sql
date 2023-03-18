-- 2022-11-23 VIEWS STORE, Procedure information, Trogger and events
USE shop;
SELECT *
FROM shop.SALES1;

-- Create a view
USE shop;
CREATE VIEW vw_salespeople
AS
SELECT SalesPerson, SalesAmount
FROM SALES1;

USE shop;
CREATE VIEW vw_storesales 
AS
SELECT Store, SalesAmount
FROM SALES1; 

USE shop;
SELECT * 
FROM vw_salespeople;

USE shop;
SELECT *
FROM vw_storesales;

-- you can query the view in exactly the same way as a table
USE shop;
SELECT DISTINCT SalesPerson, Max(SalesAmount)
FROM vw_salespeople
WHERE SalesAmount > 70 
GROUP BY SalesPerson;

-- show the store location that had the salesamount > 90
USE shop;
SELECT Store, SalesAmount
FROM vw_storesales
WHERE SalesAmount > 70
ORDER BY SalesAmount DESC;


-- Part1 

CREATE DATABASE practice;
USE practice;
CREATE TABLE staff (
  `employeeID` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `jobtitle` VARCHAR(45) NOT NULL,
  `managerID` INT NOT NULL,
  `department` VARCHAR(45) NULL,
  `salary` INT NOT NULL,
  `dateofbirth` DATE NOT NULL,
  PRIMARY KEY (`employeeID`));

USE practice;
INSERT INTO staff(
    employeeID,
    firstName,
    lastName,
    jobtitle,
    managerID,
    department,
    salary,
    dateofbirth
) 
VALUES(
    1245,
    'Julie',
    'Smith',
    'DBA',
    '3333',
    'Database Administrators',
    50000,
    '1985-10-20'
),
(
    4578,
    'Jame',
    'Blogs',
    'DBA',
    '3333',
    'Database Administrators',
    52000,
    '1970-10-22'
);

USE practice;
SELECT *
FROM staff;


-- we need to alter the table and give default values, so when inserting through view, the columns not in the view will be defaulted as default value--

USE practice;
ALTER TABLE practice.staff 
CHANGE COLUMN `salary` `salary` INT(11) NULL DEFAULT 0 ,
CHANGE COLUMN `dateofbirth` `dateofbirth` DATE NULL DEFAULT '1900-01-01' ;

-- this way, no need to use database over and over again -- 
SELECT * FROM practice.staff; 

-- create a new view
USE practice;
CREATE OR REPLACE VIEW vw_staff_common AS
    SELECT 
        employeeID,
        firstName,
        lastName,
        jobtitle,
        managerID,
        department
        -- we don't want anyone except from HR to see people's salaries or dob, so the view would hid ethe info
    FROM
        staff
    WHERE
        jobtitle LIKE '%DB%';


SELECT * from practice.vw_staff_common;

-- When updated values in actual database, the view will be updated as well
-- vw_staff_common is a simple view, so it is possible to update it

-- Let's insert a row into the staff table through the vw_staff_common view.
USE practice;
INSERT INTO vw_staff_common (
    employeeID,
    firstName,
    lastName,
    jobtitle,
    managerID,
    department
) 
VALUES(
    8888,
    'Mike',
    'Davies',
    'Developer',
    2323,
    'Database Administrators'
);





select * from practice.vw_staff_common; 
-- NB that the newly created employee is not visible through the vw_staff_common view, because employee's job title is Developer, which is not like the %DB% pattern. 


select * from practice.staff;  
--  can see the new person, and the salary and date of birth are the default values





-- PART 2
-- Let's modify the view to add WITH CHECK OPTION and see how it behaves. 

USE practice;
CREATE OR REPLACE VIEW vw_staff_common2 AS
    SELECT 
        employeeID,
        firstName,
        lastName,
        jobtitle,
        managerID,
        department
    FROM
        staff
    WHERE
        jobtitle LIKE '%DB%' 
	WITH CHECK OPTION; --NB the CHECK OPTION

SELECT *FROM practice.vw_staff_common2;
    
-- Again let's try to insert a row into the staff table through vw_staff_common2
USE practice;
INSERT INTO vw_staff_common2 (
    employeeID,
    firstName,
    lastName,
    jobtitle,
    managerID,
    department
) 
VALUES(
    5555,
    'Thomas',
    'Fisher',
    'Developer',
    8989,
    'Database Administrators'
);
-- our attempt FAILS!! Error: ER_VIEW_CHECK_FAILED: CHECK OPTION failed 'practice.vw_staff_common2'

-- now try to insert a record that complies with the '%DB%' condition
USE practice;
INSERT INTO vw_staff_common2 (
    employeeID,
    firstName,
    lastName,
    jobtitle,
    managerID,
    department
) 
VALUES(
    2222,
    'Thomas',
    'Fisher',
    'DB Developer', -- satisfies the condition
    8989,
    'Database Administrators'
);

select * from practice.vw_staff_common;  -- now it works




-- By default, mysql itself recognizes the semicolon as a statement delimiter, so you must redefine the delimiter temporarily to cause mysql to pass the entire stored program definition to the server.


----------------------- Create Stored Procedure -----------------------
USE practice;
DELIMITER // -- Change Delimiter 
CREATE PROCEDURE Greetings( GreetingWorld VARCHAR(100), FirstName VARCHAR(100))
BEGIN
	DECLARE FullGreeting VARCHAR(200);
	SET FullGreeting = CONCAT(GreetingWorld,' ',FirstName);
	SELECT FullGreeting;
END
//
-- Change Delimiter again
DELIMITER ;

-- Call Stored Procedure

CALL practice.Greetings('Bonjour,', 'Dave');
CALL practice.Greetings('Hola,', 'Dora');
CALL practice.Greetings('Terve,', 'Elena');

---------------------------------------------
USE Backery;
SELECT *
FROM sweet;

-- Stored Procedure
-- Change Delimiter
USE Backery;
DELIMITER //
-- Create Stored Procedure
CREATE PROCEDURE InsertValue(
IN id INT, 
IN sweetItem VARCHAR(100),
IN price FLOAT)
BEGIN

INSERT INTO sweet(id, item_name, price)
VALUES (id, sweetItem, price);

END//
-- Change Delimiter again
DELIMITER ;

USE Backery;
CALL InsertValue (11, 'cherry_cake', 5);


USE Backery;
SELECT *
FROM sweet;

DROP PROCEDURE Backery.InsertValue; --- this way we can not use the procedure again



USE bank;
select * from bank.accounts;

USE bank;
SHOW TABLES; 

DROP FUNCTION bank.is_eligible;

---------------------- Stored function ------------------------
USE bank;
DELIMITER //
CREATE FUNCTION is_eligible(balance INT) 
RETURNS VARCHAR(20)  -- return only 1 value because it's function
DETERMINISTIC -- A routine is considered “deterministic” if it always produces the same result for the same input parameters
BEGIN
    DECLARE customer_status VARCHAR(20);   --- The DECLARE initialize a variable
    IF balance > 100 THEN
        SET customer_status = 'YES';
    ELSEIF (balance >= 50 AND 
            balance <= 100) THEN
        SET customer_status = 'MAYBE';
    ELSEIF balance < 50 THEN
        SET customer_status = 'NO';
    END IF;
    RETURN (customer_status);
END// 
DELIMITER ;

USE bank;
SELECT 
    account_holder_name,
    account_holder_surname,
    balance,
    is_eligible(balance) -- calling this functional
FROM
    accounts;

USE bank;
SELECT customer_status ---Error: ER_BAD_FIELD_ERROR: Unknown column 'customer_status' in 'field list'
FROM accounts;


-- User define function perfrom single calculation, it returns single value
-- Stored procedure executes multiple statements, it can return multiple outputs or no output




------------------------ Trigger ----------------------
-- Triggers Example
 
USE Backery;
SELECT * FROM Backery.sweet;

-- BEFORE Trigger Example - this one ensures font & case consistency for inserted items
USE Backery;
DELIMITER //
CREATE TRIGGER sweetItem_Before_Insert
BEFORE INSERT on sweet
FOR EACH ROW
BEGIN
	SET NEW.item_name = CONCAT(UPPER(SUBSTRING(NEW.item_name,1,1)),
						       LOWER(SUBSTRING(NEW.item_name FROM 2)));
END//
DELIMITER ;

-- Insert Data - all with upper case
USE Backery;
INSERT INTO sweet (id, item_name, price)
VALUES (123, 'apple_pie', 1.2);
USE Backery;
INSERT INTO sweet (id, item_name, price)
VALUES (456, 'caramel slice', 0.9);
USE Backery;
INSERT INTO sweet (id, item_name, price)
VALUES (789, 'YUM YUM', 0.65);
SELECT * FROM Backery.sweet;






--------------------------  Events One Time ------------------------

-- -- Turn ON Event Scheduler 
SET GLOBAL event_scheduler = ON;
-- EXAMPLE 1 --> one time event
--use the AUTO_INCREMENT to get incremental values
USE practice;
CREATE TABLE monitoring_events
(ID INT NOT NULL AUTO_INCREMENT,  
Last_Update TIMESTAMP,
PRIMARY KEY (ID));

SELECT * FROM practice.monitoring_events;

-- We are creating an event that will be scheduled for us
USE practice;
DELIMITER //
CREATE EVENT one_time_event
ON SCHEDULE AT NOW() + INTERVAL 1 MINUTE
DO BEGIN
	INSERT INTO monitoring_events(Last_Update)
	VALUES (NOW());
END//
DELIMITER ;


-- Select Data to see that our table is empty
-- Then Select data again in approx 1 min to see what happened. 
SELECT * FROM practice.monitoring_events;

-- EXAMPLE 2 --> reccuring event
USE practice;
CREATE TABLE monitoring_events_version2
(ID INT NOT NULL AUTO_INCREMENT, 
Last_Update TIMESTAMP,
PRIMARY KEY (ID));

SELECT * FROM practice.monitoring_events_version2;  -- no data


USE practice;
DELIMITER //
CREATE EVENT recurring_time_event
ON SCHEDULE EVERY 2 SECOND
STARTS NOW()
DO BEGIN
	INSERT INTO monitoring_events_version2(Last_Update)
	VALUES (NOW());
END//
DELIMITER ;

-- Select Data
SELECT * FROM practice.monitoring_events_version2
ORDER BY ID DESC;

-- Clean up - this is necessary, otherwise your table will keep on being populated by the event
DROP TABLE practice.monitoring_events_version2;
DROP EVENT practice.recurring_time_event;



------------------------ HW ------------------------------------
SELECT * FROM Customer.customer;
SELECT * FROM Customer.email_address;
SELECT * FROM Backery.Savoury;
SELECT * FROM Parts.Part;


---- Write a function that transform the PNAME into 1st letter capitalised

USE Parts;
DELIMITER //
CREATE FUNCTION clean_name(PNAME VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE clean_name VARCHAR(20);
    SET clean_name = CONCAT(UPPER(SUBSTRING(PNAME, 1, 1)), LOWER(SUBSTRING(PNAME FROM 2)));
    RETURN clean_name;
END //
DELIMITER ;

USE Parts;
SELECT clean_name(PNAME), COLOUR, CITY
FROM Parts.Part 
WHERE WEIGHT > 14
ORDER BY PNAME;


----- Write a stored procedure, when we call it with some variables, it create a View and return the view about the variables to us----

USE Parts;
DELIMITER //
CREATE PROCEDURE view_generator(give_PNAME VARCHAR(50), give_COLOUR VARCHAR(50))
BEGIN
    CREATE VIEW new_view
    AS
    SELECT *
    FROM Parts.Part
    WHERE (Part.PNAME = give_PNAME) AND (Part.COLOUR = give_COLOUR);

    RETURNS new_view
    FROM Parts;
END //
DELIMITER ;
----  Error: ER_VIEW_SELECT_VARIABLE: View's SELECT contains a variable or parameter
----- view cannot use variables, it is a limitation.


----- Write a stored procedure, when we insert new values, it also clean up the PNAME----
USE Parts;
DROP Procedure InsertCleanedValue;


USE Parts;
DELIMITER //
CREATE PROCEDURE InsertCleanedValue(IN give_id VARCHAR(50),  IN give_PNAME VARCHAR(50), IN give_COLOUR VARCHAR(50), IN give_WEIGHT FLOAT, IN give_CITY VARCHAR(50))

BEGIN

INSERT INTO Part(P_ID, PNAME, COLOUR, WEIGHT, CITY)
VALUES (give_id, clean_name(give_PNAME), give_COLOUR, give_WEIGHT, give_CITY);

END//
DELIMITER ;

USE Parts;
CALL InsertCleanedValue("P9", "ruler", "red", "5", "Oxford");

SELECT * FROM Parts.Part;



------------------- Try out Helen's ---------------
SELECT * FROM Parts.Supply;

---- original 
USE Parts;
DELIMITER //

CREATE FUNCTION SupplierMagnitude(quant INTEGER)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN 
	DECLARE SupplierMagnitude VARCHAR(50)
    
    if SUM(quantity) > 3000 group by s_id THEN 
		set SupplierMagnitude = 'High';
    elseif SUM(quantity) <= 3000 group by s_id THEN 
		set SupplierMagnitude = 'Low';
	end if;
    
		return(SupplierMagnitude);
end //
DELIMITER ;
--------

----first create a view

USE Parts;
SELECT * FROM groupedID;

DROP VIEW Parts.groupedID;

---- create a view
USE Parts;
CREATE VIEW groupedID
AS
SELECT SUM(Quantity) AS sum_quant, S_ID AS S_ID
FROM Parts.Supply
GROUP BY S_ID;

---- define funciton
USE Parts;
DELIMITER //

CREATE FUNCTION SupplierMagnitude(quant INTEGER)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE SupplierMagnitude VARCHAR(50);
    IF quant > 3000 THEN 
		SET SupplierMagnitude = 'High';
    ELSEIF quant <= 3000 THEN
		SET SupplierMagnitude = 'Low';
	END IF;
    
	RETURN (SupplierMagnitude);
END //
DELIMITER ;

---- test if the function works
USE Parts;
SELECT SupplierMagnitude(900);

--- call the function on the grouped supply table
USE Parts;
SELECT sum_quant, S_ID, SupplierMagnitude(sum_quant)
FROM Parts.groupedID;




USE Parts;
DROP FUNCTION SupplierMagnitude;





USE Parts;
CREATE VIEW groupedID
AS
SELECT SUM(Quantity), S_ID
FROM Parts.Supply
GROUP BY S_ID;

USE Parts;
SELECT SUM(Quantity), S_ID
FROM Parts.Supply
GROUP BY S_ID;

