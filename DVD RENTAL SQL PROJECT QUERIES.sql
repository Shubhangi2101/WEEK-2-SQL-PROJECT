-- 1.Show all Film Titles with correspnding Category(GENRE)
 
SELECT film.film_id,film. title,category.name, film.description 
FROM film
FULL OUTER JOIN film_category
ON film.film_id = film_category.film_id
FULL JOIN category
ON film_category.category_id= category.category_id

-- 2.Show all film in COMEDY genre (using JOIN and WHERE clause)

SELECT film.film_id,film. title,category.name, film.description 
FROM film
FULL OUTER JOIN film_category
ON film.film_id = film_category.film_id
FULL JOIN category
ON film_category.category_id= category.category_id
WHERE category.name = 'Comedy';

-- 3.find how many inventory of movie 'Blackout Private' is available at each store (using GROUP BY)

Select count(inventory.store_id),inventory.store_id,inventory.film_id, film.title, film.description 
from inventory 
full outer join film on inventory.film_id=film.film_id
where film.title LIKE '%Blackout%'
group by inventory.store_id,inventory.film_id, film.title, film.description;

-- 4.find the count of unique customers at each store (using COUNT() and DISTINCT)

SELECT COUNT(*) as CUST_COUNT FROM 
(select DISTINCT concat(first_name,' ', last_name) as FULL_NAME FROM CUSTOMER WHERE STORE_ID=1) AS CustCountAtStore1;

SELECT COUNT(*) as CUST_COUNT FROM 
(select DISTINCT concat(first_name,' ', last_name) as FULL_NAME FROM CUSTOMER WHERE STORE_ID=2) AS CustCountAtStore2;


-- 5. Find Customer full name and email id who have rented DVDs for more than 5 days. (using JOIN and AGE())
select r.rental_id, c.email, concat(c.first_name,' ',c.last_name) as CUST_FULLNAME from rental r
join customer c
on r.customer_id=c.customer_id where AGE(r.return_date, r.rental_date) >'5 days'


-- 6.Find top three customers (full name) who spend the most (using concat(), aggregate functions)

select concat(first_name,' ',Last_name) as FULLNAME from customer where customer_id IN (	
select customer_id FROM
(
select customer_id, sum(amount) as totalMoneySpentbyaCust from payment 
group by customer_id
order by totalMoneySpentbyaCust DESC
LIMIT 3) Derived_table
	)


-- 7. Find the actor name who has done the most number of movies (using LIMIT())

select concat(first_name,' ',last_name) as FULL_NAME_ACTOR from actor where actor_id = 
(select actor_id from
(select actor_id, count(actor_id) as NoOfMOviesDone from film_actor
group by actor_id
order by NoOfMOviesDone DESC
LIMIT 1) derived_table)

-- 8. Display average rental rate corresponding to each rental rate in film table(using Window())

select payment_id, 
       customer_id, 
	   staff_id, 
	   rental_id, 
	   amount, 
	   avg(amount) OVER() AS Average_Rental_Rate
from payment;

-- 9. Display count of times each customer has rented a DVD (using CTE)

WITH customer_renting AS(
	select rental_id, customer_id from rental
group by rental_id, customer_id
order by customer_id ASC)
select customer_id, count(customer_id) as Occurances_of_Customer from customer_renting
group by customer_id
order by Occurances_of_Customer 

--10. Display text message for customers who have rented DVD for more than 7 days (using CASE)

WITH duration_of_Rental AS(
select rental_id, customer_id, AGE(return_date, rental_date) as NO_OF_DAYS_RENTED from rental)
Select customer_id, NO_OF_DAYS_RENTED,
CASE WHEN NO_OF_DAYS_RENTED>='7 DAYS' THEN 'SEND CUSTOMER A REMINDER MAIL TO RETURN DVD'
ELSE 'NO NEED FOR REMINDER MAIL YET'
END
FROM duration_of_Rental




 






