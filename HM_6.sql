use movies

/*ex1*/
SELECT title, year, LENGTH
FROM MOVIE
WHERE (LENGTH > 120 or LENGTH is null) and year < 2000

/*ex2*/
SELECT name, gender
FROM MOVIESTAR
WHERE name LIKE 'J%' and BIRTHDATE > 1948
ORDER BY NAME DESC; 

/*EX3*/
SELECT studioname, COUNT(DISTINCT STARNAME) as num_actors
FROM movie JOIN starsin ON TITLE = MOVIETITLE
GROUP BY STUDIONAME;

/*EX4*/
SELECT NAME, COUNT(DISTINCT MOVIETITLE) AS num_movies
FROM MOVIESTAR LEFT JOIN STARSIN ON STARNAME = NAME
GROUP BY NAME;

SELECT NAME, TITLE, YEAR
FROM STUDIO JOIN MOVIE ON NAME = STUDIONAME
WHERE YEAR = (SELECT MAX(M.YEAR)
			  FROM MOVIE AS M
			  WHERE M.STUDIONAME = NAME);

/*EX6*/
SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'M' AND BIRTHDATE = (SELECT MAX(BIRTHDATE)
				   FROM MOVIESTAR
				   WHERE GENDER = 'M');

/*EX7*/
SELECT STUDIONAME, STARNAME, COUNT(TITLE) AS NUM_MOVIES
FROM STARSIN JOIN MOVIE ON MOVIETITLE = TITLE
GROUP BY STUDIONAME, STARNAME
HAVING COUNT(TITLE) >= ALL (SELECT COUNT(M.TITLE)
							FROM STARSIN JOIN MOVIE AS M ON MOVIETITLE = M.TITLE
							WHERE STUDIONAME = M.STUDIONAME
							GROUP BY M.STUDIONAME, STARNAME);

/*EX8*/
SELECT TITLE, YEAR AS MOVIEYEAR, COUNT(STARNAME) AS NUM_ACRORS
FROM MOVIE JOIN STARSIN ON MOVIETITLE = TITLE
GROUP BY TITLE, YEAR
HAVING COUNT(STARNAME) > 2;

USE SHIPS

/*EX1*/

SELECT DISTINCT SHIP
FROM OUTCOMES
WHERE (BATTLE IS NOT NULL) AND (SHIP LIKE 'C%' OR SHIP LIKE 'K%');

/*EX2*/
SELECT NAME, COUNTRY
FROM SHIPS JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
		   LEFT JOIN OUTCOMES ON NAME = SHIP
WHERE RESULT != 'sunk' OR RESULT IS NULL;

/*EX3*/
SELECT country, COUNT(SHIP) AS num_sunk_ships
FROM SHIPS RIGHT JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
		     left JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE BATTLE IS NULL OR RESULT = 'sunk'
GROUP BY COUNTRY;

/*EX4*/
SELECT O1.BATTLE
FROM OUTCOMES AS O1
GROUP BY O1.BATTLE
HAVING COUNT(O1.SHIP) > ALL(SELECT COUNT(SHIP)
							FROM OUTCOMES
							WHERE BATTLE = 'Guadalcanal');

/*EX5*/
SELECT BATTLE
FROM OUTCOMES JOIN SHIPS ON NAME = SHIP
			  JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY BATTLE
HAVING COUNT(COUNTRY) > (SELECT COUNT(COUNTRY)
						 FROM OUTCOMES JOIN SHIPS ON NAME = SHIP
									   JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
						 WHERE BATTLE = 'Surigao Strait');

/*EX6*/
SELECT NAME, DISPLACEMENT, NUMGUNS
FROM SHIPS JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE DISPLACEMENT <= (SELECT MIN(DISPLACEMENT)
					       FROM CLASSES)
	  AND NUMGUNS >= (SELECT MAX(NUMGUNS)
					  FROM CLASSES
					  where DISPLACEMENT <= (SELECT MIN(DISPLACEMENT)
					       FROM CLASSES));
/*ex7*/
SELECT COUNT(SHIP) AS num_ships
FROM OUTCOMES JOIN BATTLES  AS B ON BATTLE = NAME
WHERE RESULT = 'ok' AND SHIP IN (SELECT SHIP
								 FROM OUTCOMES AS O JOIN BATTLES ON BATTLE = NAME
								 WHERE O.RESULT = 'damaged' AND O.SHIP = OUTCOMES.SHIP AND BATTLES.DATE < B.DATE); 

