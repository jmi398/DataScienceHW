USE sakila;

-- 1a. Display the first and last names of all actors from the table actor.
select first_name, last_name from actor limit 10;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. 
-- Name the column Actor Name.
select concat(first_name, ' ', last_name) as 'Actor Name'
from actor limit 10;

select * from actor limit 10;

-- 2a. You need to find the ID number, first name, and last name of an actor, 
-- of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select first_name, last_name, actor_id from actor where first_name = "Joe"; 

-- 2b. Find all actors whose last name contain the letters GEN:
select first_name, last_name from actor where last_name LIKE '%GEN%'; 

-- 2c. Find all actors whose last names contain the letters LI. 
-- This time, order the rows by last name and first name, in that order:
select last_name, first_name from actor where last_name like '%LI%';

-- 2d. Using IN, display the country_id and country columns of the following countries: 
-- Afghanistan, Bangladesh, and China:
Select country, country_id from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Add a middle_name column to the table actor. 
-- Position it between first_name and last_name. Hint: you will need to specify the data type.
ALTER TABLE actor ADD middle_name VARCHAR(50) AFTER first_name;

-- 3b. You realize that some of these actors have tremendously long last names. 
-- Change the data type of the middle_name column to blobs.
ALTER TABLE actor Modify COLUMN middle_name blob; 

-- 3c. Now delete the middle_name column.
ALTER TABLE actor DROP COLUMN middle_name; 

-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(last_name) as num_last_name from actor GROUP BY last_name; 

-- 4b. List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors
select last_name, count(last_name) as num_last_name from actor 
GROUP BY last_name
having count(last_name)  >= 2;

-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, 
-- the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
UPDATE actor SET first_name = 'HARPO' where first_name = 'GROUCHO' and last_name ='WILLIAMS';

-- 4d.In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. 
-- Otherwise, change the first name to MUCHO GROUCHO, 
-- as that is exactly what the actor will be with the grievous error. 
UPDATE actor SET first_name = IF (first_name = 'HARPO',  'GROUCHO',  'MUCHO GROUCHO')
WHERE first_name = 'HARPO' and last_name = 'WILLIAMS';
select * from actor;

-- 5a. You cannot locate the schema of the address table. 
-- Which query would you use to re-create it?
show create table address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. 
-- Use the tables staff and address:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON staff.address_id=address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. 
-- Use tables staff and payment.
SELECT staff.first_name, sum(payment.amount) as 'total amount' from staff
JOIN payment  ON  staff.staff_id=payment.staff_id 
where payment.payment_date LIKE '2005-08%' Group by staff.first_name;

-- 6c. List each film and the number of actors who are listed for that film. 
-- Use tables film_actor and film. Use inner join.
select* from film;
select * from film_actor;
SELECT film.title, count(film_actor.actor_id) as 'Number of actors' 
from film 
INNER JOIN film_actor ON film.film_id=film_actor.film_id GROUP BY film.title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select * from inventory;
select * from film;
select  film.title, count(inventory.film_id) as 'Copies of the film Hunchback Impossible' 
from inventory JOIN film ON film.film_id = inventory.film_id
where inventory.film_id = '439' GROUP BY film.title;



-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name:
select * from payment;
select * from customer;
SELECT customer.last_name, sum(payment.amount)  from payment
JOIN customer ON payment.customer_id=customer.customer_id GROUP BY customer.last_name
ORDER BY customer.last_name;

-- 7a. Use subqueries to display the titles of movies starting with the letters 
-- K and Q whose language is English.
show tables;
select title,  language_id from film
where title LIKE "K%" OR title LIKE "Q%" and language_id = "1";


-- 7b. Use subqueries to display all actors who appear in the film Alone Trip
select first_name, last_name from actor where actor_id in (
select actor_id from film_actor where film_id in
(select film_id from film where title = "Alone Trip")); 

-- 7c. You want to run an email marketing campaign in Canada, 
-- for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.

SELECT first_name, last_name, email from customer where address_id in(
select address_id from address where city_id in (
select  city_id from city where  country_id in (
select country_id from country where country = "Canada")));

-- 7d. Sales have been lagging among young families, 
-- and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.

SELECT title from film where film_id in (
select film_id from film_category where category_id in (
select category_id from category where name = "Family"));

-- 7e. Display the most frequently rented movies in descending order. * Check with Seth
select * from film;
select * from rental;
select * from inventory;
 
 SELECT  film.title, count(rental.rental_id) as 'Number of times the movie was rented'FROM rental 
JOIN inventory ON rental.inventory_id= inventory.inventory_id 
JOIN film ON film.film_id =  inventory.film_id GROUP BY film.title
ORDER BY count(rental.rental_id)  DESC;
 
-- 7f. Write a query to display how much business, in dollars, each store brought in.* Check with Seth

SELECT store.store_id, sum(payment.amount) as 'Business in dollars' from payment
JOIN store ON store.manager_staff_id=payment.staff_id GROUP BY store.store_id
ORDER BY sum(payment.amount);

-- 7g. Write a query to display for each store its store ID, city, and country.
show tables;
select * from country;
select * from city;
select * from address;
select * from store;

SELECT  store.store_id, country.country, city.city FROM country 
JOIN city ON country.country_id=city.country_id 
JOIN address ON address.city_id=city.city_id  JOIN store
ON store.address_id=address.address_id GROUP BY store.store_id;

-- 7h. List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: 

SELECT category.name, sum(payment.amount) as 'gross revenue' FROM payment
JOIN rental ON rental.rental_id = payment.rental_id 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON film_category.film_id = inventory.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name ORDER BY sum(payment.amount) DESC limit 5;

-- 8a.Use the solution from the problem above to create a view.
CREATE VIEW Top_Five_Genres_By_Gross_Revenue AS 
SELECT category.name, sum(payment.amount) as 'gross revenue' FROM payment
JOIN rental ON rental.rental_id = payment.rental_id 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON film_category.film_id = inventory.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name ORDER BY sum(payment.amount) DESC limit 5;

-- 8b. How would you display the view that you created in 8a?
select * from Top_Five_Genres_By_Gross_Revenue;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW Top_Five_Genres_By_Gross_Revenue;