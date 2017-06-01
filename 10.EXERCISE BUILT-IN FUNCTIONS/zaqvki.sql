-- -------------------------1---------
select first_name,last_name from Employees
where first_name like 'SA%'
order by first_name desc
-- -------------------------2---------
select first_name,last_name from Employees
where last_name like '%ei%'
-- -------------------3--------------------
select first_name from Employees
where (department_id=10 or department_id=3) and (year(hire_date)>=1995 and year(hire_date)<=2005)
-- -------------------4-----
SELECT first_name,last_name FROM employees
WHERE job_title not like '%engineer%';
-- -----------------5-------------
SELECT name FROM towns
where length(name)=5 or length(name)=6
order by name
-- -----------------6-------------
SELECT town_id,name FROM towns
where name like'M%' or name like'K%' or name like'B%' or name like'E%'
order by name
-- -----------------7-------------
SELECT town_id,name FROM towns
where name not like'R%' and name not like 'B%' and name not like 'D%'
order by name
-- -----------8--------------------
create view  v_employees_hired_after_2000 as
SELECT first_name,last_name FROM employees
where year(hire_date)>2000;
-- ----------9---------------------
select first_name,last_name from employees
where length(last_name)=5;
-- -----------10------------------
select country_name,iso_code
from countries
where lower(LENGTH(country_name) - LENGTH(REPLACE(country_name, 'a', ''))+1) >= 3
order by iso_code;
-- -----------11------------------

-- -----------12------------------
select name,
DATE_FORMAT(start, '%Y-%m-%d') as start 
from games
where YEAR(start)=2011 or YEAR(start)=2012
limit 50
-- -----------13------------------
select user_name,
SUBSTRING_INDEX(email,'@',-1) as `Email Provider`
from users
order by `Email Provider`,user_name
-- -----------14------------------
select user_name,ip_address
from users
where ip_address like '___.1%.%.___'
order by user_name
;
-- -----------15------------------

-- -----------16------------------
select product_name,
order_date,
DATE_ADD(order_date, INTERVAL 3 DAY)   as pay_due,
DATE_ADD( order_date, INTERVAL 1 month )  as deliver_due
from orders
-- -----------17-----------------
select name,
TIMESTAMPDIFF(YEAR,birthdate,CURDATE()) AS age_in_years,
MONTH(birthdate) as age_in_months,
datediff(birthdate, CURDATE()) as age_in_days,
TIMESTAMPDIFF(SECOND, birthdate, CURDATE()) as age_in_minutes
from People






