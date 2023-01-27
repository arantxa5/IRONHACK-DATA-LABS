#Lab | SQL Queries - Lesson 2.5

#In this lab, you will be using the Sakila database of movie rentals. 
#You can follow the steps listed here to get the data locally: Sakila sample database - installation.

#Instructions

USE sakila;
SHOW TABLES;

#1. Select all the actors with the first name ‘Scarlett’.
SELECT first_name 
FROM actor 
WHERE first_name = 'Scarlett';

#2. How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(inventory_id) 
FROM inventory;
SELECT COUNT(inventory_id)
FROM rental;

#3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
#respuesta= la duracion maxima es 185 mins y la minima 46
SELECT max(length) AS MAX_DURATION, min(length) AS MIN_DURATION 
FROM film;

#y aqui podemos acceder a que peliculas pertenecen esa maxima y minima duracion
SELECT title, length 
FROM film
WHERE length IN ((SELECT MAX(length)AS max_duration FROM film), (SELECT MIN(length) AS min_duration FROM film ));

#4. What's the average movie duration expressed in format (hours, minutes)?
SELECT TIME_FORMAT(SEC_TO_TIME((AVG(length))*60), "%H:%i") AS AVERAGE_LENGTH 
FROM film;

#5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) 
FROM actor;

#6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(last_update),MIN(rental_date)) AS No_Of_days
FROM rental;

#7. Show rental info with additional columns month and weekday. Get 20 results.
#Extra para extraer meses:
ALTER TABLE rental
DROP COLUMN month;
ALTER TABLE rental
DROP COLUMN weekday;
SELECT *, SUBSTR(return_date,6,2)
FROM rental
LIMIT 20;
SELECT *, WEEKDAY(return_date)
FROM rental
LIMIT 20;

#8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'Weekend' 
       ELSE 'Workday' END AS day_type
FROM rental;       

#9. How many rentals were in the last month of activity?
SELECT DATE_SUB(MAX(rental_date), INTERVAL 30 DAY)
FROM rental;
SELECT rental_date FROM rental 
WHERE 
COUNT(rental_date) BETWEEN
'2006-01-15 15:16:03' AND
 '2006-02-14 15:16:03';

