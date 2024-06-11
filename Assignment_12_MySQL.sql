CREATE DATABASE IF NOT EXISTS pizza_restaurant;
USE pizza_restaurant;

create table IF NOT EXISTS `customer` (
	`customer_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`customer_id`)
);

create table IF NOT EXISTS `order` (
	`order_id` INT NOT NULL AUTO_INCREMENT,
    `customer_id` INT NOT NULL,
    `date` datetime NOT NULL,
	PRIMARY KEY (`order_id`),
    FOREIGN KEY (`customer_id`) references customer (customer_id)
);

create table IF NOT EXISTS `pizza` (
	`pizza_id` INT NOT NULL AUTO_INCREMENT,
    `pizza_name` VARCHAR(50) NOT NULL,
    `price` DECIMAL(2, 2) NOT NULL,
    PRIMARY KEY (`pizza_id`)
);

create table IF NOT EXISTS `pizza_order` (
	`pizza_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    `amount` INT NOT NULL, 
	FOREIGN KEY (`pizza_id`) references pizza (pizza_id),
    FOREIGN KEY (`order_id`) references `order` (order_id)
);

-- add customer data
INSERT INTO `customer` (`name`, `phone_number`)
values 
	('Trevor Page', '226-555-4982'), 
    ('John Doe', '555-555-9498');

select * from customer;

alter table `pizza`
MODIFY 	`price` DECIMAL(4,2) NOT NULL;

-- add pizza data
INSERT INTO `pizza` (`pizza_name`, `price`)
values 
	('Pepperoni & Cheese', 7.99),
	('Vegetarian', 9.99),
	('Meat Lovers', 14.99),
	('Hawaiian', 12.99);
    
select * from pizza;

-- add order data
INSERT INTO `order` (customer_id, date)
values 
	(1, '2023-09-10 9:47:00'),
    (2, '2023-09-10 13:20:00'),
    (1, '2023-09-10 9:47:00'),
    (2, '2023-10-10 10:37:00');
    
select * from `order`;

-- add individual pizza order data (many-to-many)
INSERT INTO `pizza_order` (pizza_id, order_id, amount)
values 
	(1, 1, 1),
    (1, 3, 1),
    (2, 2, 1),
    (2, 3, 2),
    (3, 3, 1),
    (3, 4, 1),
    (4, 2, 3),
    (4, 4, 1);
    
select * from pizza_order;

-- Sum how much each customer spent total (descending order by price)
select c.customer_id, c.name, sum(po.amount * p.price) AS total_price
	FROM customer c 
    JOIN `order` o ON c.customer_id = o.customer_id
    JOIN pizza_order po ON o.order_id = po.order_id
    JOIN pizza p ON po.pizza_id = p.pizza_id
    GROUP BY c.customer_id, c.name
    ORDER BY total_price DESC;
    
    
    
-- separate the orders by customer AND date (descending order by price)
select c.customer_id, c.name, o.date, sum(po.amount * p.price) AS total_price
	FROM customer c
    JOIN `order` o ON c.customer_id = o.customer_id
    JOIN pizza_order po ON o.order_id = po.order_id
    JOIN pizza p ON po.pizza_id = p.pizza_id
    GROUP BY c.customer_id, c.name, o.date
    ORDER BY total_price DESC;


    

    

