#LAB 2.9

#In this lab we will find the customers who were active in consecutive months of May and June. Follow the steps to complete the analysis.

#Create a table rentals_may to store the data from rental table with information for the month of May.

USE sakila;

CREATE TABLE rentals_may AS
SELECT *
FROM rental
WHERE MONTH(rental_date) = 5 AND YEAR(rental_date) = 2005;

#Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
SELECT * FROM rentals_may;
#Create a table rentals_june to store the data from rental table with information for the month of June.
CREATE TABLE rentals_june AS
SELECT *
FROM rental
WHERE MONTH(rental_date) = 6 AND YEAR(rental_date) = 2005;

#Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
SELECT * FROM rentals_june;
#Check the number of rentals for each customer for May.

SELECT DISTINCT customer_id, count(rental_id) over (partition by customer_id) as Rentals_per_customer
FROM rental
WHERE MONTH(rental_date) = 5 AND YEAR(rental_date) = 2005
ORDER BY Rentals_per_customer desc;

#Check the number of rentals for each customer for June.

SELECT DISTINCT customer_id, count(rental_id) over (partition by customer_id) as Rentals_per_customer
FROM rental
WHERE MONTH(rental_date) = 6 AND YEAR(rental_date) = 2005
ORDER BY Rentals_per_customer desc;

#Create a Python connection with SQL database and retrieve the results of the last two queries (also mentioned below) as dataframes:

#Check the number of rentals for each customer for May

#Check the number of rentals for each customer for June

#Hint: You can store the results from the two queries in two separate dataframes.

#Write a function that checks if customer borrowed more or less films in the month of June as compared to May.

#Hint: For this part, you can create a join between the two dataframes created before, using the merge function available 
#for pandas dataframes. Here is a link to the documentation for the merge function.