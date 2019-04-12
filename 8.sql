-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue.
CREATE VIEW `Top five genres by gross revenue` AS
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
LIMIT 5;

-- 8b. How would you display the view that you created in 8a?

SELECT *
FROM `Top five genres by gross revenue`;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

DROP VIEW `Top five genres by gross revenue`;

