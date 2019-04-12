-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

	SELECT title
	FROM sakila.film
	WHERE title LIKE "Q%"
		OR title LIKE "K%"
        AND title IN
		(SELECT title
		FROM sakila.film
		WHERE language_id IN
			(SELECT language_id
			FROM sakila.language
			WHERE name = "English"
		) 
 )       
;
-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name
FROM sakila.actor
WHERE actor_id IN
    (
    SELECT actor_id
	FROM sakila.film_actor
	WHERE film_id IN 
		(
		SELECT film_id
		FROM sakila.film 
		WHERE title = "Alone Trip"
		)
	)        
;

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 

SELECT first_name, last_name, email, country
FROM sakila.customer cu
	LEFT JOIN sakila.address a
		ON cu.address_id = a.address_id
	LEFT JOIN sakila.city ci
		ON a.city_id = ci.city_id
	LEFT JOIN sakila.country co
		ON ci.country_id = co.country_id
WHERE country = "Canada";

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT title, name
FROM sakila.film_text t
	JOIN sakila.film_category fc
		ON t.film_id = fc.film_id
	JOIN sakila.category c
		ON fc.category_id = c.category_id
WHERE name = "Family";

-- 7e. Display the most frequently rented movies in descending order.

SELECT  title, count(rental_id) as "# of rentals"
FROM sakila.rental r
	LEFT JOIN sakila.inventory i
		ON r.inventory_id = i.inventory_id
	LEFT JOIN sakila.film f
		ON i.film_id = f.film_id
GROUP BY title
ORDER BY count(rental_id) DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT store_id as "Store #", sum(amount) as "Revenue in $"
FROM sakila.inventory i
	 JOIN sakila.rental r
		ON i.inventory_id = r.inventory_id
	 JOIN sakila.payment p
		ON r.rental_id = p.rental_id
GROUP BY store_id;

-- 7g. Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country
FROM sakila.store s
	JOIN sakila.address a
		ON s.address_id = a.address_id
	JOIN sakila.city c
		ON a.city_id = c.city_id
	JOIN sakila.country co
		ON c.country_id = co.country_id;
        
-- 7h. List the top five genres in gross revenue in descending order. 

SELECT name, sum(amount) as total
FROM sakila.category c
	JOIN sakila.film_category fc
		ON c.category_id = fc.category_id
	JOIN sakila.inventory i
		ON fc.film_id = i.film_id
	JOIN sakila.rental r
		ON i.inventory_id = r.inventory_id
	JOIN sakila.payment p
		ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY total DESC
LIMIT 5
;