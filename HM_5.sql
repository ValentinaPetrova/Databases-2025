 use pc

 SELECT CONVERT(DECIMAL(5, 2), AVG(speed)) AS AvgSpeed
 FROM PC;

 SELECT maker, AVG(screen) as AvgScreen
 FROM product JOIN laptop ON product.model = laptop.model
 GROUP BY maker;

 SELECT CONVERT(DECIMAL(9,2),AVG(speed)) as AvgSpeed
 FROM laptop
 WHERE price > 1000;

SELECT  maker, CONVERT(DECIMAL(9, 2), AVG(price)) as AvgPrice
FROM product JOIN PC ON product.model = pc.model
WHERE maker = 'A'
GROUP BY maker;

SELECT p.maker, AVG(p.price) AS average_price
FROM (
    SELECT pr.maker, pc.price FROM PC pc
    JOIN Product pr ON pc.model = pr.model
    WHERE pr.maker = 'B'
    
    UNION ALL

    SELECT pr.maker, l.price FROM Laptop l
    JOIN Product pr ON l.model = pr.model
    WHERE pr.maker = 'B'
) as p
GROUP BY p.maker;

SELECT speed, AVG(price) as AvgPrice
FROM pc
GROUP BY speed; 

SELECT maker, COUNT(DISTINCT PC.code) as number_of_pc
FROM product join pc ON PRODUCT.model = pc.model
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(DISTINCT PC.code) >= 3;

SELECT maker, price
FROM product JOIN pc ON product.model = pc.model
WHERE price = (SELECT MAX(price) FROM pc);

SELECT speed, AVG(price) as AvgPrice
FROM pc
WHERE speed > 800
GROUP BY speed;

SELECT maker, CONVERT(DECIMAL(5, 2), AVG(hd)) as AvgHDD
FROM product JOIN pc ON product.model = pc.model
WHERE maker IN (SELECT DISTINCT maker
				FROM product
				WHERE type = 'Printer')
GROUP BY maker;

use ships


SELECT COUNT(TYPE) as NO_Classes
FROM CLASSES 
WHERE TYPE = 'bb';

SELECT class, AVG(NUMGUNS) AS AvgGuns
FROM CLASSES
WHERE type = 'bb'
GROUP BY class;

SELECT AVG(NUMGUNS) as AvgGuns
FROM CLASSES
WHERE type = 'bb'
GROUP BY type;

SELECT class, MIN(LAUNCHED), MAX(LAUNCHED)
FROM SHIPS
GROUP BY class;

SELECT class, COUNT(RESULT) as No_Sunc
FROM SHIPS JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE RESULT = 'sunk'
GROUP BY class;

/*why in the answears there is no Germany*/
SELECT country, CONVERT(DECIMAL(5, 2), AVG(BORE)) as AvgBore
FROM CLASSES
GROUP BY COUNTRY;

/*ANSWEAR NOT ALL CLASSES ARE IN SHIPS*/
SELECT CLASSES.COUNTRY, CONVERT(DECIMAL(9,2) , AVG(CLASSES.BORE)) AS AVG_BORE
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY CLASSES.COUNTRY;
