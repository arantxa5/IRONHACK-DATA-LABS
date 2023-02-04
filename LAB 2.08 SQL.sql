#LAB 2.08 ARA

#Instructions
#Rank films by length (filter out the rows with nulls or zeros in length column). 
#Select only columns title, length and rank in your output.

USE sakila;
SELECT title, length, DENSE_RANK() OVER (order by length ) AS "RANKING"
FROM film
WHERE length is not null ;

#Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
#In your output, only select the columns title, length, rating and rank.

SELECT title, length, rating, DENSE_RANK() OVER (PARTITION BY rating ORDER BY length DESC ) AS "RANKING"
FROM film
WHERE length is not null ;


#How many films are there for each of the categories in the category table? 
#Hint: Use appropriate join between the tables "category" and "film_category".

SELECT DISTINCT c.name as category, count(f.film_id) over(partition by c.name) as num_films
FROM film_category f
INNER JOIN category c ON f.category_id = c.category_id;

#Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count 
#the number of times an actor appears.

SELECT DISTINCT a.actor_id, a.first_name AS ACTOR_NAME, a.last_name AS ACTOR_LAST_NAME, count(f.film_id) over (partition by a.actor_id) as NUMBER_OF_APPEARANCES
FROM actor a
INNER JOIN film_actor f on a.actor_id = f.actor_id
INNER JOIN film p on f.film_id = p.film_id;


#Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" 
#and "rental" and count the rental_id for each customer.

SELECT DISTINCT c.customer_id , count(r.rental_id) over (partition by c.customer_id) number_of_rentals
FROM customer c
INNER JOIN rental r ON c.customer_id =  r.rental_id;
#?

#Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

SELECT f.title, r.inventory_id , count(r.rental_id) OVER (partition by f.title) as most_rented_film
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id 
INNER JOIN film f ON i.film_id = f.film_id ;
#NO ENTIENDO POR COMPLETO COMO APLICAR EL GROUP BY AQUI
#ERROR, NO ME SALE LA PELICULA BUCKET BROTHERHOOD


#This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.

#Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.