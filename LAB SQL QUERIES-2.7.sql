#LAB SQL QUERIES-2.7 PART 1
USE sakila;

#We have just one item for each film, and all will be placed in the new table. 
# For 2020, the rental duration will be 3 days, with an offer price of `2.99€` and a replacement cost of `8.99€` 
# (these are all fixed values for all movies for this year). 
# The catalog is in a CSV file named **films_2020.csv** that can be found at `files_for_lab` folder.

### Instructions

# - Add the new films to the database.
# - Update information on `rental_duration`, `rental_rate`, and `replacement_cost`.

drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

#Instructions
#Add the new films to the database.



#Hint
#You might have to use the following commands to set bulk import option to ON:
#show variables like 'local_infile';
#set global local_infile = 1;
#If bulk import gives an unexpected error, you can also use the data_import_wizard to insert data into the new table.


#esta variable local_infile, me permite que SQL tenga acceso a la compu en general
SHOW VARIABLES LIKE 'local_infile';
#si no aparece on, ajecutamos lo de abajo
SET global local_infile=1;


#Ahora vamos a cargas un archivo .csv en una tabla dada
#ADDING FILMS

LOAD DATA LOCAL INFILE 'Users/valeria/Documents/IRON HACK-DS/BOOTCAMP/SQL/LAB SQL QUERIES-2.7/films_2020.csv'
INTO TABLE films_2020
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(film_id,title,description,release_year,language_id,original_language_id,rental_duration,rental_rate,length,replacement_cost,rating);

#Update information on rental_duration, rental_rate, and replacement_cost.
#For 2020, the rental duration will be 3 days, with an offer price of `2.99€` and a replacement cost of `8.99€` 
# (these are all fixed values for all movies for this year). 
SELECT * FROM films_2020;

UPDATE films_2020
SET rental_duration= '3', rental_rate = '2.99', replacement_cost = '8.99';

SELECT * FROM films_2020;


#PARTE 2
#Instructions
#In the table actor, what last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
#Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

#SELECCIONAMOS Y FILTRAMOS LOS APELLIDOS QUE SOLO APARECEN UNA VEZ
SELECT last_name FROM actor
GROUP BY last_name
HAVING count(*) =1 ;

#SELECCIONAMOS Y FILATRAMOS LOS APELLIDOS QUE APARECEN MÁS DE UNA VEZ
SELECT last_name FROM actor
GROUP BY last_name
HAVING count(*) > 1 ;

#Using the rental table, find out how many rentals were processed by each employee.
#FILTRAMOS POR STAFF ID Y CONTAMOS CUANTOS HAY DE CADA UNO CON UN GROUP BY STAFF ID
SELECT staff_id, count(*) FROM rental
GROUP BY staff_id;

#Using the film table, find out how many films were released.
SELECT count(film_id) as released_movies FROM film;

#Using the film table, find out how many films there are of each rating.
SELECT rating, count(*) as rating_total FROM film
GROUP BY rating;

#What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT rating, round(avg(length),2) as duration_avg FROM film
GROUP BY rating
ORDER BY duration_avg;

#Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, round(avg(length),2) as duration_avg FROM film
GROUP BY rating
HAVING duration_avg > 120;

