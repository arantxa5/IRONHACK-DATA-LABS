#LAB 2.6 ARA
#Instructions
USE sakila;
#Get release years.
SELECT DISTINCT release_year FROM film;

#Get all films with ARMAGEDDON in the title.
#USAMOS CLAUSULA LIKE PARA SELECCIONAR PALABRAS PARECIDAS ARMAGEDDON 
#Y USAMOS % ANTES Y DESPUES DE LA PALABRA PARA QUE BUSQUE AL FINAL Y AL PRINCIPIO 
#DE LA CADENA DE CARACTERES
SELECT * 
FROM film
WHERE title LIKE '%ARMAGEDDON%';

#Get all films which title ends with APOLLO.
#USAMOS % AL INICIO DE LA PALABRA PARA BUSCAR LAS PALABRAS QUE TERMINAN EN APOLLO
SELECT * 
FROM film
WHERE title LIKE '%APOLLO';

#Get 10 the longest films.
SELECT *
FROM film
ORDER BY length DESC
LIMIT 10;

#OPCION ALTERNATIVA?
SELECT DISTINCT length
FROM film
ORDER BY length DESC
LIMIT 10;

#How many films include Behind the Scenes content?
SELECT *
FROM film
WHERE special_features = 'Behind the scenes';

#Drop column picture from staff.
#SE ELIMINA COLUMNA PICTURE PARA SIEMPRE
ALTER TABLE staff DROP COLUMN picture;

#A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name = 'TAMMY' and last_name = 'SANDERS';

#ERROR-algo le falta no funciona
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, active)
SELECT (customer_id, store_id, first_name, last_name, address_id, email,active)
FROM customer
WHERE customer_id = 75;


#Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
#select customer_id from sakila.customer
#where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
#Use similar method to get inventory_id, film_id, and staff_id.

SELECT * FROM customer
WHERE first_name = 'Charlotte' and last_name = 'Hunter';

SELECT * FROM film
WHERE title = "Academy Dinosaur";

SELECT * FROM inventory
WHERE film_id = "1";

SELECT * FROM staff
WHERE first_name= 'Mike' and last_name = 'Hillyer';

SELECT * FROM rental;

#ERROR- no me deja poner el rental_id porque dice que se repite pero ya revise y no es así :(
INSERT INTO rental 	(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id,
last_update)
VALUES ('1005','2023-01-29 19:22:34', '1','130','2023-02-01 19:22:34','1','2023-01-29');

#Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

#Check if there are any non-active users
SELECT * FROM customer
WHERE active = '0';

#Create a table backup table as suggested
CREATE TABLE `unactive_users` (
  `customer_id` smallint(5) unsigned NOT NULL,
  `store_id` tinyint unsigned,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_id` smallint(5) unsigned NOT NULL,
  `active` tinyint(1),
  `create_date` datetime ,
  `last_update` datetime ,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#Insert the non active users in the table backup table
INSERT INTO unactive_users( customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update)
SELECT  customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update
FROM customer
WHERE active = '0';

#VERIFICAMOS QUE NUESTA NUEVA TABLA TENGA LA INFO QUE ESTAMOS POR BORRAR
SELECT * FROM unactive_users;

#Delete the non active users from the table customer
DELETE FROM customer
WHERE active = '0';
#intentamos borrar los usuarios inactivos de la tabla original pero no nos deja porque mandar error q dice que esta 
#llave está referenciado a otra tabla

