-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- Calculate the total revenue generation from pizza sales
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- Identify the highest-priced size order.
SELECT 
    pizza_types_clean.name, pizzas.price
FROM
    pizza_types_clean
        JOIN
    pizzas ON pizza_types_clean.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza ordered.
SELECT 
    quantity, COUNT(order_details_id) AS common_size
FROM
    order_details
GROUP BY quantity;

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- List the top 5 most ordered pizza types
-- along with their quantities.

SELECT 
    pizza_types_clean.name,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types_clean
        JOIN
    pizzas ON pizza_types_clean.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types_clean.name
ORDER BY quantity DESC
LIMIT 5;



