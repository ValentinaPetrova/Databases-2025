use movies 

select address
from STUDIO
where NAME = 'Disney';

select BIRTHDATE
from MOVIESTAR
where NAME = 'Jack Nicholson';

select STARNAME
from STARSIN
where MOVIEYEAR = 1980 or MOVIETITLE = '%Knight%';

select Name
from MOVIEEXEC
where NETWORTH > 10000000;

select NAME
from MOVIESTAR
where GENDER = 'M' or ADDRESS = 'Prefect Rd';

use pc

select model, speed, hd
from pc
where price < 1200;