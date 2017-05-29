-- -------------------------1---------
CREATE DATABASE minions;
-- -------------------------2---------
USE  minions;
CREATE TABLE minions (
   id int PRIMARY KEY
  ,name VARCHAR(50)
  ,age int
);
  
CREATE TABLE towns(
id int PRIMARY KEY
, name VARCHAR(50)
);
-- -------------------3--------------------
ALTER TABLE minions ADD column town_id int;
ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns FOREIGN KEY(town_id)
REFERENCES towns(id);
-- -------------------4-----
INSERT INTO towns(id, name)
VALUES (1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO minions(id, name, age, town_id)
VALUES (1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);
-- -----------------5-------------
Truncate table minions;
-- -----------------6-------------
DROP TABLE minions;
DROP TABLE towns;
-- drop database minions
-- -----------------7-------------
create table people (
  id int AUTO_INCREMENT,
  name VARCHAR(200) not null,
  picture mediumblob
  ,height float(6,2)
  ,weight float(6,2)
  ,gender enum ('m','f') not null
  ,birthdate datetime not null
  ,biography text,
  constraint pk_people PRIMARY key (id)
);
INSERT INTO people(id,name,gender,birthdate,biography)
VALUES(1,'kamen','f','2008-11-11','dasssssssssssssss')
,(2,'aakamen','f','2008-11-11','dasssssssssssssss')
,(3,'sakamen','f','2008-11-11','dasssssssssssssss')
,(4,'aakamen','f','2008-11-11','dasssssssssssssss')
,(5,'asdkamen','f','2008-11-11','dasssssssssssssss');

