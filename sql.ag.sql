-- Select the first name, last name, and email address of all the customers who have rented a movie.

select c.first_name, c.last_name, c.email
from customer c
join rental r on c.customer_id = r.customer_id
order by c.last_name, c.first_name;
    
    -- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
    
select c.customer_id,
concat(c.first_name, ' ', c.last_name) as customer_name,
avg(p.amount) as average_payment
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, customer_name
order by c.customer_id;

    -- Select the name and email address of all the customers who have rented the "Action" movies.

-- Write the query using multiple join statements
-- Write the query using sub queries with multiple WHERE clause and IN condition
-- Verify if the above two queries produce the same results or not

select concat(c.first_name, ' ', c.last_name) as customer_name, c.email
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category cat on fc.category_id = cat.category_id
where cat.name = 'Action';
    
    select concat(c.first_name, ' ', c.last_name) as customer_name, c.email
from customer c
where c.customer_id in (
        select r.customer_id
        from rental r
        where r.inventory_id in (
                select i.inventory_id
                from inventory i
                where i.film_id in (
                         select f.film_id
                         from film f
                        where f.film_id in (
                                select film_id
                                from film_category
                                where category_id in (
                                        select category_id
                                        from category
                                        where
                                            name = 'Action'
                                    )))));
               
   
   -- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
   
   select payment_id, amount,
    case
        when amount >= 0 and amount <= 2 then 'low'
        when amount > 2 and amount <= 4 then 'medium'
        when amount > 4 then 'high'
        else 'unknown'  
    end as payment_category
from payment;