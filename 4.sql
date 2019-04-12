-- 4a. List the last names of actors, as well as how many actors have that last name.

SELECT DISTINCT last_name, count(last_name) 
FROM sakila.actor
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, lastNameCount
FROM 
(
SELECT DISTINCT last_name, count(last_name) as lastNameCount
FROM sakila.actor
GROUP BY last_name
) as Groupedtable
WHERE lastNameCount > 1;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.

UPDATE sakila.actor
SET first_name='HARPO'
WHERE first_name ='GROUCHO' AND last_name = "WILLIAMS";

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
SET SQL_SAFE_UPDATES=0;

UPDATE sakila.actor
SET first_name='GROUCHO'
WHERE first_name ='HARPO';