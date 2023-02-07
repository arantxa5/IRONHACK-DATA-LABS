#LAB SQL JOINS ON MULTIPLE TABLES-ARA

#Write a query to display for each store its store ID, city, and country.
#1 STORE, 2 ADDRESS, 3 CITY Y 4 COUNTRY

USE sakila;

SELECT s.store_id , ci.city, co.country 
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id;

#Write a query to display how much business, in dollars, each store brought in.

#1 store -store id 2 customer -customer id 3 payment amount

SELECT DISTINCT s.store_id , count(p.amount) OVER (partition by s.store_id) AS DOLLARS_SOLD
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id;

#What is the average running time of films by category?
#1 film film_id 2 film category category_id 3 category cat id y name

SELECT DISTINCT c.name , AVG(f.length) OVER (partition by c.name) AS AVG_RUNNING_TIME
FROM category c 
JOIN film_category fc on fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id;


#Which film categories are longest?

SELECT DISTINCT c.name, max(f.length) OVER(partition by c.name) AS longest_film_category
FROM category c 
JOIN film_category fc on fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
ORDER BY longest_film_category DESC;

#Display the most frequently rented movies in descending order.
#rental inventory id, inventory, film id film

SELECT DISTINCT i.film_id, f.title, count(r.inventory_id) OVER (partition by f.title) AS NUMBER_OF_RENTALS
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY NUMBER_OF_RENTALS DESC;

#List the top five genres in gross revenue in descending order.

SELECT DISTINCT fc.category_id, c.name AS FILM_CATEGORY , count(r.inventory_id) OVER (partition by c.name) AS NUMBER_OF_RENTALS
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY NUMBER_OF_RENTALS DESC;
#THIS ARE THE TOP 5 MOST RENTED GENRES BUT I DONT KNOW WHERE TO GET THE REVENUE FROM

#Is "Academy Dinosaur" available for rent from Store 1?

SELECT DISTINCT i.inventory_id , i.store_id, f.title
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE f.title = "ACADEMY DINOSAUR" AND i.store_id = 1;
