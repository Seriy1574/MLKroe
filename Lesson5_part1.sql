﻿Виктор приветствую!

1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

Загрузил дамп из урока, чтоб не далать таблицы самому.(кстати там ошибка есть, дамп не грузится)))

в таблице users изменил тип полей created_at и updated_at, чтоб можно было внести пустые значения и внес пустые значения
ALTER TABLE users MODIFY COLUMN created_at DATETIME DEFAULT NULL;
INSERT INTO users (name, birthday_at) VALUES
('Геннадий', '1999-02-05'),
('Николай', '1981-09-02'),
('Петр', '1988-01-29'),
('Виктор', '1983-05-22'),
('Анжела', '1990-01-11'),
('Ирина', '1994-06-29');

+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  1 | Геннадий           | 1990-10-05  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  2 | Наталья            | 1984-11-12  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  3 | Александр          | 1985-05-20  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  4 | Сергей             | 1988-02-14  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  5 | Иван               | 1998-01-12  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  6 | Мария              | 1992-08-29  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  7 | Геннадий           | 1990-10-05  | NULL                | NULL                |
|  8 | Геннадий           | 1999-02-05  | NULL                | NULL                |
|  9 | Николай            | 1981-09-02  | NULL                | NULL                |
| 10 | Петр               | 1988-01-29  | NULL                | NULL                |
| 11 | Виктор             | 1983-05-22  | NULL                | NULL                |
| 12 | Анжела             | 1990-01-11  | NULL                | NULL                |
| 13 | Ирина              | 1994-06-29  | NULL                | NULL                |
+----+--------------------+-------------+---------------------+---------------------+
как показывали в уроке

select * from users WHERE created_at IS NULL;
+----+------------------+-------------+------------+------------+
| id | name             | birthday_at | created_at | updated_at |
+----+------------------+-------------+------------+------------+
|  7 | Геннадий         | 1990-10-05  | NULL       | NULL       |
|  8 | Геннадий         | 1999-02-05  | NULL       | NULL       |
|  9 | Николай          | 1981-09-02  | NULL       | NULL       |
| 10 | Петр             | 1988-01-29  | NULL       | NULL       |
| 11 | Виктор           | 1983-05-22  | NULL       | NULL       |
| 12 | Анжела           | 1990-01-11  | NULL       | NULL       |
| 13 | Ирина            | 1994-06-29  | NULL       | NULL       |
+----+------------------+-------------+------------+------------+
SELECT  Заменяем на UPDATE

UPDATE users SET created_at =  NOW() WHERE created_at IS NULL;

тоже самое провел с полем updated_at

UPDATE users SET updated_at =  NOW() WHERE updated_at IS NULL;
select * from users;
+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  1 | Геннадий           | 1990-10-05  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  2 | Наталья            | 1984-11-12  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  3 | Александр          | 1985-05-20  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  4 | Сергей             | 1988-02-14  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  5 | Иван               | 1998-01-12  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  6 | Мария              | 1992-08-29  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  7 | Геннадий           | 1990-10-05  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
|  8 | Геннадий           | 199-02-05  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
|  9 | Николай            | 1981-09-02  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
| 10 | Петр               | 1988-01-29  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
| 11 | Виктор             | 1983-05-22  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
| 12 | Анжела             | 1990-01-11  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
| 13 | Ирина              | 1994-06-29  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
+----+--------------------+-------------+---------------------+---------------------+
В ЭТОМ ЗАДАНИИ ВСЕ ПОНЯТНО.

==========================================================================================================================



2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое
время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.


СОздал новую таблицу чтоб были такие данные.
Добавил две строки
Получил таблицу с такими сво-вами полей
DESCRIBE users2;
+-------------+------------------+------+-----+---------+----------------+
| Field       | Type             | Null | Key | Default | Extra          |
+-------------+------------------+------+-----+---------+----------------+
| id          | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| name        | varchar(100)     | NO   |     | NULL    |                |
| birthday_at | datetime         | YES  |     | NULL    |                |
| created_at  | varchar(100)     | YES  |     | NULL    |                |
| updated_at  | varchar(100)     | YES  |     | NULL    |                |
+-------------+------------------+------+-----+---------+----------------+

