SET FOREIGN_KEY_CHECKS=0;


-- 1. Create relational DB of your choice with minimum 5 tables --
CREATE DATABASE oxford_cafe;

USE oxford_cafe;
CREATE TABLE coffee_shops
(shop_id VARCHAR(20) PRIMARY KEY NOT NULL, 
shop_name VARCHAR(50) NOT NULL, 
street VARCHAR(70)  NOT NULL,
travel_mug_discount INT);


INSERT INTO coffee_shops
(shop_id, shop_name, street, travel_mug_discount)
VALUES
("S1", "Peloton", "Cowley", 10),
("S2", "Missing Bean", "Botley", 15),
("S3", "Missing Bean", "Magdalen", 8),
("S4", "Missing Bean", "Turl", 10),
("S5", "Jericho", "High", 5),
("S6", "Smith", "Cover", 10),
("S7", "Society", "StMichael", 5),
("S8", "Silvie", "Iffley", 10),
("S9", "Colombia", "Cover", 20),
("S10", "Mostro", "Cowley", 10);


USE oxford_cafe;
CREATE TABLE item_price
(combo_id VARCHAR(20) PRIMARY KEY NOT NULL,
shop_id VARCHAR(20),
coffee_name VARCHAR(50) NOT NULL,
price FLOAT);

USE oxford_cafe;
ALTER TABLE item_price
ADD CONSTRAINT fk_shop_price
FOREIGN KEY (shop_id) REFERENCES coffee_shops(shop_id);

USE oxford_cafe;
ALTER TABLE item_price
DROP FOREIGN KEY fk_shop_pricee;  -- becaue I named the constraint wrong, drop and renamed it --


INSERT INTO item_price
(combo_id, shop_id, coffee_name, price)
VALUES
("C1", "S2", "Americano", 2.4),
("C2", "S2", "Long Black", 2.4),
("C3", "S2", "Flat White", 2.9),
("C4", "S2", "Latte", 2.9),
("C5", "S2", "Macchiato", 2.5),
("C6", "S2", "Hot Chocolate", 2.9),
("C7", "S2", "Mocha", 3.0),
("C8", "S2", "Cappuccina", 2.9),
("C9", "S2", "Espresso", 2.4),
("C10", "S2", "Chai", 3.0),
("C11", "S2", "Tea", 2.5),
("C12", "S1", "Americano", 2.0),
("C13", "S1", "Long Black", 2.0),
("C14", "S1", "Flat White", 3.0),
("C15", "S1", "Latte", 2.5),
("C16", "S1", "Macchiato", 2.5),
("C17", "S1", "Hot Chocolate", 3.0),
("C18", "S1", "Mocha", 3.0),
("C19", "S1", "Cappuccina", 3.0),
("C20", "S1", "Espresso", 2.0),
("C21", "S1", "Chai", 3.0),
("C22", "S1", "Tea", 1.8),
("C23", "S3", "Americano", 2.4),
("C24", "S3", "Long Black", 2.4),
("C25", "S3", "Flat White", 2.9),
("C26", "S3", "Latte", 2.9),
("C27", "S3", "Macchiato", 2.5),
("C28", "S3", "Hot Chocolate", 2.9),
("C29", "S3", "Mocha", 3.0),
("C30", "S3", "Cappuccina", 2.9),
("C31", "S3", "Espresso", 2.4),
("C32", "S3", "Chai", 3.0),
("C33", "S3", "Tea", 2.5),
("C34", "S4", "Americano", 2.4),
("C35", "S4", "Long Black", 2.4),
("C36", "S4", "Flat White", 2.9),
("C37", "S4", "Latte", 2.9),
("C38", "S4", "Macchiato", 2.5),
("C39", "S4", "Hot Chocolate", 2.9),
("C40", "S4", "Mocha", 3.0),
("C41", "S4", "Cappuccina", 2.9),
("C42", "S4", "Espresso", 2.4),
("C43", "S4", "Chai", 3.0),
("C44", "S4", "Tea", 2.5),
("C45", "S5", "Americano", 3.0),
("C46", "S5", "Long Black", 3.5),
("C47", "S5", "Flat White", 3.0),
("C48", "S5", "Latte", 3.0),
("C49", "S5", "Macchiato", 2.9),
("C50", "S5", "Hot Chocolate", 3.5),
("C51", "S5", "Mocha", 3.5),
("C52", "S5", "Cappuccina", 3.0),
("C53", "S5", "Espresso", 2.5),
("C54", "S5", "Tea", 2.0),
("C55", "S6", "Americano", 2.8),
("C56", "S6", "Long Black", 3.0),
("C57", "S6", "Flat White", 3.0),
("C58", "S6", "Latte", 3.0),
("C59", "S6", "Macchiato", 2.8),
("C60", "S6", "Hot Chocolate", 3.5),
("C61", "S6", "Mocha", 3.5),
("C62", "S6", "Cappuccina", 3.0),
("C63", "S6", "Espresso", 2.5),
("C64", "S6", "Tea", 2.9),
("C65", "S7", "Americano", 2.5),
("C66", "S7", "Long Black", 2.5),
("C67", "S7", "Flat White", 3.0),
("C68", "S7", "Latte", 3.5),
("C69", "S7", "Macchiato", 3.0),
("C70", "S7", "Hot Chocolate", 3.5),
("C71", "S7", "Mocha", 3.5),
("C72", "S7", "Cappuccina", 2.9),
("C73", "S7", "Espresso", 2.5),
("C74", "S7", "Chai", 2.7),
("C75", "S7", "Tea", 1.9),
("C76", "S8", "Americano", 2.0),
("C78", "S8", "Long Black", 2.5),
("C79", "S8", "Latte", 2.8),
("C80", "S8", "Macchiato", 2.8),
("C81", "S8", "Hot Chocolate", 3.0),
("C82", "S8", "Mocha", 3.0),
("C83", "S8", "Cappuccina", 2.8),
("C84", "S8", "Espresso", 2.0),
("C85", "S8", "Chai", 2.7),
("C86", "S8", "Tea", 2.4),
("C87", "S9", "Americano", 2.5),
("C88", "S9", "Long Black", 3.0),
("C89", "S9", "Flat White", 3.0),
("C90", "S9", "Latte", 3.5),
("C91", "S9", "Macchiato", 3.0),
("C92", "S9", "Hot Chocolate", 3.0),
("C93", "S9", "Mocha", 3.5),
("C94", "S9", "Cappuccina", 2.5),
("C95", "S9", "Espresso", 2.5),
("C96", "S9", "Chai", 3.0),
("C97", "S9", "Tea", 2.0),
("C98", "S10", "Americano", 2.5),
("C99", "S10", "Long Black", 2.8),
("C100", "S10", "Flat White", 2.8),
("C101", "S10", "Latte", 3.0),
("C102", "S10", "Macchiato", 3.0),
("C103", "S10", "Hot Chocolate", 3.0),
("C104", "S10", "Mocha", 3.0),
("C105", "S10", "Cappuccina", 2.5),
("C106", "S10", "Espresso", 2.5);



