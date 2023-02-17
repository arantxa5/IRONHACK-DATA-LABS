#LAB | SQL Advanced queries- ARA

#1. List each pair of actors that have worked together.
USE sakila;

SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
       CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id < a2.actor_id;

#2. For each film, list actor that has acted in more films.

SELECT 
    f.title, 
    CONCAT(a.first_name, ' ', a.last_name) AS actor, 
    COUNT(*) AS film_count
FROM 
    film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY 
    f.film_id, a.actor_id
HAVING 
    COUNT(*) = (
        SELECT 
            COUNT(*)
        FROM 
            film f2
            JOIN film_actor fa2 ON f2.film_id = fa2.film_id
        WHERE 
            fa.actor_id = fa2.actor_id
        GROUP BY 
            fa2.actor_id
        ORDER BY 
            COUNT(*) DESC
        LIMIT 1
    );
    #ESTÁ MARCANDO ERROR :(


