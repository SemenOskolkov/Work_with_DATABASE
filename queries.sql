CREATE TABLE employees
(
	employee_id serial,
	first_name varchar(50),
	last_name varchar
);
CREATE TABLE department
(
	department_id serial PRIMARY KEY,
	department_name varchar
)

CREATE TABLE employees
(
	employee_id serial,
	first_name varchar(50),
	department_id int,
	
	CONSTRAINT pk_employees_employee_id PRIMARY KEY(employee_id)
);

ALTER TABLE employees ADD COLUMN middle_name varchar;
ALTER TABLE employees ADD COLUMN birthday date;
ALTER TABLE employees DROP COLUMN birthday;

ALTER TABLE departament RENAME TO department;
ALTER TABLE department RENAME departament_id TO department_id;
ALTER TABLE department RENAME departament_name TO department_name;

ALTER TABLE employees ALTER COLUMN last_name SET DATA TYPE varchar(50);

INSERT INTO department (department_name) VALUES ('dep1'), ('dep2'), ('dep3');
TRUNCATE TABLE department RESTART IDENTITY

SELECT * FROM department
DROP TABLE department

--Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar

CREATE TABLE student
(
	student_id serial,
	first_name varchar,
	last_name varchar
	birthday date,
	phone varchar
)

--Добавить в таблицу после создания колонку middle_name varchar

ALTER TABLE student ADD COLUMN middle_name varchar;

--Удалить колонку middle_name

ALTER TABLE student DROP COLUMN middle_name;

--Переименовать колонку birthday в birth_date

ALTER TABLE student RENAME birthda TO birth_date;

--Изменить тип данных колонки phone на varchar(32)

ALTER TABLE student ALTER COLUMN phone SET DATA TYPE varchar(32);

--Вставить три любых записи с автогенерацией идентификатора

INSERT INTO student (first_name, last_name) VALUES ('Jon', 'Wite'), ('Kate', 'Brown'), ('Tom', 'Smith');

--Удалить все данные из таблицы со сбросом идентификатор в исходное состояние

TRUNCATE TABLE student RESTART IDENTITY;

--добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)

ALTER TABLE products ADD CONSTRAINT unit_price CHECK (unit_price > 0);

--добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1

ALTER TABLE products ADD CONSTRAINT discontinued CHECK (discontinued IN (0, 1));

--Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)

SELECT * INTO new_table FROM products WHERE discontinued = 1;

--Удалить из products товары, снятые с продажи (discontinued = 1)

ALTER TABLE products DISABLE TRIGGER ALL;
DELETE FROM products WHERE discontinued = 1;
ALTER TABLE products ENABLE TRIGGER ALL;