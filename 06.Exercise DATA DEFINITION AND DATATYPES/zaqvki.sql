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
-- -----------8--------------------
CREATE TABLE users(
	id BIGINT UNIQUE AUTO_INCREMENT,
	username VARCHAR(30) UNIQUE  NOT NULL,
	password  VARCHAR(26) NOT NULL,
	profile_picture  BLOB,
	last_login_time DATE,
	is_deleted BOOL
);

ALTER TABLE users
ADD CONSTRAINT pk_users PRIMARY KEY(id);

INSERT INTO users(username, password, last_login_time, is_deleted)
VALUES ('Gogo', 'spojpe',  '2017-05-15', TRUE),
('Bobo','epgojro', '2017-08-05', FALSE),
('Ani',  'rpker', '2017-04-25', TRUE),
('Sasho',  'rgpjrpe', '2017-05-06', TRUE),
('Gery', 'pkptkh','2017-01-11', FALSE);
-- ----------9---------------------
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (`id`, `username`);
-- -----------10------------------
ALTER TABLE users
MODIFY  COLUMN last_login_time 
TIMESTAMP 
NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- -----------11------------------

-- -----------12------------------

-- -----------13------------------

-- -----------14------------------

-- -----------15------------------

-- -----------16------------------

-- -----------17------------------

-- -----------18------------------

-- -----------19------------------

-- -----------20------------------

-- -----------21------------------

-- -----------22------------------

-- -----------23------------------

-- -----------24------------------






