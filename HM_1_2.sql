use pc

SELECT MODEL, speed as MHZ, HD as GB
FROM pc
WHERE price < 1200;

SELECT DISTINCT maker
FROM product
WHERE type = 'printer';

SELECT model, ram, screen
FROM laptop
WHERE price > 1000;

SELECT *
FROM printer
WHERE color = 'y';

SELECT model, speed, hd
FROM pc
WHERE (cd = '12x' or cd = '16x') and price < 2000;