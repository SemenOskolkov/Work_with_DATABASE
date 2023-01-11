SELECT contact_name, country --атрибуты "имя контакта" и "город" (contact_name, country) из таблицы customers
FROM customers

SELECT order_id, (shipped_date - order_date) as total --идентификатор заказа и разница между датами формирования (order_date) заказа и его отгрузкой (shipped_date) из таблицы orders
FROM orders

SELECT DISTINCT city --все города без повторов, в которых зарегистрированы заказчики (customers)
FROM customers

SELECT COUNT(1) --количество заказов (таблица orders)
FROM orders

SELECT COUNT(ship_country) --количество стран, в которые отгружался товар (таблица orders, колонка ship_country)
FROM orders

SELECT * --заказы, доставленные в страны France, Germany, Spain (таблица orders, колонка ship_country)
FROM orders
WHERE ship_country IN ('France', 'Germany', 'Spain')

SELECT DISTINCT ship_country, ship_city --уникальные города и страны, куда отправлялись заказы, отсортировать по странам и городам (таблица orders, колонки ship_country, ship_city)
FROM orders
ORDER BY ship_country, ship_city

SELECT AVG(shipped_date - order_date) --сколько дней в среднем уходит на доставку товара в Германию (таблица orders, колонки order_date, shipped_date, ship_country)
FROM orders
WHERE ship_country = 'Germany'

SELECT MAX(unit_price), MIN(unit_price) --минимальную и максимальную цену среди продуктов, не снятых с продажи (таблица products, колонки unit_price, discontinued не равно 1)
FROM products
WHERE discontinued <> 1

SELECT MAX(unit_price), MIN(unit_price) --минимальную и максимальную цену среди продуктов, не снятых с продажи и которых имеется не меньше 20 (таблица products, колонки unit_price, units_in_stock, discontinued не равно 1)
FROM products
WHERE units_in_stock > 20 AND discontinued <> 1

SELECT DISTINCT ship_city, ship_country --заказы, отправленные в города, заканчивающиеся на 'burg'. Вывести без повторений две колонки (город, страна) (см. таблица orders, колонки ship_city, ship_country)
FROM orders
WHERE ship_city LIKE '%burg'

SELECT order_id, customer_id, freight, ship_country --из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгрузки. Заказ отгружен в страны, начинающиеся на 'P'. Результат отсортирован по весу (по убыванию). Вывести первые 10 записей.
FROM orders
WHERE ship_country LIKE 'P%'
ORDER BY freight DESC
LIMIT 10

SELECT last_name, home_phone --фамилию и телефон сотрудников, у которых в данных отсутствует регион (см таблицу employees)
FROM employees
WHERE region IS NULL

SELECT country, COUNT(1) --количество поставщиков (suppliers) в каждой из стран. Результат отсортировать по убыванию количества поставщиков в стране
FROM suppliers
GROUP BY country
ORDER BY COUNT(1) DESC

SELECT ship_country, SUM(freight) --суммарный вес заказов (в которых известен регион) по странам, но вывести только те результаты, где суммарный вес на страну больше 2750. Отсортировать по убыванию суммарного веса (см таблицу orders, колонки ship_region, ship_country, freight)
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY SUM(freight) DESC

SELECT country --страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers) и работники (employees).
FROM customers
INTERSECT
SELECT country
FROM suppliers
INTERSECT
SELECT country
FROM employees

SELECT country --страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers), но не зарегистрированы работники (employees)
FROM customers
INTERSECT
SELECT country
FROM suppliers
EXCEPT
SELECT country
FROM employees