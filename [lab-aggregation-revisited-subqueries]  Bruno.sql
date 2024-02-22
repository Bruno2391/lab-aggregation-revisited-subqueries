use sakila; 

select c.first_name, c.last_name, c.email
from customer c
join rental r using(customer_id);

select c.customer_id, CONCAT(c.first_name, ' ', c.last_name) as 'customer_name', avg (p.amount) as 'average_payment'
from customer c
join payment p using (customer_id)
group by c.customer_id, customer_name;

select concat(c.first_name, ' ', c.last_name) as 'customer_name', c.email, cat.name
from customer c
join rental r using (customer_id)
join inventory i using (inventory_id)
join film f using (film_id)
join film_category fc using (film_id)
join category cat using (category_id)
where cat.name = 'Action'
group by customer_name, c.email, cat.name;

select concat(c.first_name, ' ',c.last_name) as 'customer_name, email'
from customer c
where customer_id in (
    SELECT r.customer_id
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
                    where name = 'Action'
                    group by c.email
                )
            )
        )
    )
);


select customer_id, amount,
    case
        when amount between 0 and 2 then 'Low'
        when amount between 2 and 4 then 'Medium'
        when amount > 4 then 'High'
    end as 'classification'
from payment;

