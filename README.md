DVD RENTAL SQL PROJECT 

![dvd rental](https://github.com/Shubhangi2101/WEEK-2-SQL-PROJECT/assets/46973898/fc783078-0fdc-483f-b1a3-97187f1c70cd)

This SQL project dataset consists of several tables that capture various aspec
ts of a DVD rental system. The tables include film, category, film category, film actor, actor, language, customer, address, city, country, payment, rental, store, inventory, and staff. The dataset provides a comprehensive set of data for analysis and insights. The project involves performing several analysis tasks using SQL queries. 
The SQL project dataset offers an opportunity to analyze customer rental behavior, identify high-spending customers, track actor movie counts, and explore films in specific genres. These queries provide valuable insights into the rental business, customer preferences, and the performance of actors and films in the dataset. Entity Relationship diagram is shown below:
![Screenshot 2023-06-29 160634](https://github.com/Shubhangi2101/WEEK-2-SQL-PROJECT/assets/46973898/a85292db-ee41-4af0-b008-fd2bebde4e20)




DATABASE USED FOR THIS ANALYSIS:  POSTGRES 15
The analysis has been performed using various basic queries involving comparison operators, logical operators, wildcard characters, clauses like WHERE, LIMIT, GROUP BY, ORDER BY and few complex queries using subquery, window (), CTE, CASE. 
There is total 10 queries performed out of which two are listed and explained below: -
1. select concat(first_name,' ',Last_name) as FULLNAME from customer where customer_id IN (	
select customer_id FROM
(
select customer_id, sum(amount) as totalMoneySpentbyaCust from payment 
group by customer_id
order by totalMoneySpentbyaCust DESC
LIMIT 3) Derived_table
	)

The given SQL query retrieves the full name of the top three customers who have spent the most money in the payment table. Let's break down the query and understand its components:
The outer query starts with the SELECT statement, where `CONCAT(first_name, ' ', last_name) AS FULLNAME` is used to concatenate the first name and last name columns of the customer table, creating a new column named FULLNAME.
The FROM clause specifies the table name as "customer," indicating that the query will operate on the customer table.
The WHERE clause filters the rows based on the condition `customer_id IN (...)`, which checks if the customer_id is present in the subquery's result set.
The subquery within the parentheses is used to retrieve the top three customers with the highest total money spent. It begins with the SELECT statement, selecting the customer_id and calculating the sum of the amount spent by each customer using the SUM() function. The result is aliased as "totalMoneySpentbyaCust."
The subquery also includes the GROUP BY clause to group the results by customer_id and the ORDER BY clause to sort the results in descending order of the total money spent. The LIMIT clause ensures that only the top three rows are selected.

![query 1 result](https://github.com/Shubhangi2101/WEEK-2-SQL-PROJECT/assets/46973898/709adafd-e401-495e-9f42-2da327f4b3f8)


2. WITH duration_of_Rental AS(
select rental_id, customer_id, AGE(return_date, rental_date) as NO_OF_DAYS_RENTED from rental)
Select customer_id, NO_OF_DAYS_RENTED,
CASE WHEN NO_OF_DAYS_RENTED>='7 DAYS' THEN 'SEND CUSTOMER A REMINDER MAIL TO RETURN DVD'
ELSE 'NO NEED FOR REMINDER MAIL YET'
END
FROM duration_of_Rental

The given SQL query calculates the duration of rental for each customer and categorizes it based on a threshold of 7 days. Here's a summary of the query:
The query begins with a Common Table Expression (CTE) named "duration_of_Rental." It selects the rental_id, customer_id, and uses the `AGE()` function to calculate the number of days rented by subtracting the rental_date from the return_date.
The main query then selects the customer_id and NO_OF_DAYS_RENTED columns from the "duration_of_Rental" CTE.
The query includes a CASE statement to categorize the rental duration. If the NO_OF_DAYS_RENTED is greater than or equal to 7 days, it returns the string 'SEND CUSTOMER A REMINDER MAIL TO RETURN DVD.' Otherwise, it returns 'NO NEED FOR REMINDER MAIL YET.' This CASE statement allows for conditional logic based on the duration of the rental.
The final result set includes the customer_id, NO_OF_DAYS_RENTED, and the categorization of whether a reminder mail should be sent to the customer or not.
In summary, the query calculates the rental duration for each customer and provides a categorization based on the duration threshold of 7 days. It determines whether a reminder mail should be sent to the customer based on the number of days rented and presents the results accordingly.


![query 2 result](https://github.com/Shubhangi2101/WEEK-2-SQL-PROJECT/assets/46973898/c27d5e96-20c4-4e1d-8cca-67ed32efe150)

Resources:
https://www.postgresqltutorial.com/wp-content/uploads/2018/03/printable-postgresql-sample-database-diagram.pdf
Dataset 
https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/
https://www.w3schools.com/sql/default.asp





 

