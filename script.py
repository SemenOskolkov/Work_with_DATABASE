import csv
import psycopg2

with psycopg2.connect(
        host='localhost',
        database='north',
        user='postgres',
        password='8071'
) as conn:  # Подключаемся к БД
    with conn.cursor() as cur:  #
        with open('employees_data.csv') as file:  # Работа с файлом employees_data.csv
            employees_file = csv.DictReader(file)
            for row in employees_file:
                cur.execute(
                    "INSERT INTO employees(first_name, last_name, title, birth_date, notes) VALUES (%s, %s, %s, %s, %s)",
                    (row["first_name"], row["last_name"], row["title"],
                     row["birth_date"], row["notes"]))  # Заполнение данных в таблицу

        with open('customers_data.csv') as file:  # Работа с файлом customers_data.csv
            customers_file = csv.DictReader(file)
            for row in customers_file:
                cur.execute("INSERT INTO customers VALUES (%s, %s, %s)",
                            (row['customer_id'], row['company_name'],
                             row['contact_name']))  # Заполнение данных в таблицу

        with open('orders_data.csv') as file:  # Работа с файлом orders_data.csv
            orders_file = csv.DictReader(file)
            for row in orders_file:
                cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)", (
                    row['order_id'], row['customer_id'], row['employee_id'], row['order_date'],
                    row['ship_city']))  # Заполнение данных в таблицу

conn.close()  # Закрываем подключение к БД
