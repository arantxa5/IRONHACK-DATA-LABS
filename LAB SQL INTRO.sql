#LAB 1
#Use sakila database.
USE sakila;

#GET ALL DATA FROM TABLES ACTOR, FILM AND CUSTOMER
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;

#GET FILM TITLES
SELECT title FROM film;

#Get unique list of film languages under the alias language. Note that we are not asking you to obtain the language per each film,
# but this is a good time to think about how you might get that information in the future.

SELECT DISTINCT name AS language FROM language;

#prueba de como agrupar por language_id
SELECT DISTINCT name, language_id FROM language
GROUP BY language_id;

#5.1 Find out how many stores does the company have?
SELECT COUNT(*) FROM store;
#HAY DOS TIENDAS

#5.2 Find out how many employees staff does the company have?
SELECT COUNT(*) FROM staff;
#hay dos personas

#5.3 Return a list of employee first names only?
SELECT first_name FROM staff;


