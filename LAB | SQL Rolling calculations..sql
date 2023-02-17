#LAB | SQL Rolling calculations.- ARA

#1.Get number of monthly active customers:alter

SELECT COUNT(DISTINCT(customer_id)) AS active_customers, DATE_FORMAT(payment_date, '%Y-%m') AS month
FROM payment
GROUP BY DATE_FORMAT(payment_date, '%Y-%m');

SELECT COUNT(DISTINCT customer_id) AS monthly_active_customers, YEAR(payment_date) AS year, MONTH(payment_date) AS month
FROM payment
GROUP BY year, month;

#2. Active users in the previous month:

SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       COUNT(DISTINCT customer_id) AS active_customers
FROM payment
WHERE DATE_FORMAT(payment_date, '%Y-%m') = DATE_FORMAT((CURDATE() - INTERVAL 1 MONTH), '%Y-%m')
GROUP BY month;

SELECT COUNT(DISTINCT customer_id) AS active_customers_previous_month
FROM payment
WHERE YEAR(payment_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
AND MONTH(payment_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH);


#3. Percentage change in the number of active customers.


SELECT CONCAT(ROUND(((current_month_customers - previous_month_customers) / previous_month_customers) * 100), '%') AS customer_change_percent
FROM 
    (SELECT COUNT(DISTINCT customer_id) AS previous_month_customers
    FROM payment
    WHERE YEAR(payment_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
    AND MONTH(payment_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)) AS previous,
    (SELECT COUNT(DISTINCT customer_id) AS current_month_customers
    FROM payment
    WHERE YEAR(payment_date) = YEAR(CURRENT_DATE)
    AND MONTH(payment_date) = MONTH(CURRENT_DATE)) AS current;


#4.Retained customers every month.

SELECT COUNT(DISTINCT customer_id) AS retained_customers, YEAR(payment_date) AS year, MONTH(payment_date) AS month
FROM payment
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE YEAR(payment_date) = YEAR(payment_date - INTERVAL 1 MONTH)
    AND MONTH(payment_date) = MONTH(payment_date - INTERVAL 1 MONTH)
)
GROUP BY year, month;





