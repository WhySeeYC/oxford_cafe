CREATE Database Backery;
Use Backery;

Create Table Sweet
(id integer NOT NULL,
item_name varchar(50) NOT NULL,
price FLOAT(2)); 

Drop Table Savoury;

Create Table Savoury
(id integer NOT NULL,
item_name varchar(50) NOT NULL,
price FLOAT(2) NULL,
main_ingredient varchar(50));

INSERT INTO Sweet
(id, item_name, price)
VALUES
(1, 'doughnut', 0.50),
(2, 'croissant', 0.75),
(3, 'pain-au-chocolate', 0.55),
(4, 'cinnamon swhirl', 0.45),
(5, 'cannoli', 0.88),
(6, 'apple tart', 1.12);


INSERT INTO Savoury
(id, item_name, price, main_ingredient)
VALUES
(1, 'meat pie', 0.50, 'pork'),
(2, 'sausage roll', 1.00, null),
(3, 'pasty', 2.45, 'beef');

SELECT *
FROM Sweet;

SELECT item_name, price
FROM Sweet;

SELECT s.item_name, s.price
FROM Sweet s;

SELECT *
FROM Savoury;