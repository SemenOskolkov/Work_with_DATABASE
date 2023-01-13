--Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, 
--работающего над заказом этой компании (см таблицу employees), 
--когда и заказчик и сотрудник зарегистрированы в городе London, 
--а доставку заказа ведет компания United Package (company_name в табл shippers)

SELECT customers.company_name, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, shippers.company_name 
FROM orders
INNER JOIN customers USING(customer_id)
INNER JOIN employees USING(employee_id)
JOIN shippers ON orders.ship_via=shippers.shipper_id
WHERE employees.city ='London' AND customers.city='London' 
AND shippers.company_name = 'United Package'

--Наименование продукта, количество товара (product_name и units_in_stock в табл products), 
--имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов, 
--которые не сняты с продажи (поле discontinued) и 
--которых меньше 25 и которые в категориях Dairy Products и Condiments. 
--Отсортировать результат по возрастанию количества оставшегося товара.

SELECT product_name, units_in_stock, suppliers.contact_name, suppliers.phone, discontinued, categories.category_name
FROM products
JOIN suppliers USING(supplier_id)
JOIN categories USING(category_id)
WHERE discontinued <> 1 AND units_in_stock < 25
AND categories.category_name IN ('Dairy Products', 'Condiments')
ORDER BY units_in_stock

--Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа

SELECT company_name
FROM customers
WHERE NOT EXISTS (SELECT customer_id FROM orders WHERE customers.customer_id = orders.customer_id)
  
--уникальные названия продуктов, которых заказано ровно 10 единиц 
--(количество заказанных единиц см в колонке quantity табл order_details)

SELECT product_name FROM products
WHERE EXISTS (SELECT 1 FROM order_details  WHERE products.product_id = product_id AND quantity = 10)