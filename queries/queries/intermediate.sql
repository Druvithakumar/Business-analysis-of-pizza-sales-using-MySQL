use Dominos;

-- Join the necessary tables to find the
-- total quantities of each pizza categorie.

SELECT 
    pizza_types_clean.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types_clean
        JOIN
    pizzas ON pizza_types_clean.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types_clean.category
ORDER BY quantity DESC;

-- Determine the distribution of order by hour of the day.
Select hour(order_time) as hour,
count(order_id) as order_count
from  orders
group by hour(order_time);

-- Join relevant tables to find the 
-- categories wise distribution of pizza.
SELECT 
    category, COUNT(name)
FROM
    pizza_types_clean
GROUP BY category;

-- Group the orders by date and calculate the average 
-- number of pizza ordered per day.
SELECT 
    ROUND(AVG(quantity), 0)
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types_clean.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types_clean join pizzas
on pizza_types_clean.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types_clean.name  order by revenue desc limit 3;