/*ex8*/
/*SELECT SHIP
FROM OUTCOMES JOIN BATTLES AS B ON BATTLE = NAME
WHERE RESULT = 'ok' AND SHIP IN (SELECT O.SHIP
								 FROM OUTCOMES AS O JOIN BATTLES ON BATTLE = NAME
								 WHERE O.RESULT = 'damaged' 
								 AND O.SHIP = OUTCOMES.SHIP 
								 AND BATTLES.DATE < B.DATE)
					AND BATTLE IN (SELECT BATTLE
								   FROM BATTLES
								   GROUP BY BATTLE
								   HAVING COUNT(SHIP) >= (SELECT MAX(SHIP_COUNT)
														  FROM (SELECT COUNT(SHIP) AS SHIP_COUNT
																FROM BATTLES AS B2 JOIN OUTCOMES ON NAME = BATTLE
																WHERE B2.DATE < B.DATE
																GROUP BY B2.NAME) AS PREVIOUS));*/ 
SELECT O.SHIP
FROM OUTCOMES AS O
         JOIN BATTLES AS B
              ON O.BATTLE = B.NAME
GROUP BY O.SHIP, O.RESULT, B.DATE
HAVING O.RESULT = 'ok'
   AND B.DATE > (SELECT BATTLES.DATE
                 FROM OUTCOMES
                          JOIN BATTLES
                               ON OUTCOMES.BATTLE = BATTLES.NAME
                 WHERE OUTCOMES.SHIP = O.SHIP
                 GROUP BY OUTCOMES.SHIP, OUTCOMES.RESULT, BATTLES.DATE
                 HAVING OUTCOMES.RESULT = 'damaged')
   AND COUNT(O.SHIP) >= (SELECT COUNT(OUTCOMES.SHIP)
                         FROM OUTCOMES
                                  JOIN BATTLES
                                       ON OUTCOMES.BATTLE = BATTLES.NAME
                         WHERE OUTCOMES.SHIP = O.SHIP
                         GROUP BY OUTCOMES.BATTLE, OUTCOMES.RESULT, BATTLES.DATE
                         HAVING OUTCOMES.RESULT = 'damaged')

USE PC

/*ex1*/
SELECT model, code, screen
FROM LAPTOP
WHERE (SCREEN = 11 AND model in (SELECT MODEL
								FROM LAPTOP
								WHERE SCREEN = 15))
	OR (SCREEN = 15 AND MODEL IN (SELECT MODEL
								  FROM LAPTOP
								  WHERE SCREEN = 11));
/*EX2*/
SELECT DISTINCT PC.MODEL
FROM PC JOIN PRODUCT AS P1 ON PC.MODEL = P1.MODEL
WHERE PC.price < (SELECT MIN(PRICE)
					 FROM LAPTOP JOIN PRODUCT AS P2 ON LAPTOP.model = P2.model
					 WHERE P1.MAKER = P2.MAKER);

/*EX3*/
SELECT PC.MODEL, AVG(PRICE) AS AVG_PRICE
FROM PC JOIN PRODUCT AS P1 ON PC.MODEL = P1.MODEL
GROUP BY PC.MODEL, P1.maker
HAVING AVG(PRICE) < (SELECT MIN(PRICE)
						 FROM LAPTOP JOIN PRODUCT AS P2 ON LAPTOP.model = P2.model
						 WHERE P1.MAKER = P2.MAKER);

/*EX4*/
SELECT P1.CODE, MAKER, COUNT(P2.CODE)
FROM PC AS P1 JOIN product ON P1.MODEL = PRODUCT.MODEL, PC AS P2
WHERE P2.PRICE <= P1.PRICE
GROUP BY P1.CODE, MAKER;

SELECT PC.CODE, MAKER, COUNT(P2.CODE)
FROM PC LEFT JOIN PRODUCT ON PC.MODEL = PRODUCT.MODEL, PC AS P2
GROUP BY PC.CODE, MAKER, PC.PRICE, P2.PRICE
HAVING PC.PRICE >= P2.PRICE;

SELECT code,maker, price, (SELECT COUNT(DISTINCT code)  FROM pc as pc2 
					WHERE pc1.price <= pc2.price) as num_pc_higher_price

FROM pc as pc1 JOIN product as prod ON pc1.model=prod.model;