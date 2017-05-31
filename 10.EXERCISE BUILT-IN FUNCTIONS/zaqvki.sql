-- -------------------------1---------
select first_name,last_name from Employees
where first_name like 'SA%'
order by first_name desc
-- -------------------------2---------
select first_name,last_name from Employees
where last_name like '%ei%'
-- -------------------3--------------------

-- -------------------4-----

-- -----------------5-------------

-- -----------------6-------------

-- -----------------7-------------

-- -----------8--------------------

-- ----------9---------------------

-- -----------10------------------

-- -----------11------------------

-- -----------12------------------

-- -----------13------------------

-- -----------14------------------

-- -----------15------------------

-- -----------16------------------

-- -----------17-----------------
select name,
TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) AS age_in_years,
MONTH(birthdate) as age_in_months,
datediff(birthdate, CURDATE()) as age_in_days,
TIMESTAMPDIFF(SECOND, birthdate, CURDATE()) as age_in_minutes
from People






