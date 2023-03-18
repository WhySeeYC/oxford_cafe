-- MySQL Homework --

USE oxford_cafe;
SHOW TABLEs;

USE oxford_cafe;
DESC coffee_shops;

USE oxford_cafe;
SELECT * FROM coffee_shops;

 

-- Create a single column index example --
USE oxford_cafe;
CREATE INDEX shop_idx ON coffee_shops(shop_name ASC);

USE oxford_cafe;
DROP INDEX shop_idx ON coffee_shops;

USE oxford_cafe;
INSERT INTO coffee_shops
VALUES
('S12', 'Missing Bean', 'Abindon', 10),
('S13', 'LOVE Cafe', 'High', 5),
('S14', 'Missing Bean', 'Cambridge', 10);


USE oxford_cafe;
SELECT * FROM coffee_shops;

-- Create a composite index --
USE oxford_cafe;
SHOW INDEX FROM oxford_cafe.coffee_shops; -- this will show the index associated with the base table

USE oxford_cafe;
DESC coffee_shops;

SELECT * FROM oxford_cafe.coffee_shops;


USE oxford_cafe;
CREATE INDEX shop_street_idx ON coffee_shops(shop_name, street);


-- Create clustered indexes --
USE oxford_cafe
CREATE CLUSTERED INDEX idx_coffee_shop ON coffee_shops(shop_id ASC);


ALTER TABLE coffee_shops
DROP PRIMARY KEY shop_id;

-- Add a new index to the ‘Sweet’ table --
SELECT * FROM Backery.Sweet;

USE Backery;
CREATE INDEX item_idx ON Sweet(item_name ASC);

SHOW INDEX FROM Backery.Sweet;

-- Add a new multiple column index to the table ‘Accounts --
SELECT * FROM bank.accounts;
SHOW INDEX FROM bank.accounts;

USE bank;
CREATE INDEX holder_overdraft_idx ON accounts(account_holder_name, overdraft_allowed);