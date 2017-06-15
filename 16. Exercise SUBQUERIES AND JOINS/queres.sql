--------------1-----------------
select employee_id,job_title,e.address_id,address_text
from employees as e join addresses as a
on e.address_id = a.address_id
order by e.address_id asc
limit 5
--------------2-----------------
select
    first_name,last_name,name as 'town',address_text
from 
   employees as e
      join addresses as a
    on e.address_id=a.address_id
      join towns as t
    on a.town_id=t.town_id
order by first_name,last_name
limit 5
--------------3-----------------
select
employee_id,
first_name,
last_name,
name as department_name
from employees as e
join departments as d
on e.department_id=d.department_id
where d.name='Sales'
order by employee_id desc;
--------------4-----------------
select employee_id,first_name,salary,dep.name as department_name 
from employees as e right join
departments as dep
using(`department_id`)
where salary>15000
order by dep.department_id desc
limit 5;
--------------5-----------------
select e.employee_id,e.first_name
from employees as e
left join employees_projects as ep
on ep.employee_id=e.employee_id
-- left join projects as p
-- on ep.project_id=p.project_id
where ep.employee_id is null
order by e.employee_id desc
limit 3
--------------6-----------------
select e.first_name,e.last_name,e.hire_date,name as dept_name
from employees as e
join departments as d
on e.department_id=d.department_id
where date(hire_date)>'1999/1/1' and name in ('Sales','Finance')
order by e.hire_date asc;
--------------7-----------------
select e.employee_id,e.first_name,p.name as project_name
from employees as e
join employees_projects as ep
on ep.employee_id=e.employee_id
join projects as p
on ep.project_id=p.project_id
where date(p.start_date)>'2002-08-13' and p.end_date is null
order by e.first_name asc,p.name asc
limit 5
--------------8-----------------
SELECT emp.employee_id, emp.first_name,
 CASE
      WHEN YEAR (pro.start_date) > 2004 
	  THEN pro.name = NULL
      ELSE pro.name
      END
AS project_name
FROM employees as emp
Left join employees_projects as map on emp.employee_id = map.employee_id
Left JOIN projects as pro on map.project_id = pro.project_id
WHERE emp.employee_id = 24
ORDER BY project_name ASC;
--------------9-----------------
select e.employee_id,e.first_name,e2.employee_id,e2.first_name as manager_name
from employees as e
join employees as e2
on e.manager_id=e2.employee_id
where e.manager_id in (3,7)
order by e.first_name asc
--------------10-----------------
select 
     e.employee_id,
	  concat(e.first_name,' ',e.last_name) as employee_name,
	  concat(m.first_name,' ',m.last_name),
	  d.name as department_name
from employees as e
join employees as m
on e.manager_id=m.employee_id
join departments as d
on d.department_id=e.department_id
order by e.employee_id asc
limit 5;
--------------11-----------------
select avg(salary) as min_average_salary
from employees as d
group by department_id
order by avg(salary)
limit 1;
--------------12-----------------
select con.country_code,mountain_range,peak_name,elevation from peaks as p
join mountains as m
on p.mountain_id=m.id
join mountains_countries as mc
on m.id=mc.mountain_id
join countries as con
on mc.country_code = con.country_code
where p.elevation>2835 and con.country_code='BG'
order by p.elevation desc
--------------13-----------------
select country_code,count(m.id) as mountain_range 
from mountains_countries as mc 
left join mountains as m
on mc.mountain_id=m.id
where country_code in ('BG', 'RU', 'US')
group by country_code
having mountain_range > 0
order by mountain_range desc
--------------14-----------------
select country_name,river_name from rivers as r
right join countries_rivers as cr
on r.id=cr.river_id
right join countries as c
on cr.country_code=c.country_code
where continent_code='AF'
order by country_name asc
limit 5
--------------15-----------------
SELECT cu2.continent_code, cu2.currency_code , cu2.currency_usage
	FROM (SELECT continent_code, currency_code ,count(currency_code) AS 'currency_usage'
	        FROM countries
			GROUP BY continent_code, currency_code
			HAVING count(currency_code) > 1
           ) AS cu2
	JOIN
		(SELECT cu.continent_code, max(currency_usage) AS 'max_currency_usage'
			FROM
		(SELECT continent_code, currency_code ,count(currency_code) AS 'currency_usage'
			FROM countries
			GROUP BY continent_code, currency_code
			HAVING count(currency_code) > 1) AS cu
			GROUP BY cu.continent_code) AS max_cu
ON cu2.continent_code = max_cu.continent_code
AND cu2.currency_usage = max_cu.max_currency_usage
ORDER BY cu2.continent_code, cu2.currency_code;
--------------16-----------------
select count(c.country_code) - count(mountain_id) as CountryCode 
from mountains as m
right join mountains_countries as mc
on m.id=mc.mountain_id
right join countries as c
on mc.country_code=c.country_code

--------------17-----------------
SELECT c.country_name,
       max(p.elevation)as highest_peak_elevation,
       max(r.length)as longest_river_length
from countries as c
left join mountains_countries as mc
on mc.country_code=c.country_code
left join peaks as p
on mc.mountain_id=p.mountain_id
left join countries_rivers as cr
on c.country_code=cr.country_code
left join rivers as r
on cr.river_id=r.id
group by c.country_name
order by highest_peak_elevation desc,
longest_river_length desc, c.country_name asc
limit 5