#LAB SQL SELF AND CROSS JOIN

SHOW DATABASES;
USE sakila;
SHOW tables;

# Get all pairs of actors that worked together.

SELECT * FROM film_actor;
SELECT film_actor.actor_id, f.film_id AS "Shared_film_id" , f.actor_id AS "Shared_actor_id" FROM film_actor
INNER JOIN film_actor f ON f.film_id = film_actor.film_id;

# Get all customers that have rented the same film more than 3 times.
SELECT * FROM rental;
SELECT rental.customer_id, COUNT(rental.inventory_id) AS "number_of_rentals" FROM rental
INNER JOIN rental AS r ON rental.inventory_id = r.inventory_id
GROUP BY rental.customer_id
HAVING COUNT(rental.inventory_id)>3;

# Get all possible pairs of actors and films.
SELECT * FROM film_actor;
SELECT fa.actor_id, fa.film_id FROM film_actor AS fa
CROSS JOIN film_actor fa2
ORDER BY fa.actor_id ASC;


