-- Calculate the percentage contribution of each
-- pizza types to total revenue.

SELECT pizza_types_clean.category,
   round(SUM(order_details.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS total_sales
        FROM
            order_details
                JOIN
            pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,2) as revenue
FROM
    pizza_types_clean
        JOIN
    pizzas ON pizza_types_clean.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types_clean.category
ORDER BY revenue DESC;

-- Analyse the cumulative revenue generated over time.
select order_date,
sum(revenue) over(order by order_date) as cum_revenue
from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on  order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;


-- Determine the top 3 most ordered pizza types
-- based on revenue for each pizza category.
select name, revenue from 
(select category,
       name,
       revenue,
rank() over(partition by category
            order by revenue desc) as rn
from
(select pizza_types_clean.category, pizza_types_clean.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types_clean join pizzas
on pizza_types_clean.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types_clean.category, pizza_types_clean.name) as a) as b
where rn <= 3;

-- What is the total revenue and number of orders?
select 
sum (quantity * price) as total_revenue,
count(distinct order_id) as total_orders
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id






















