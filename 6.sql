-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT first_name, last_name, address
FROM sakila.staff s
	JOIN sakila.address a
		ON s.address_id = a.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT staff_id, first_name, last_name ,sum(amount)
FROM
(
SELECT p.staff_id, first_name, last_name ,amount, payment_date
FROM sakila.payment p
	JOIN sakila.staff s
		ON p.staff_id = s.staff_id 
WHERE payment_date like '2005%'
) as staff_payment_table
GROUP BY staff_id;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

SELECT DISTINCT title, count(actor_id) as "# of actors"
FROM sakila.film_actor a
	JOIN sakila.film f
		ON a.film_id = f.film_id
GROUP BY title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT DISTINCT title, count(inventory_id) as '# of copies'
FROM sakila.inventory i
	JOIN sakila.film f
		ON i.film_id = f.film_id
GROUP BY title
HAVING title = "Hunchback Impossible";

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

SELECT first_name, last_name, sum(amount)
FROM
(
SELECT c.customer_id, first_name, last_name, amount
FROM sakila.customer c
	JOIN sakila.payment p
		ON c.customer_id = p.customer_id 
) as payment_customer_table
GROUP BY first_name, last_name
ORDER BY last_name ASC;
