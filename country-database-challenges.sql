-- What languages are spoken in the 20 poorest (GNP/ capita) countries in the world?
--Hint: Use DISTINCT to remove duplicates
SELECT
	DISTINCT(cl.language)
FROM
	countries c JOIN
	countrylanguages cl ON (c.code = cl.countrycode)
WHERE
	c.code IN (SELECT code
	       	   FROM countries
	       	   WHERE population > 0
	       	   ORDER BY gnp/population ASC
	       	   LIMIT 20)

-- Which languages are spoken in the ten largest (area) countries?
SELECT
  DISTINCT(cl.language)
FROM
  countries c JOIN
  countrylanguages cl ON (c.code = cl.countrycode)
WHERE
  c.code IN (SELECT code
             FROM countries
             ORDER BY surfacearea DESC
             LIMIT 10)



-- What is the total population of cities where English is the offical language? Spanish?
-- Hint: The official language of a city is based on country.
SELECT
	SUM(ct.population)

FROM
	countrylanguages cl JOIN
	cities ct ON (ct.countrycode = cl.countrycode)
WHERE

	language = 'English' AND
	cl.countrycode IN (SELECT countrycode
	       	   FROM countrylanguages
	       	   WHERE isofficial = true
	       	   AND language = 'English')

-- Are there any countries without an official language?
-- FIXME: remove unnecessary joining of cities table
SELECT
	DISTINCT(c.name)

FROM
	countrylanguages cl JOIN
	cities ct ON (ct.countrycode = cl.countrycode) JOIN
	countries c ON (ct.countrycode = c.code)
WHERE

	cl.countrycode NOT IN (SELECT countrycode
	       	   FROM countrylanguages
	       	   WHERE isofficial = true )

ORDER BY c.name
-- What are the cities in the countries with no official language?
SELECT
	DISTINCT(ct.name)

FROM
	countrylanguages cl JOIN
	cities ct ON (ct.countrycode = cl.countrycode) JOIN
	countries c ON (ct.countrycode = c.code)
WHERE

	cl.countrycode NOT IN (SELECT countrycode
	       	   FROM countrylanguages
	       	   WHERE isofficial = true )

ORDER BY
	ct.name

-- How many countries have no cities?
SELECT
	count(countries)
FROM
	countries
WHERE
	code NOT IN (SELECT countrycode FROM cities)

-- Which countries have the 100 biggest cities in the world?
SELECT
	name
FROM
	countries
WHERE
	code IN (
		SELECT countrycode
		FROM cities
		ORDER BY population DESC
		LIMIT 100)

-- What languages are spoken in the countries with the 100 biggest cities in the world?
SELECT
	language
FROM
	countrylanguages
WHERE
	countrycode IN (
		SELECT countrycode
		FROM cities
		ORDER BY population DESC
		LIMIT 100)

-- Which country or contries speak the most languages?
SELECT
	c.name, COUNT(cl.language)
FROM
	countrylanguages cl JOIN
	countries c ON (c.code = cl.countrycode)
GROUP BY
	c.name
ORDER BY
	count DESC

-- Which country or contries have the most offficial languages?
SELECT
	c.name, COUNT(cl.language)
FROM
	countrylanguages cl JOIN
	countries c ON (c.code = cl.countrycode)
WHERE
	isofficial = true
GROUP BY
	c.name
ORDER BY
	count DESC

-- Which countries have the highest proportion of official language speakers? The lowest?
SELECT
	c.name, sum(cl.percentage)
FROM
	countrylanguages cl JOIN
	countries c ON (c.code = cl.countrycode)
WHERE
	isofficial = true
GROUP BY
	c.name
ORDER BY
	sum DESC
