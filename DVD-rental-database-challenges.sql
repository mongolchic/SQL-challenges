-- Hint: use INTERSECT or OUTER JOIN
-- Which customer placed the orders on the earliest date? What did they order?
SELECT
	first_name, last_name, title, rental_id
FROM
	rentals r JOIN
	customers c ON (c.customer_id = r.customer_id) JOIN
	inventory i ON (i.inventory_id = r.inventory_id) JOIN
	films f ON (f.film_id = i.film_id)
ORDER BY
	rental_date
LIMIT 1

-- Which product do we have the most of? Find the order ids and customer names for all orders for that item.
--FIXME only returns one film, but should return all the films with the highest number of copies in inventory
SELECT rental_id, first_name, last_name, title

FROM
	rentals r JOIN
	customers c ON (c.customer_id = r.customer_id) JOIN
	inventory i ON (i.inventory_id = r.inventory_id) JOIN
	films f ON (f.film_id = i.film_id)
WHERE
	i.film_id IN (
		SELECT i.film_id
		FROM inventory i JOIN films f ON (i.film_id = f.film_id)
		GROUP BY i.film_id
		ORDER BY COUNT(inventory_id) DESC
		LIMIT 1)

-- What orders have there been from Texas? In June?
--
-- How many orders have we had for sci-fi films? From Texas?
--
-- Which actors have not appeared in a Sci-Fi film?
--
-- Find all customers who have not ordered a Sci-Fi film.
