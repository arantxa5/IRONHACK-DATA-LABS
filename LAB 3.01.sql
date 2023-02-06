#LAB 3.01

#List the number of films per category.

USE sakila;
SELECT DISTINCT c.name, count(f.film_id) over (partition by c.name) as FILMS_PER_CATEGORY
FROM category c
INNER JOIN film_category f ON f.category_id = c.category_id;

#Display the first and the last names, as well as the address, of each staff member.

SELECT s.first_name, s.last_name, a.address
FROM staff s 
INNER JOIN address a ON s.address_id = a.address_id;

#Display the total amount rung up by each staff member in August 2005.

SELECT DISTINCT s.staff_id, s.first_name, s.last_name, sum(p.amount) OVER (partition by s.staff_id) AS AMOUNT_PAID 
FROM staff s 
INNER JOIN payment p ON s.staff_id = p.staff_id
WHERE MONTH(payment_date) = 8 AND YEAR(payment_date) = 2005;

#List all films and the number of actors who are listed for each film.

SELECT DISTINCT f.film_id, f.title, count(fa.actor_id) over(partition by f.film_id)  AS NUMBER_OF_ACTORS
FROM film f 
INNER JOIN film_actor fa ON fa.film_id = f.film_id ;


#Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer.
# List the customers alphabetically by their last names.

SELECT DISTINCT c.customer_id, c.last_name, sum(p.amount) OVER (partition by c.customer_id) AS AMOUNT_PAID 
FROM customer c
INNER JOIN payment p ON c.customer_id = p.staff_id
ORDER BY c.last_name asc;

