-- ------------2----------
SELECT *
FROM departments
-- -----------3------------
SELECT name FROM departments
-- -----------4-------------
SELECT first_name,last_name,salary FROM employees
-- -----------5-------------
SELECT first_name,middle_name,last_name FROM employees
-- -----------6-------------
SELECT CONCAT(first_name,'.',last_name,'@softuni.bg') as `full_email_address` FROM employees
-- -----------7-------------
SELECT DISTINCT salary FROM employees ORDER BY salary
-- -----------8-------------
SELECT *
FROM employees 
WHERE job_title='Sales Representative';
-- -----------9-------------
SELECT first_name,last_name,job_title FROM employees 
WHERE salary>=20000 and salary<=30000;
-- -----------10-------------
SELECT first_name,last_name,job_title FROM employees 
WHERE salary>=20000 and salary<=30000;
-- -----------11-------------
SELECT first_name,last_name  
FROM employees
WHERE manager_id is NULL
-- -----------12-------------
SELECT first_name,last_name,salary FROM employees
WHERE salary>50000
ORDER BY salary DESC;
-- -----------13-------------
SELECT first_name,last_name 
FROM employees
ORDER BY salary DESC
LIMIT 5
-- -----------14-------------
SELECT first_name,last_name FROM employees
WHERE department_id !=4;
-- -----------15-------------
SELECT * FROM employees
ORDER BY salary DESC,first_name ASC,last_name DESC,middle_name ASC;c
-- -----------16-------------
SELECT * FROM employees
ORDER BY salary DESC,first_name ASC,last_name DESC,middle_name ASC;

-- -----------17-------------
UPDATE `employees`
	SET `middle_name` = ''
	WHERE `middle_name` IS NULL;
	
CREATE VIEW `v_employees_job_titles` AS
	SELECT CONCAT_WS(' ', `first_name`,`middle_name`, `last_name`) AS 'full_name' ,`job_title` 
	FROM `employees`;
-- -----------18-------------
SELECT DISTINCT job_title FROM employees
ORDER BY job_title
-- -----------19-------------
SELECT *FROM projects
ORDER BY start_date,name 
LIMIT 10;
-- -----------20-------------
SELECT first_name,last_name,hire_date 
FROM employees
ORDER BY hire_date DESC
LIMIT 7;
-- -----------21---------------
update employees
set salary=salary*1.12
WHERE department_id='1'or department_id='2' or department_id='4' or department_id='11';
SELECT salary FROM employees;
-- -----------22---------------
SELECT peak_name FROM peaks ORDER BY peak_name
-- -----------23---------------
SELECT country_name,population FROM countries 
WHERE continent_code='EU'
ORDER BY population DESC,country_name
LIMIT 30
-- -----------24---------------
SELECT country_name,country_code,if(currency_code='EUR','Euro','Not Euro') as currency FROM countries 
ORDER BY country_name ASC
-- -----------25---------------
SELECT country_name,country_code,if(currency_code='EUR','Euro','Not Euro') as currency FROM countries 
ORDER BY country_name ASC






