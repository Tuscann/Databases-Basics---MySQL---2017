----------------1------------------
CREATE TABLE users (
 id INT(11),
 username VARCHAR(30) UNIQUE NOT NULL,
 password VARCHAR(30) NOT NULL,
 email VARCHAR(50),
 CONSTRAINT PK_users PRIMARY KEY(id)
);

CREATE TABLE categories (
 id INT(11),
 name VARCHAR(50) NOT NULL,
 parent_id INT(11),
 CONSTRAINT PK_categories PRIMARY KEY(id),
 CONSTRAINT FK_categories_categories FOREIGN KEY(parent_id)
 REFERENCES categories(id)
);

CREATE TABLE contests (
 id INT(11),
 name VARCHAR(50) NOT NULL,
 category_id INT(11),
 CONSTRAINT PK_contetst PRIMARY KEY(id),
 CONSTRAINT FK_contetst_categories FOREIGN KEY(category_id)
 REFERENCES categories(id)
);

CREATE TABLE problems (
 id INT(11) PRIMARY KEY,
 name varchar(100) not null,
 points int(11) not null,
 tests int(11) DEFAULT 0,
 contest_id int(11),
 CONSTRAINT FK_problems_contests FOREIGN KEY(contest_id)
 REFERENCES contests(id)
);

CREATE TABLE submissions (
 id INT(11) AUTO_INCREMENT,
 passed_tests int(11) not null,
 problem_id int(11),
 user_id int(11),
 CONSTRAINT PK_submissions PRIMARY KEY(id),
 CONSTRAINT FK_submissions_problems FOREIGN KEY(problem_id)
 REFERENCES problems(id),
 CONSTRAINT FK_submissions_users FOREIGN KEY(user_id)
 REFERENCES users(id)
);

CREATE TABLE users_contests (
 user_id INT(11),
 contest_id int(11),
 CONSTRAINT pk_users_contests PRIMARY KEY(user_id, contest_id),
 CONSTRAINT fk_users_contests_users FOREIGN KEY(user_id)
 REFERENCES users(id),
 CONSTRAINT fk_users_contests_contests FOREIGN KEY(contest_id)
 REFERENCES contests(id)
);
----------------2------------------
insert into submissions(passed_tests,problem_id,user_id)
select ceil(sqrt(pow(length(p.name),3)) - length(p.name))
,p.id
,ceil(p.id*3)/2
from problems as p
where p.id between 1 and 10
----------------3------------------
update 
-- select *from 
 problems as p
 join contests as c
 on c.id = p.contest_id
 join categories as cat
 on cat.id=c.category_id
 join submissions as s
 on p.id = s.problem_id
set p.tests =(
   case p.id %3
       when 0 then length(cat.name)
       when 1 then (select sum(s.id) from submissions as s where s.problem_id=p.id)
       when 2 then length(c.name)
   END

) 
where p.tests = 0;
----------------4------------------
DELETE FROM users
WHERE id NOT IN (SELECT uc.user_id
                   FROM users_contests uc);
----------------5------------------
select u.id,u.username,u.email
from users as u
----------------6------------------
select c.id,c.name
from categories as c
where c.parent_id is null
order by c.id asc
----------------7------------------
select p.id,p.name,p.tests
from problems as p
where p.tests > p.points and p.name like '% %'
order by p.id desc;
----------------8------------------
select DISTINCT p.id,CONCAT_WS(' - ',car.name,c.name,p.name) as full_path
from categories as car
join contests as c
on car.id=c.category_id
join problems as p
on p.contest_id=c.id
order by p.id asc
----------------9------------------
SELECT 
 c1.id,
 c1.name
FROM categories AS c1
LEFT OUTER JOIN categories AS c2
ON c1.id = c2.parent_id
WHERE c2.id IS NULL
ORDER BY c1.name ASC, c1.name ASC;
----------------10------------------
select u.id,u.username,u.password
from users as u
where u.password in(
SELECT us.password 
    FROM users AS us
	 WHERE us.username != u.username
)
order by u.username asc,u.id asc
---
SELECT 
 u.id,
 u.username,
 u.password
FROM users AS u
WHERE (
   SELECT COUNT(*) 
   FROM users AS u1 
   WHERE u1.password = u.password
) > 1
ORDER BY u.username ASC, u.id ASC;
----------------11------------------

----------------12------------------

----------------13------------------

----------------14------------------

----------------15------------------

----------------16------------------

----------------17------------------

