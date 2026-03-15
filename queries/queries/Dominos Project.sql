CREATE database Dominos;
use Dominos;

Create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));

Create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id varchar(50),
quantity int not null,
primary key(order_details_id));