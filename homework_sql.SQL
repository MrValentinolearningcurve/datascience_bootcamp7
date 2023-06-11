-- restaurant database

-- 5 tables
-- write 3-5 queries
-- 1x WTIH
-- 1x SUBQUERY
-- 1x Aggregate Function

.open restaurant.db

DROP TABLE menus;
DROP TABLE branch;
  
CREATE TABLE menus (
  store_id int,
  menu_id int,
  menu_name text,
  menu_price int,
  menu_order int,
  menu_status text
);

CREATE TABLE branch (
  store_id int,
  employee_name text,
  employee_number int
);

INSERT INTO menus VALUES
  (1, 1, 'pizza', 100, 5, 'DONE'),
  (1, 2, 'hotdog', 60, 19, 'INPROGRESS'),
  (2, 3, 'coke', 20, 100, 'DELIVERED'),
  (2, 4, 'yogurt', 30, 4, 'NOTSTARTED'),
  (3, 5, 'greentree', 50, 80, 'DELIVERED');

INSERT INTO branch VALUES
  (1, 'valen', 1),
  (2, 'mai', 1),
  (3, 'mai', 1);

.mode column
.header on

SELECT
  store_id,
  menu_id,
  menu_name,
  menu_price * menu_order AS menu_total
FROM menus
ORDER BY menu_total DESC;

SELECT 
  menu_id,
  menu_name,
  menu_price * menu_order AS menu_total
FROM menus
WHERE menu_name = 'hotdog' OR menu_name LIKE 'g%';


SELECT *
FROM menus AS a
JOIN branch AS b ON a.store_id = b.store_id;

-- with
WITH join_table AS (
  SELECT *
  FROM menus AS a
  JOIN branch AS b ON a.store_id = b.store_id
)
SELECT 
  store_id,
  menu_price * menu_order AS menu_total
FROM join_table
ORDER BY menu_total DESC;

-- with, subquery, agg function
WITH join_table AS (
  SELECT *
  FROM menus AS a
  JOIN branch AS b ON a.store_id = b.store_id
)
SELECT
  store_id,
  SUM(menu_price)
FROM join_table
GROUP BY store_id
