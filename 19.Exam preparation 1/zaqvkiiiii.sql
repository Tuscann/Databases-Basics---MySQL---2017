---------------1------------
<<<<<<< Updated upstream
CREATE TABLE locations (
	id INT NOT NULL AUTO_INCREMENT,
    latitude FLOAT,
    longitude FLOAT,
	PRIMARY KEY (id)
);

CREATE TABLE credentials (
	id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(30),
    password VARCHAR(20),
    PRIMARY KEY (id)
);

CREATE TABLE users (
	id INT NOT NULL AUTO_INCREMENT,
    nickname VARCHAR(25),
    gender CHAR(1),
    age INT,
    location_id INT,
    credential_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_users_locations FOREIGN KEY (location_id) REFERENCES locations(id),
    CONSTRAINT fk_users_credentials FOREIGN KEY (credential_id) REFERENCES credentials(id),
	CONSTRAINT uk_credential_id UNIQUE (credential_id)
);

CREATE TABLE chats (
	id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(32),
    start_date DATE,
    is_active BIT,
    PRIMARY KEY (id)
);

CREATE TABLE messages (
	id INT NOT NULL AUTO_INCREMENT,
    content VARCHAR(200),
    sent_on DATE,
    chat_id INT,
    user_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_messages_chats FOREIGN KEY (chat_id) REFERENCES chats (id),
    CONSTRAINT fk_messages_users FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE users_chats (
	user_id INT NOT NULL,
    chat_id INT NOT NULL,
    CONSTRAINT pk_users_chats PRIMARY KEY (user_id, chat_id),
    CONSTRAINT fk_users_chats_users FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_users_chats_chats FOREIGN KEY (chat_id) REFERENCES chats (id)
);

---------------2------------
insert into messages(content, sent_on, chat_id, user_id)
SELECT concat(concat(concat(u.age, '-', u.gender), '-', l.latitude), '-', l.longitude), '2016-12-15', if(u.gender = 'F', ceil(sqrt(u.age * 2)), round(pow(u.age / 18, 3), 0)), u.id
from users as `u`
join locations as `l`
on l.id = u.location_id
where u.id between 10 and 20;
---------------3------------
update chats as `c`
join messages as `m` on c.id = m.chat_id
join users as `u` on u.id = m.user_id
set c.start_date = (select min(m.sent_on) from messages as `m` where m.chat_id = c.id)
where(m.sent_on < c.start_date)
---------------4------------
DELETE FROM locations
WHERE id IN(
    SELECT l.id FROM (
	     SELECT*FROM locations
		               ) as l
    LEFT JOIN users AS u
    ON l.id=u.location_id
    WHERE u.location_id IS NULL)
---------------5------------
select nickname,gender,age
from users
where age>=22 and age<=37
order by id asc
---------------6------------
select content,sent_on
from messages
where date(sent_on)>'2014-05-12'
and content like'%just%'
order by id desc
---------------7------------
select title,is_ACTIVE
from chats
where (is_active=0 AND LENGTH (title)<5) or(substr(title,3,2)='tl')
ORDER BY TITLE DESC
---------------8------------
select  c.id,title,m.id
from chats as c
left join messages as m
on m.chat_id=c.id 
where 
date(sent_on)<'2012-03-26' and 
substr(title,-1,1)='x'
order by c.id asc,m.id asc
---------------9------------
select c.id,count(*)
from messages as m
right join chats as c
on m.chat_id=c.id
where m.id<90
group by c.id
order by count(*)desc ,c.id asc
limit 5;
---------------10------------
select nickname,email,password
from credentials as c
join users as u
on c.id=u.credential_id
where email like '%co.uk'
order by email asc
---------------11------------
select u.id,u.nickname,u.age
from locations as l
right join users as u
on l.id=u.location_id
where u.location_id is null
order by u.id asc
---------------12------------
select c.customer_id,concat(c.first_name,' ',c.last_name)as full_name,price as ticket_price,a.airport_name as destination
from customers as c
join tickets as t
on t.customer_id=c.customer_id
join flights as f
on f.flight_id=t.flight_id
join airports as a
on f.destination_airport_id=a.airport_id
=======
CREATE TABLE towns (
	town_id INT,
	town_name VARCHAR(30) NOT NULL,
	CONSTRAINT pk_towns PRIMARY KEY(town_id)
);

CREATE TABLE airports (
	airport_id INT,
	airport_name VARCHAR(50) NOT NULL,
	town_id INT NOT NULL,
	CONSTRAINT pk_airports PRIMARY KEY(airport_id),
	CONSTRAINT fk_airports_towns FOREIGN KEY(town_id) REFERENCES towns(town_id)
);

CREATE TABLE airlines (
	airline_id INT,
	airline_name VARCHAR(30) NOT NULL,
	natiONality VARCHAR(30) NOT NULL,
	rating INT DEFAULT 0,
	CONSTRAINT pk_airlines PRIMARY KEY(airline_id)
);

CREATE TABLE flights (
	flight_id INT AUTO_INCREMENT,
	departure_time DATETIME NOT NULL,
	arrival_time DATETIME NOT NULL,
	status VARCHAR(9) NOT NULL,
	origin_airport_id INT,
	destinatiON_airport_id INT,
	airline_id INT NOT NULL,
	CONSTRAINT pk_flights PRIMARY KEY(flight_id),
	CONSTRAINT fk_flights_airports_origin FOREIGN KEY(origin_airport_id) REFERENCES airports(airport_id),
	CONSTRAINT fk_flights_airports_destinatiON FOREIGN KEY(destinatiON_airport_id) REFERENCES airports(airport_id),
	CONSTRAINT fk_flights_airlines FOREIGN KEY(airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE customers (
	customer_id INT,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	date_of_birth DATE NOT NULL,
	gender VARCHAR(1) NOT NULL,
	home_town_id INT NOT NULL,
	CONSTRAINT pk_customers PRIMARY KEY(customer_id),
	CONSTRAINT fk_customers_towns FOREIGN KEY(home_town_id) REFERENCES towns(town_id)
);

CREATE TABLE tickets (
	ticket_id INT,
	price DECIMAL(8,2) NOT NULL,
	class VARCHAR(6) NOT NULL,
	seat VARCHAR(5) NOT NULL,
	customer_id INT NOT NULL,
	flight_id INT NOT NULL,
	CONSTRAINT pk_tickets PRIMARY KEY(ticket_id),
	CONSTRAINT fk_tickets_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
	CONSTRAINT fk_tickets_flights FOREIGN KEY(flight_id) REFERENCES flights(flight_id)
);
---------------2------------
INSERT INTO flights 
(departure_time, arrival_time,status,origin_airport_id,destinatiON_airport_id,airline_id)
SELECT 
		'2017-06-19 14:00:00',
		'2017-06-21 11:00:00',
 		CASE a.airline_id % 4
		WHEN 0 then 'Departing'
   	    WHEN 1 then 'Delayed'
    	WHEN 2 then 'Arrived'
     	WHEN 3 then 'Canceled'
		end,  
		ceiling(sqrt(char_length(a.airline_name))),
		ceiling(sqrt(char_length(a.natiONality))),
		a.airline_id
FROM airlines as a
WHERE a.airline_id BETWEEN 1 AND 10;
---------------3------------
update flights 
set airline_id=1
where status='Arrived';
---------------4------------
UPDATE tickets
SET tickets.price = tickets.price*1.5 
WHERE tickets.flight_id IN 
     (SELECT f.flight_id 
	   FROM flights AS f
       INNER JOIN airlines AS a
       ON a.airline_id = f.airline_id
       WHERE a.airline_id = 
	        (SELECT a.airline_id 
			FROM airlines AS a
              WHERE a.rating = (
			      SELECT MAX(a.rating) FROM airlines AS a)));
---------------5------------
select t.ticket_id,t.price,t.class,t.seat
FROM tickets as t
order by t.ticket_id asc
---------------6------------
select customer_id,CONCAT(first_name,' ',last_name)as full_name,gender
FROM customers
order by full_name asc,customer_id asc
---------------7------------
select f.flight_id,f.departure_time,f.arrival_time
FROM flights as f
where status='Delayed'
order by f.flight_id asc
---------------8------------
select DISTINCT a.airline_id,a.airline_name,a.natiONality,a.rating
FROM airlines as a
JOIN flights as f
ON a.airline_id=f.airline_id
order by a.rating desc,a.airline_id
limit 5
---------------9------------
select t.ticket_id,a.airport_name as destinatiON,CONCAT(c.first_name,' ',c.last_name)as customer_name
FROM customers as c
JOIN tickets as t
ON c.customer_id=t.customer_id
JOIN flights as f
ON t.flight_id=f.flight_id
JOIN airports as a
ON a.airport_id=f.destinatiON_airport_id
where t.class='First' and t.price<5000
order by t.ticket_id asc;

---------------10------------
select DISTINCT c.customer_id,CONCAT(c.first_name,' ',c.last_name)as full_name,tn.town_name
FROM customers as c
      INNER JOIN tickets as t ON t.customer_id=c.customer_id
      INNER JOIN flights as f ON f.flight_id=t.flight_id
      INNER JOIN airports as a ON a.airport_id=f.origin_airport_id
      INNER JOIN towns as tn ON tn.town_id=a.town_id
where f.`status`='Departing' and a.town_id=c.home_town_id
order by c.customer_id
---------------11------------
select DISTINCT c.customer_id,
       CONCAT(c.first_name,' ',c.last_name) as full_name,
	   TIMESTAMPDIFF(YEAR, c.date_of_birth, '2016-12-31') as age
FROM customers as c 
  INNER JOIN tickets as tk ON c.customer_id = tk.customer_id
  INNER JOIN flights as f ON tk.flight_id = f.flight_id
where f.`status` = 'Departing' 
order by age asc,c.customer_id asc;                   
---------------12------------
select c.customer_id,
   CONCAT(c.first_name,' ',c.last_name)as full_name,
   price as ticket_price,
   a.airport_name as destinatiON
FROM customers as c
  JOIN tickets as t ON t.customer_id=c.customer_id
  JOIN flights as f ON f.flight_id=t.flight_id
  JOIN airports as a ON f.destinatiON_airport_id=a.airport_id
>>>>>>> Stashed changes
where f.`status`='Delayed'
order by price desc,c.customer_id asc 
limit 3;
---------------13------------
<<<<<<< Updated upstream
select u.nickname,c.title,l.latitude,l.longitude
from users as u
join locations as l on u.location_id=l.id
join users_chats as uc on u.id=uc.user_id
join chats as c on c.id=uc.chat_id
where (latitude between 41.139999 and 44.129999) and (longitude between 22.209999 and 28.359999)
order by c.title asc
---------------14------------
select distinct c.customer_id,concat(c.first_name,' ',c.last_name)as full_name,TIMESTAMPDIFF(YEAR, c.date_of_birth, '2016-12-31') as age
from customers as c
join tickets as t
on t.customer_id=c.customer_id
join flights as f
on f.flight_id=t.flight_id
=======
SELECT * FROM 
(SELECT f.flight_id , f.departure_time, f.arrival_time, a.airport_name as origin, t.airport_name as destinatiON
  FROM flights AS f
  INNER JOIN airports AS a ON f.origin_airport_id = a.airport_id
  INNER JOIN airports AS t ON f.destinatiON_airport_id = t.airport_id
  where f.`status` = 'Departing'
  order by f.departure_time desc
  limit 5) AS q
order by q.departure_time, q.flight_id
---------------14------------
SELECT DISTINCT c.customer_id,CONCAT(c.first_name,' ',c.last_name)as full_name,TIMESTAMPDIFF(YEAR, c.date_of_birth, '2016-12-31') as age
FROM customers as c
    JOIN tickets as t ON t.customer_id=c.customer_id
    JOIN flights as f ON f.flight_id=t.flight_id
>>>>>>> Stashed changes
where status='Arrived' and TIMESTAMPDIFF(YEAR, c.date_of_birth, '2016-12-31') < 21
order by age desc,c.customer_id asc
---------------15------------
select a.airport_id,a.airport_name,count(t.ticket_id) as passengers 
from airports as a
   join flights as f on a.airport_id=f.origin_airport_id
   join tickets as t on f.flight_id=t.flight_id
where f.status='Departing' 
group by a.airport_id,a.airport_name
<<<<<<< Updated upstream
having count(t.ticket_id) > 0
order by a.airport_id;
---------------16------------
CREATE PROCEDURE udp_submit_review(customer_id INT, review_content VARCHAR(255), review_grade INT, airline_name VARCHAR(30))
BEGIN
START TRANSACTION;
IF(SELECT COUNT(a.airline_id) FROM airlines AS a WHERE a.airline_name = airline_name)<>1
THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Airline does not exist.';
ROLLBACK;
ELSE 
INSERT INTO customer_reviews(review_content, review_grade,airline_id,customer_id)
VALUES (review_content,review_grade , (SELECT a.airline_id FROM airlines AS a WHERE a.airline_name = airline_name), customer_id);
COMMIT;
END IF;
ENd;
=======
having count(t.ticket_id) > 0 
order by a.airport_id;
---------------16------------
create table custmer_reviews(
   review_id INT PRIMARY KEY,
   review_content	varchar(255) NOT NULL ,
   review_grade INT,
   airline_id INT	,
   customer_id	INT,
   constraint fk_custmer_reviews_airlines foreign key(airline_id) references airlines(airline_id),
   constraint fk_custmer_reviews_customers foreign key(customer_id) references customers(customer_id)
);

create table customer_bank_accounts(
   account_id INT PRIMARY KEY,
   account_number	varchar(10) UNIQUE NOT NULL ,
   balance decimal(10,2) NOT NULL,
   customer_id	INT,
   constraint fk_customer_bank_accounts_customers foreign key(customer_id) references customers(customer_id)   
);




>>>>>>> Stashed changes
---------------17------------
CREATE PROCEDURE udp_purchase_ticket(IN customer_id INT, IN flight_id INT, IN ticket_price DECIMAL(8,2), IN class VARCHAR(6), IN seat VARCHAR(5))
BEGIN
START TRANSACTION;
IF (SELECT b.balance FROM customer_bank_accounts AS b WHERE b.customer_id = customer_id) < ticket_price
THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient bank account balance for ticket purchase.';
	ROLLBACK;
ELSE
	INSERT INTO tickets(price,class, seat, customer_id, flight_id)
	VALUES (ticket_price, class, seat, customer_id, flight_id);
	UPDATE customer_bank_accounts
	SET customer_bank_accounts.balance = customer_bank_accounts.balance - ticket_price
	WHERE customer_bank_accounts.customer_id = customer_id;
	COMMIT;
END IF;
END
---------------18------------
CREATE TRIGGER tr_update_flight_status

BEFORE UPDATE
ON `flights`
FOR EACH ROW
BEGIN
		IF
		old.`status` NOT IN ('Cancelled', 'Arrived')
		AND new.`status` = 'Arrived'
	THEN
		INSERT INTO `arrived_flights` (`flight_id`, `arrival_time`, `origin`, `destination`, `passengers`)
		VALUES (old.flight_id, new.arrival_time, 
				(SELECT a.airport_name FROM airports AS a WHERE a.airport_id = new.origin_airport_id),
				(SELECT a.airport_name FROM `airports` AS a WHERE a.airport_id = new.destination_airport_id),
				(SELECT COUNT(*) FROM tickets AS t
								 WHERE t.flight_id = old.flight_id));
	END IF;
	
END 




