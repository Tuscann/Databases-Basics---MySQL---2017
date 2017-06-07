-- -----------------1---------
select count(w.id) as count from wizzard_deposits as w
-- -----------------2---------
select max(w.magic_wand_size) as longest_magic_wand from wizzard_deposits as w
-- -----------------3--------------------
select deposit_group,max(w.magic_wand_size) as longest_magic_wand 
from wizzard_deposits as w
group by deposit_group
-- -----------------4-----
  SELECT deposit_group FROM
(SELECT deposit_group, AVG(magic_wand_size) AS avrage_magic_wand_size
   FROM wizzard_deposits
  GROUP BY deposit_group) as avgm
  WHERE avrage_magic_wand_size = ( SELECT MIN(avrage_magic_wand_size) min_average_magic_wand_size 
								   FROM
								(SELECT deposit_group, AVG(magic_wand_size) AS avrage_magic_wand_size
								   FROM wizzard_deposits
								  GROUP BY deposit_group) AS av)
-- -----------------5-------------
select deposit_group ,sum(w.deposit_amount) as longest_magic_wand 
from wizzard_deposits as w
group by deposit_group
-- -----------------6-------------
select deposit_group ,sum(w.deposit_amount) as longest_magic_wand 
from wizzard_deposits as w
where w.magic_wand_creator='Ollivander family'
group by deposit_group;
-- -----------------7-------------
select deposit_group ,sum(w.deposit_amount) as total_sum 
from wizzard_deposits as w
where w.magic_wand_creator='Ollivander family'
group by deposit_group
having total_sum<150000
order by total_sum desc
-- -----------------8--------------------
select w.deposit_group,w.magic_wand_creator,min(w.deposit_charge) as min_deposit_charge 
from wizzard_deposits as w
group by w.magic_wand_creator,w.deposit_group
-- -----------------9---------------------
 SELECT 
        CASE
			WHEN age <= 10 THEN '[0-10]'
			WHEN age <= 20 THEN '[11-20]'
			WHEN age <= 30 THEN '[21-30]'
			WHEN age <= 40 THEN '[31-40]'
			WHEN age <= 50 THEN '[41-50]'
			WHEN age <= 60 THEN '[51-60]'
			ELSE '[61+]'
		END 
		AS age_group,
        COUNT(*) AS wizzard_count
   FROM wizzard_deposits
  GROUP BY CASE
			WHEN age <= 10 THEN '[0-10]'
			WHEN age <= 20 THEN '[11-20]'
			WHEN age <= 30 THEN '[21-30]'
			WHEN age <= 40 THEN '[31-40]'
			WHEN age <= 50 THEN '[41-50]'
			WHEN age <= 60 THEN '[51-60]'
			ELSE '[61+]'
	END
-- -----------------10------------------
-- use gringotts;
select distinct substring(first_name,1,1) as first_letter from wizzard_deposits
where deposit_group='Troll Chest'
order by first_letter;
------------------------
-- use gringotts;
select substring(first_name,1,1) as first_letter from wizzard_deposits
where deposit_group='Troll Chest'
group by first_letter
order by first_letter;
-- -----------------11------------------
select deposit_group,is_deposit_expired,avg(deposit_interest) as average_interest from wizzard_deposits
where deposit_start_date>'1985-01-01'
group by deposit_group,is_deposit_expired
ORDER BY deposit_group DESC,is_deposit_expired ASC
-- -----------------12------------------
create view rw_pw as
select w1.first_name as host_wizzard
,w1.deposit_amount as host_wizzard_deposit
,w2.first_name as guest_wizzard,
w2.deposit_amount as guest_wizzard_deposit
from wizzard_deposits as w1,wizzard_deposits as w2
where w1.id+1=w2.id;

select sum(host_wizzard_deposit-guest_wizzard_deposit)
from rw_pw;
-- -----------------13------------------
select department_id,min(salary) as minimum_salary from employees
where hire_date>'2000-01-01'
group by department_id
having department_id in (2,5,7);
-- -----------------14------------------
create table NewTable select* from Employees
where salary > 30000;

delete from NewTable
where manager_id = 42;

update NewTable
set Salary = Salary + 5000
where department_id = 1;

select department_id, avg(salary) as avg_salary
from NewTable
group by department_id
order by department_id;
-- -----------------15------------------
select department_id,max(salary) as max_salary 
from employees	
group by department_id
having not max(Salary) between 30000 and 70000;
-- -----------------16------------------
select count(*) as count 
from employees
where manager_id is null
-- -----------------17-----------------
SELECT e.department_id, MAX(salary) AS third_max_salary
 FROM employees AS e
 JOIN
(SELECT e.department_id, MAX(salary) as second_max_salary 
  FROM employees AS e
JOIN
(SELECT department_id, MAX(salary) as max_salary 
   FROM employees
  GROUP BY department_id) AS max_salary
    ON e.department_id = max_salary.department_id
   AND e.salary < max_salary.max_salary
 GROUP BY e.department_id) second_max_salary
    ON e.department_id = second_max_salary.department_id
   AND e.salary < second_max_salary.second_max_salary
GROUP BY e.department_id
-- -----------------18-----------------
select e.first_name,e.last_name,e.department_id
from employees as e,(select e.department_id,avg(e.salary) as avg_salary
                   from employees as e
                    group by e.department_id
                    ) as avg_salary_by_dep
where e.department_id = avg_salary_by_dep.department_id
and e.salary > avg_salary_by_dep.avg_salary
order by e.department_id asc
limit 10;
-- -----------------19-----------------
select department_id,sum(salary) as total_salary from employees
group by department_id
order by department_id asc;