USE oxford_cafe;
CREATE TABLE bean
(bean_code VARCHAR(50) PRIMARY KEY,
bean_origin VARCHAR(70),
roast TEXT(70),
bean_kg FLOAT);

INSERT INTO bean
(bean_code, bean_origin, roast, bean_kg)
VALUES
("B1", "Colombia", "Light", 100),
("B2", "Gana", "Medium", 50),
("B3", "Guatimala", "Dark", 80),
("B4", "Brazil", "Dark", 90),
("B5", "Kenya", "Dark", 70),
("B6", "Peru", "Medium", 60),
("B7", "Costa Rica", "Light", 10),
("B8", "Bolivia", "Medium", 10),
("B9", "Italy", "Medium", 20),
("B10", "India", NULL, 30),
("B11", "Sri Lanka", NULL, 40);


USE oxford_cafe;
CREATE TABLE coworking
(cowroking_id VARCHAR(20) PRIMARY KEY NOT NULL,
shop_id VARCHAR(20),
num_plug INT, 
wifi BOOLEAN,
sit_in BOOLEAN NOT NULL);

ALTER TABLE coworking
ADD CONSTRAINT fk_shop_coworking
FOREIGN KEY (shop_id) REFERENCES coffee_shops(shop_id);

INSERT INTO coworking
(cowroking_id , shop_id , num_plug , wifi , sit_in)
VALUES
("C1", "S2", 10, TRUE, TRUE),
("C2", "S1", 2, TRUE, TRUE),
("C3", "S6", 8, TRUE, TRUE),
("C4", "S10", 7, TRUE, TRUE),
("C5", "S8", 0, TRUE, TRUE),
("C6", "S9", 10, TRUE, TRUE),
("C7", "S7", 6, TRUE, TRUE),
("C8", "S4", 0, FALSE, TRUE),
("C9", "S5", 0, FALSE, FALSE),
("C10", "S3", 0, TRUE, TRUE);


USE oxford_cafe;
CREATE TABLE sale
(sale_record INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
sale_date DATETIME,
shop_id VARCHAR(20),
combo_id VARCHAR(50),
bean_code VARCHAR(70), 
decaf BOOLEAN);


-- Set Primary and Foreign Key constraints to create relations between the tables--
ALTER TABLE sale
ADD CONSTRAINT fk_sale_shop
FOREIGN KEY (shop_id) REFERENCES oxford_cafe(shop_id);

