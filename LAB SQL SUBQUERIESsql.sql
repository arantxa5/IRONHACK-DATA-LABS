#LAB SQL SUBQUERIES ARA;

#1. ¿Cuántas copias de la película "Hunchback Impossible" existen en el sistema de inventario?
SELECT COUNT(*) AS 'Total copies'
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

# 2.Lista todas las películas cuya duración es mayor que el promedio de todas las películas.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

#3. Usa subconsultas para mostrar a todos los actores que aparecen en la película "Alone Trip".

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));

#4.Las ventas han estado rezagadas entre las familias jóvenes, y deseas dirigir todas las películas familiares para una promoción. 
#Identifica todas las películas categorizadas como películas familiares.

SELECT title
FROM film
WHERE rating = 'G' OR rating = 'PG';

#5. Obtener nombre y correo electrónico de clientes de Canadá utilizando subconsultas. Hacer lo mismo con joins. Nota que para crear un join, 
#tendrás que identificar las tablas correctas con sus claves primarias y claves foráneas, que te ayudarán a obtener la información relevante.

#Con subconsultas:

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id 
FROM address WHERE city_id IN (SELECT city_id FROM city WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')));

#Con joins:

SELECT first_name, last_name, email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';

#6. ¿Cuáles son las películas protagonizadas por el actor más prolífico? El actor más prolífico se define como el actor que ha actuado 
#en la mayor cantidad de películas. Primero tendrás que encontrar al actor más prolífico y luego usar ese actor_id para encontrar 
#las diferentes películas en las que actuó.

SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_actor WHERE actor_id = (SELECT actor_id FROM (SELECT actor_id, COUNT(*) AS film_count FROM film_actor GROUP BY actor_id ORDER BY film_count DESC LIMIT 1) AS most_prolific_actor));


#7.Películas alquiladas por el cliente más rentable. Puedes usar la tabla de clientes y la tabla de pagos para encontrar al cliente 
#más rentable, es decir, el cliente que ha realizado la suma más grande de pagos.

SELECT title
FROM film
WHERE film_id IN (SELECT rental.film_id FROM rental JOIN payment ON rental.rental_id = payment.rental_id 
GROUP BY rental.film_id ORDER BY SUM(payment.amount) DESC LIMIT 1);


#8.Obtener el client_id y el total_amount_spent de aquellos clientes que gastaron más que el promedio del total_amount gastado por cada cliente.

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
WHERE customer_id IN (SELECT customer_id FROM payment GROUP BY customer_id HAVING AVG(amount
