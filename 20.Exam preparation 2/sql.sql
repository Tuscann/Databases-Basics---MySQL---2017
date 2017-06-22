-------1----------------
-- CREATE DATABASE EXAM;
-- USE EXAM

create table credentials(
   id INT(11),
   email VARCHAR(30),
   password VARCHAR(20),
   constraint pk_credentials primary key(id)
);
create table locations(
   id INT(11),
   latitude FLOAT,
   longitude FLOAT,
   constraint pk_locations primary key(id)
);
create table users(
  id INT(11),
  nickname varchar(25),
  gender char(1),
  age INT(11),
  location_id INT(11),
  credential_id INT(11) UNIQUE,
  constraint pk_users primary key(id),
  constraint fk_locations foreign key(location_id)
  references locations(id),
  constraint fk_credentials foreign key(credential_id)
  references credentials(id)
);
create table chats(
  id INT(11),
  title varchar(32),
  start_date DATE,
  is_active BIT(1),
  constraint pk_chats primary key(id)
);
create table messages(
   id INT(11),
   content varchar(200),
   sent_on DATE,
   chat_id INT(11),
   user_id INT(11),
   constraint pk_messages primary key(id),
   constraint fk_users foreign key(user_id) references users(id),
   constraint fk_chats foreign key(chat_id) references chats(id)
);
create table users_chats(
    user_id INT(11),
    chat_id INT(11),
    constraint pk_users_chats primary key(user_id, chat_id),
    constraint fk_users_chats_users foreign key(user_id) references users(id),
    constraint fk_users_chats_chats foreign key(chat_id) references chats(id)
);
-------2----------------
insert into messages(content, sent_on, chat_id, user_id)
SELECT concat(concat(concat(u.age, '-', u.gender), '-', l.latitude), '-', l.longitude), '2016-12-15', if(u.gender = 'F', ceil(sqrt(u.age * 2)), round(pow(u.age / 18, 3), 0)), u.id
from users as `u`
join locations as `l`
on l.id = u.location_id
where u.id between 10 and 20;
-------3----------------
update chats
join messages
on messages.chat_id=chats.id
set start_date=sent_on
where start_date>sent_on
-------4----------------
DELETE FROM locations
WHERE id IN(
    SELECT l.id FROM (
	     SELECT*FROM locations
		               ) as l
    LEFT JOIN users AS u
    ON l.id=u.location_id
    WHERE u.location_id IS NULL)
-------5----------------
select nickname,gender,age
from users
where age>=22 and age<=37
order by id asc
-------6----------------
select nickname,gender,age
from users
where age>=22 and age<=37
order by id asc
-------7----------------
select title,is_ACTIVE
from chats
where (is_active=0 AND LENGTH (title)<5) or(substr(title,3,2)='tl')
ORDER BY TITLE DESC
-------8----------------
select  c.id,title,m.id
from chats as c
left join messages as m
on m.chat_id=c.id
where
date(sent_on)<'2012-03-26' and
substr(title,-1,1)='x'
order by c.id asc,m.id asc
-------9----------------
select c.id,count(*)
from messages as m
right join chats as c
on m.chat_id=c.id
where m.id<90
group by c.id
order by count(*)desc ,c.id asc
limit 5;
-------10----------------
select nickname,email,password
from credentials as c
join users as u
on c.id=u.credential_id
where email like '%ço.uk'
order by email asc
-------11----------------
select u.id,u.nickname,u.age
from locations as l
right join users as u
on l.id=u.location_id
where u.location_id is null
order by u.id asc
-------12----------------

-------13----------------
select u.nickname,c.title,l.latitude,l.longitude
from users as u
join locations as l on u.location_id=l.id
join users_chats as uc on u.id=uc.user_id
join chats as c on c.id=uc.chat_id
where (latitude between 41.139999 and 44.129999) and (longitude between 22.209999 and 28.359999)
order by c.title asc

-------14----------------

-------15----------------

-------16----------------

-------17----------------

-------18----------------

-------19----------------