ALTER TABLE sale
ADD CONSTRAINT fk_sale_item
FOREIGN KEY (combo_id) REFERENCES item_price(combo_id);

ALTER TABLE sale
ADD CONSTRAINT fk_sale_bean
FOREIGN KEY (bean_code) REFERENCES bean(bean_code);

USE oxford_cafe;
INSERT INTO sale
(sale_record, sale_date, shop_id, combo_id, bean_code, decaf)
VALUES
(1, "2022-12-01 09:32:06", "S11", "C1", "B3", TRUE),
(2, "2022-12-05 11:36:07", "S10", "C2", "B2", FALSE),
(3, "2022-12-05 12:17:20", "S9", "C6", "B1", TRUE),
(4, "2022-12-07 14:03:30", "S8", "C7", "B7", TRUE),
(5, "2022-12-07 14:05:30", "S7", "C5", "B6", TRUE),
(6, "2022-12-07 14:10:30", "S6", "C3", "B5", TRUE),
(7, "2022-12-08 15:03:59", "S5", "C4", "B8", FALSE),
(8, "2022-12-10 16:00:00", "S4", "C8", "B10", FALSE),
(9, "2022-12-12 09:27:20", "S3", "C9", "B4", FALSE),
(10, "2022-12-13 13:03:05", "S2", "C11", NULL, FALSE),
(11, "2022-12-20 15:04:46", "S1", "C10", NULL, FALSE);


-- Using any type of the joins create a view that combines multiple tables in a logical way: 
-- Find the oxford cafe that has the wifi and most number of plugs and where the Americano is cheapest --

USE oxford_cafe;
SHOW TABLEs;

USE oxford_cafe;
SELECT *
FROM item_price;

-- firstly, try to join 2 tables --
USE oxford_cafe;
SELECT coffee_shops.shop_id, coffee_shops.shop_name, coffee_shops.street, item_price.coffee_name, item_price.price
FROM coffee_shops
        LEFT JOIN
    item_price
        ON
    (coffee_shops.shop_id = item_price.shop_id)
WHERE item_price.coffee_name = "Americano";

-- secondly, try to join 3 tables together on shop_id --
SELECT coffee_shops.shop_id, coffee_shops.shop_name, coffee_shops.street, 
item_price.shop_id, item_price.coffee_name, item_price.price, 
coworking.shop_id, coworking.num_plug
FROM coffee_shops
INNER JOIN item_price ON coffee_shops.shop_id = item_price.shop_id
INNER JOIN coworking ON coffee_shops.shop_id = coworking.shop_id
WHERE (item_price.coffee_name = "Americano") AND (coworking.wifi = TRUE)
ORDER BY item_price.price ASC, coworking.num_plug DESC;

-- finally, only select the columns I want to see(ie exclude the common column shop_id) -- 

SELECT coffee_shops.shop_name, coffee_shops.street, 
		item_price.coffee_name, item_price.price, 
		coworking.num_plug
FROM coffee_shops
INNER JOIN item_price 
		ON coffee_shops.shop_id = item_price.shop_id
INNER JOIN coworking 
		ON coffee_shops.shop_id = coworking.shop_id
WHERE (item_price.coffee_name = "Americano") AND 
	  (coworking.wifi = TRUE)
ORDER BY item_price.price ASC, 
		 coworking.num_plug DESC;
-- the query showed that, the Peloton cafe on Cowley road has the cheapest Americano and it has 2 plugs for charging
-- if one to choose from the second option, the Missing Bean cafe on Botley road has 10 plugs for charging


