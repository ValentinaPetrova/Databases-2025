use movies

SELECT MOVIESTAR.NAME
FROM MOVIESTAR INNER JOIN STARSIN ON STARNAME = NAME
WHERE GENDER = 'M' and MOVIETITLE = 'The Usual Suspects';

SELECT STARNAME
FROM STARSIN INNER JOIN MOVIE ON MOVIETITLE = TITLE
WHERE MOVIEYEAR = 1995 AND STUDIONAME = 'MGM';

SELECT DISTINCT NAME
FROM MOVIE INNER JOIN MOVIEEXEC ON PRODUCERC# = CERT#
WHERE STUDIONAME = 'MGM';

SELECT M2.TITLE
FROM MOVIE AS M1, MOVIE AS M2
WHERE M1.TITLE = 'Star Wars' and M2.LENGTH > M1.LENGTH;

SELECT ME2.NAME
FROM MOVIEEXEC AS ME1, MOVIEEXEC AS ME2
WHERE ME1.NAME = 'Stephen Spielberg' AND ME2.NETWORTH > ME1.NETWORTH;

use pc

SELECT maker, speed
FROM product INNER JOIN laptop ON product.model = laptop.model
WHERE hd >= 9;

SELECT p.model, pc.price
FROM Product p
JOIN PC pc ON p.model = pc.model
WHERE p.maker = 'B'

UNION

SELECT p.model, l.price
FROM Product p
JOIN Laptop l ON p.model = l.model
WHERE p.maker = 'B'

UNION

SELECT p.model, pr.price
FROM Product p
JOIN Printer pr ON p.model = pr.model
WHERE p.maker = 'B';

SELECT maker
FROM product
WHERE  type = 'Laptop'

EXCEPT

SELECT maker
FROM product
WHERE type = 'PC';

SELECT DISTINCT p1.hd
FROM pc as p1, pc as p2
WHERE p1.hd = p2.hd AND p1.code != p2.code;

SELECT DISTINCT p1.model, p2.model
FROM pc as p1, pc as p2
WHERE p1.speed = p2.speed AND p1.ram = p2.ram and p1.model < p2.model;

/*To ask ->*/ 
SELECT DISTINCT p1.maker
FROM product as p1 join pc as pc1 on p1.model = pc1.model, 
product as p2 join pc as pc2 on p2.model = pc2.model
WHERE pc1.code != pc2.code and p1.maker = p2.maker and pc1.speed >= 400;

use ships

SELECT name
FROM ships INNER JOIN classes ON ships.class = classes.class
WHERE DISPLACEMENT > 50000;

SELECT name, displacement, numguns
FROM SHIPS INNER JOIN classes ON ships.class = classes.class
INNER JOIN OUTCOMES ON ships.name = OUTCOMES.SHIP
WHERE OUTCOMES.BATTLE = 'Guadalcanal';

SELECT country
FROM CLASSES
WHERE type = 'bb'

INTERSECT

SELECT country
FROM CLASSES
WHERE type ='bc';


/*To ask ->*/
SELECT DISTINCT o1.ship
FROM battles as b1, battles as b2, outcomes as o1, outcomes as o2
where o1.SHIP=o2.SHIP and b1.name=o1.battle and b2.name=o2.battle and
o1.result='damaged' and b1.date < b2.date