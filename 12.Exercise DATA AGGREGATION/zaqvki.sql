-- -----------------1---------
select count(w.id) as count from wizzard_deposits as w
-- -----------------2---------
select max(w.magic_wand_size) as longest_magic_wand from wizzard_deposits as w
-- -----------------3--------------------
select deposit_group,max(w.magic_wand_size) as longest_magic_wand 
from wizzard_deposits as w
group by deposit_group
-- -----------------4-----

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
 SELECT CASE
			WHEN age <= 10 THEN '[0-10]'
			WHEN age <= 20 THEN '[11-20]'
			WHEN age <= 30 THEN '[21-30]'
			WHEN age <= 40 THEN '[31-40]'
			WHEN age <= 50 THEN '[41-50]'
			WHEN age <= 60 THEN '[51-60]'
			ELSE '[61+]'
		END AS age_group,
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

-- -----------------12------------------

-- -----------------13------------------

-- -----------------14------------------

-- -----------------15------------------

-- -----------------16------------------

-- -----------------17-----------------

-- -----------------18-----------------

-- -----------------19-----------------