Я сделал так. СМУЩАЕТ ЧТО МЫ МЕНЯЕМ ПОЛЕ И В НЕГО ЖЕ ЕГО ЖЕ И ВСТАВЛЯЕМ.((

UPDATE users2 SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');
UPDATE users2 SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

ALTER TABLE users2 ADD COLUMN created_at_new  DATETIME  NOT NULL DEFAULT NOW();
ALTER TABLE users2 ADD COLUMN updated_at_new  DATETIME  NOT NULL DEFAULT NOW();
UPDATE users2 SET created_at_new = created_at;
UPDATE users2 SET updated_at_new = updated_at;
ALTER TABLE users2 DROP COLUMN updated_at;
ALTER TABLE users2 DROP COLUMN created_at;
ALTER TABLE users2 RENAME COLUMN created_at_new TO created_at;
ALTER TABLE users2 RENAME COLUMN updated_at_new TO updated_at;

mysql> DESCRIBE users2;
+-------------+------------------+------+-----+-------------------+-------------------+
| Field       | Type             | Null | Key | Default           | Extra             |
+-------------+------------------+------+-----+-------------------+-------------------+
| id          | int(10) unsigned | NO   | PRI | NULL              | auto_increment    |
| name        | varchar(100)     | NO   |     | NULL              |                   |
| birthday_at | datetime         | YES  |     | NULL              |                   |
| created_at  | datetime         | NO   |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at  | datetime         | NO   |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+-------------+------------------+------+-----+-------------------+-------------------+
ДОЛГО ВОЗИЛСЯ, НЕ ПРАВИЛЬНО ПОНЯЛ УСЛОВИЕ ЗАДАНИЯ))
==========================================================================================================================


3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
Однако, нулевые запасы должны выводиться в конце, после всех записей.


SELECT * FROM storehouses_products s
order by if(s.value != 0, 1, 0) DESC , value;

или так

SELECT * FROM storehouses_products s
order by case when value > 0 then 1 else 0 END desc , value;

ДУМАЮ ЕСТЬ ПРОЩЕ СПОСОБ КОТОРЫЙ ВХОДИТЬ В РАМКИ ПРОЙДЕННОГО МАТЕРИАЛА


==========================================================================================================================

4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.////
Месяцы заданы в виде списка английских названий ('may', 'august')

Добавил столбец с для месяца рождения
ALTER TABLE users ADD m_b VARCHAR(20);
Добавил в него данные.
UPDATE users SET m_b=DATE_FORMAT(birthday_at, '%M');
Сам запрос
SELECT  * from users u
WHERE lower(m_b) IN ('may', 'august');

или так

SELECT * FROM users
WHERE lower(date_format(birthday_at, '%M')) in ('may','august');

+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  3 | Александр          | 1985-05-20  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
|  6 | Мария              | 1992-08-29  | 2019-09-20 06:34:05 | 2019-09-20 06:34:05 |
| 11 | Виктор             | 1983-05-22  | 2019-09-20 07:18:15 | 2019-09-20 07:19:35 |
+----+--------------------+-------------+---------------------+---------------------+


==========================================================================================================================


5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
Отсортируйте записи в порядке, заданном в списке IN.


по аналогии с предыдущим заданием
SELECT * FROM users WHERE id IN (5,1,2)
order by case id when 5 then 1 when 1 then 2 else 2 end;

КАЖЕТСЯ МНЕ ЧТО ЕСТЬ ПРОЩЕ.ОПЯТЬ ЖЕ ЕСЛИ БРОСАТЬСЯ ИЗ КРАЙНОСТИ В КРАЙНОСТЬ: ВДРУГ БУДЕТ 1000 ЗНАЧЕНИЙ И ВСЕ ИХ ПРОПИСЫВАТЬ КАК-ТО НЕТ ЖЕЛАНИЯ.