-- In your database, create a stored function that can be applied to a query in your DB: 
-- Create a store function that shows how much one can save if they bring their own travel mug when buying Mocha-
USE oxford_cafe;
DELIMITER //
CREATE FUNCTION apply_discount(price FLOAT, travel_mug_discount INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE saved_amount FLOAT;
    SET saved_amount = price * (1-(100 - travel_mug_discount)/100);
    RETURN saved_amount;
END //
DELIMITER ;


SELECT apply_discount(2.5, 10); -- test out if the function work

SELECT item_price.coffee_name AS item, 
	   item_price.price AS original_price, 
       apply_discount(item_price.price, coffee_shops.travel_mug_discount) AS how_much_saved,
       coffee_shops.shop_name AS shop,
       coffee_shops.street AS street_name
FROM item_price
LEFT JOIN 
	coffee_shops 
		ON 
	item_price.shop_ID = coffee_shops.shop_id
WHERE item_price.coffee_name = "Mocha"
ORDER BY how_much_saved DESC;



-- Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis
-- Find out in the 1st week of December, where is Kenya's bean being sold

SELECT sale.sale_date, sale.shop_id, sale.bean_code
FROM sale
WHERE sale.sale_date BETWEEN "2022-12-01 00:00:00" AND "2022-12-07 23:59:59" 
	AND 
	sale.bean_code IN
		(SELECT bean.bean_code
		FROM bean
		WHERE bean.bean_origin = "Kenya");


-- create a stored procedure and demonstrate how it runs: create a procedure to speed up when add a new sale
-- firstly, see if the AUTO_INCREMENT does work if we don't add the sale_record directly
USE oxford_cafe;
DELIMITER //
CREATE PROCEDURE BuildInventory(
	IN sale_date DATETIME, 
    IN shop_id VARCHAR(20),
	IN combo_id VARCHAR(50),
	IN bean_code VARCHAR(70), 
	IN decaf BOOLEAN)
BEGIN
	INSERT INTO sale(sale_date, shop_id, combo_id, bean_code, decaf)
    VALUES
    (sale_date, shop_id, combo_id, bean_code, decaf);
END //
DELIMITER ;


CALL BuildInventory("2022-12-01", "S5", "C107", "B6", TRUE); 

SELECT *
FROM sale; -- check that the AUTO_INCREMENT does work

-- Secondly, we don't want staff have to put in date, so set the DATETIME to now when they call the procedure

DROP PROCEDURE BuildInventory2;

DELIMITER //
CREATE PROCEDURE BuildInventory2(
    IN shop_id VARCHAR(20),
	IN coffee_name VARCHAR(50),
	IN bean_origin VARCHAR(70), 
	IN decaf BOOLEAN)
BEGIN
	SET @sale_datetime_now = NOW();
	IF coffee_name = "Americano" THEN
		SET @combo_id = "C1";
	ELSEIF coffee_name = "Long Black" THEN
		SET @combo_id = "C2";
	ELSEIF coffee_name = "Flat White" THEN
		SET @combo_id = "C3";
	END IF;
    
    IF bean_origin  = "Colombia" THEN
		SET @bean_code = "B1";
	ELSEIF bean_origin = "Gana" THEN
		SET @bean_code = "B2";
	ELSEIF bean_origin = "Guatimala" THEN
		SET @bean_code = "B3";
	END IF;
    
	INSERT INTO sale(sale_date, shop_id, combo_id, bean_code, decaf)
    VALUES
    (@sale_datetime_now, shop_id, @combo_id, @bean_code, decaf);
END //
DELIMITER ;

-- try modified procedure, staff only need to give shop_id, coffee_name, bean_origin, decaf or not
CALL BuildInventory2("S1", "Americano", "Gana", FALSE);
CALL BuildInventory2("S2", "Long Black", "Guatimala", TRUE);

SELECT * 
FROM sale; -- checked it works



-- Create a view that uses at least 3-4 base tables;
-- prepare and demonstrate a query that uses the view to
-- produce a logically arranged result set for analysis.

CREATE VIEW vw_oxford_independent_cafe_sales
AS
SELECT sale.sale_record AS Record, 
		sale.sale_date AS Date_time, 
		coffee_shops.shop_name AS Shop, 
        coffee_shops.street AS Street, 
        item_price.coffee_name AS Item_name, 
        sale.decaf AS Decaf, 
        bean.bean_origin AS Bean_origin, 
        bean.roast AS Roast, 
        item_price.price AS Price
FROM sale
LEFT JOIN coffee_shops
	ON sale.shop_id = coffee_shops.shop_id
LEFT JOIN item_price
	ON sale.combo_id = item_price.combo_id
LEFT JOIN bean
	ON sale.bean_code = bean.bean_code;

SELECT * 
FROM vw_oxford_independent_cafe_sales
ORDER BY Date_time ASC;

-- DROP VIEW vw_oxford_independent_cafe_sales; --


-- Prepare an example query with group by
-- count how many decaf coffee had been sold by which shop

SELECT COUNT(decaf), Item_name, Shop
FROM vw_oxford_independent_cafe_sales
GROUP BY Item_name, Shop;




-- create a trigger and demonstrate how it runs
-- When Oxford got new coffee shops, add their shop_id with 0.1 increment

USE oxford_cafe;
DELIMITER //
CREATE TRIGGER add_new_shop
BEFORE INSERT ON coffee_shops
FOR EACH ROW
BEGIN
	SET NEW.shop_id = CONCAT("C",(SUBSTRING(New.shop_id from 2) + 0.1));
END//
DELIMITER ; 

INSERT INTO 
coffee_shops(shop_id, shop_name, street, travel_mug_discount)
VALUES
("S11", "G&D", "StAldate", 10);
INSERT INTO 
coffee_shops(shop_id, shop_name, street, travel_mug_discount)
VALUES
("S12", "Ricks", "High", 0);

SELECT shop_id, shop_name, street, travel_mug_discount
FROM coffee_shops;

SHOW TRIGGERs; -- this will print out the triggers had set associated with a given table