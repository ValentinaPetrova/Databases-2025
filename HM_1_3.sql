use ships

SELECT class, country
FROM classes
WHERE numguns < 10;

SELECT name as SHIPNAME
FROM ships
WHERE launched < 1918;

SELECT ship, battle
FROM OUTCOMES
WHERE RESULT = 'sunk';

SELECT NAME
FROM SHIPS
WHERE NAME = CLASS;

SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%';

SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %';