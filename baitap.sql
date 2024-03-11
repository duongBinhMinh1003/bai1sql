CREATE DATABASE node40;
use node40;
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100),
    email VARCHAR(100),
    PASSWORD VARCHAR(100)
) CREATE TABLE restaurant(
    res_id INT PRIMARY KEY AUTO_INCREMENT,
    res_name VARCHAR(100),
    image VARCHAR(100),
    desc1 VARCHAR(100)
) CREATE TABLE rate_res (
    user_id INT,
    res_id INT,
    amount INT,
    date_rate DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
) CREATE TABLE user_in_res (
    user_id INT,
    res_id INT,
    full_name VARCHAR(100),
    PASSWORD VARCHAR(100),
    image VARCHAR(100),
    PRIMARY KEY (user_id, res_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
) CREATE TABLE food_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(100),
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES food(food_id)
) CREATE TABLE user_food (
    user_id INT,
    food_id INT,
    PRIMARY KEY(user_id, food_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY(food_id) REFERENCES food(food_id)
) CREATE TABLE food (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    food_name VARCHAR(100),
    image VARCHAR(100),
    price FLOAT,
    desc1 VARCHAR(50),
    type_id INT,
    sub_id INT,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id),
    FOREIGN KEY (sub_id) REFERENCES sub_food(sub_id)
) DROP TABLE food CREATE TABLE orders (
    user_id INT,
    food_id INT,
    amount INT,
    code VARCHAR(100),
    arr_sub_id VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);
CREATE TABLE sub_food (
    sub_id INT PRIMARY KEY AUTO_INCREMENT,
    sub_name VARCHAR(100),
    sub_price FLOAT,
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES orders(food_id)
)
/*bai 1*/
SELECT user.user_id, user.fullname, COUNT(rate_res.res_id) AS total_likes
FROM user
JOIN rate_res ON user.user_id = rate_res.user_id
GROUP BY user.user_id, user.fullname
ORDER BY total_likes DESC
LIMIT 5;
/*bai 2*/
SELECT restaurant.res_id, restaurant.res_name, COUNT(rate_res.res_id) AS total_likes
FROM restaurant
LEFT JOIN rate_res ON restaurant.res_id = rate_res.res_id
GROUP BY restaurant.res_id, restaurant.res_name
ORDER BY total_likes DESC
LIMIT 2;
/*bai 3*/
SELECT user.user_id, user.fullname, COUNT(orders.user_id) AS total_orders
FROM user
JOIN orders ON user.user_id = orders.user_id
GROUP BY user.user_id, user.fullname
ORDER BY total_orders DESC
LIMIT 1;
/*bai 4*/

SELECT user.user_id, user.fullname
FROM user
LEFT JOIN orders ON user.user_id = orders.user_id
LEFT JOIN rate_res ON user.user_id = rate_res.user_id
LEFT JOIN user_in_res ON user.user_id = user_in_res.user_id
WHERE orders.user_id IS NULL AND rate_res.user_id IS NULL AND user_in_res.user_id IS NULL;


