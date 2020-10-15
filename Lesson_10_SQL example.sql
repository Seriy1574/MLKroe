-- Базы данных. Урок 10. Вебинар. Транзакции, переменные, представления

-- ДЗ к уроку 8

-- 1. Добавить необходимые внешние ключи для всех таблиц базы данных vk
-- (приложить команды).
-- 2.По созданным связям создать ER диаграмму, используя Dbeaver (приложить графический файл к ДЗ).
-- 3.Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN
--  (четыре запроса).

-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех
-- общался с нашим пользоваетелем.

SELECT (SELECT CONCAT(first_name, ' ', last_name) 
          FROM users 
            WHERE id = messages.from_user_id) AS friend_name, 
  COUNT(DISTINCT messages.id) AS total_messages 
  FROM users
    JOIN profiles 
      ON users.id = profiles.user_id
    JOIN friendship friendship1
      ON profiles.user_id = friendship1.user_id
    JOIN friendship friendship2
      ON profiles.user_id = friendship2.friend_id
    JOIN messages
      ON messages.to_user_id = users.id
        AND (messages.from_user_id = friendship1.friend_id
          OR messages.from_user_id = friendship2.user_id)
  WHERE users.id = 52
  GROUP BY messages.from_user_id
  ORDER BY total_messages DESC
  LIMIT 1;      

-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(got_likes) AS total_likes_for_yangest
  FROM (   
    SELECT COUNT(DISTINCT likes.user_id) AS got_likes 
      FROM profiles
        LEFT JOIN likes
          ON likes.target_id = profiles.user_id
            AND target_type_id = 3
      GROUP BY profiles.user_id
      ORDER BY profiles.birthday DESC
      LIMIT 20
) AS yangest;

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT profiles.sex AS SEX, 
  COUNT(likes.id) AS total_likes
  FROM likes
    JOIN profiles
      ON likes.user_id = profiles.user_id
    GROUP BY profiles.sex
    ORDER BY total_likes DESC
    LIMIT 1;

-- Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети.

SELECT users.id,
  COUNT(DISTINCT messages.to_user_id) + 
  COUNT(DISTINCT likes.target_id) + 
  COUNT(DISTINCT media.id) AS activity 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id
  ORDER BY activity DESC
  LIMIT 10;

-- 4.(необязательно) Скорректировать запросы из урока (перечислены ниже)
-- в части правильного подсчёта. "Количество друзей у пользователя с сортировкой"
-- и "Количество друзей у пользователя (статус - активный) с сортировкой"

SELECT id, first_name, last_name, 
  COUNT(DISTINCT friendship1.friend_id) + 
    COUNT(DISTINCT friendship2.user_id) AS total_friends  
  FROM users
    LEFT JOIN friendship friendship1
      ON users.id = friendship1.user_id AND friendship1.status_id = 1
    LEFT JOIN friendship friendship2
      ON users.id = friendship2.friend_id AND friendship2.status_id = 1
  GROUP BY users.id
  ORDER BY total_friends DESC
  LIMIT 10;

SELECT id, first_name, last_name, COUNT(DISTINCT user_id) AS total_friends
  FROM users
    LEFT JOIN friendship
      ON  friendship.status_id = 1 
        AND (users.id = friendship.user_id
          OR users.id = friendship.friend_id)
  GROUP BY users.id
  ORDER BY total_friends DESC
  LIMIT 10;
  

-- ДЗ к уроку 10

-- Вариант Дмитрия Большакова
-- Практическое задание по теме “Транзакции, переменные, представления”

-- 1.В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
-- Используйте транзакции.

SET @id_move_user=1;
START TRANSACTION;
  INSERT INTO sample.users (SELECT * FROM shop.users WHERE id=@id_move_user);
  DELETE FROM shop.users WHERE id=@id_move_user;
COMMIT;
SELECT * FROM sample.users;
SELECT * FROM shop.users;

-- 2.Создайте представление, которое выводит название name товарной
-- позиции из таблицы products и соответствующее название каталога name
-- из таблицы catalogs.

USE shop;

DROP VIEW IF EXISTS view_products;
CREATE VIEW view_products (name, catalog_name) AS 
  (SELECT products.name, catalogs.name 
    FROM products
      JOIN catalogs 
        ON products.catalog_id=catalogs.id);

SELECT * FROM view_products;

-- 3.Пусть имеется таблица с календарным полем created_at.
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2018-08-04', 
-- '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, 
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

USE example;

DROP TABLE IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (id SERIAL, created_at DATE);
INSERT INTO tests (created_at) VALUES ('2018-08-01'),('2018-08-04'),('2018-08-16'), ('2018-08-17');

SELECT tab.date_m, NOT isnull(created_at) AS created_at  FROM (
SELECT adddate('2018-08-01',t1.i+t2.i) AS date_m FROM (
  (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
  (SELECT 0 i UNION SELECT 10 UNION SELECT 20 UNION SELECT 30) t2) 
  WHERE adddate('2018-08-01',t1.i+t2.i) BETWEEN '2018-08-01' and '2018-08-31' ) tab
    LEFT JOIN tests ON tab.date_m=tests.created_at
ORDER BY tab.date_m;
;  

-- 4.Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

USE example;

DROP TABLE IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (id SERIAL, created_at DATE);
INSERT INTO tests (created_at) VALUES ('2018-08-01'),('2018-08-04'),('2018-08-16'), ('2018-09-17'),
('2018-09-01'),('2018-12-04'),('2018-11-16'), ('2018-07-17'),
('2018-11-11'),('2018-12-01'),('2018-08-14'), ('2018-09-15');

CREATE TEMPORARY TABLE temp (id INT, created_at DATE);
INSERT INTO temp (SELECT * FROM tests ORDER BY  created_at DESC LIMIT 5);

DELETE FROM tests WHERE created_at NOT IN (SELECT temp.created_at FROM temp);
SELECT * FROM tests ORDER BY created_at;
DROP TEMPORARY TABLE IF EXISTS temp;


-- Практическое задание по теме “Администрирование MySQL”
-- (эта тема изучается по вашему желанию)

--1.Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

DROP USER IF EXISTS 'shop'@'localhost'; 
DROP USER IF EXISTS 'shop_read'@'localhost'; 

CREATE  USER IF NOT EXISTS 'shop'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON shop.* TO 'shop'@'localhost';

CREATE USER 'shop_read'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- 1.Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна
-- возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
-- фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 —
-- "Доброй ночи".

CREATE DEFINER=`root`@`localhost` FUNCTION `hello`() RETURNS text CHARSET utf8mb4
DETERMINISTIC
BEGIN
DECLARE return_text text;
if hour(now())>=6 AND hour(now())<=12 then
  set return_text='Доброе утро';
elseif hour(now())>12 AND hour(now())<=18 then
  set return_text='Доброе день';
elseif hour(now())>18 AND hour(now())<=23 then 
  set return_text='Добрый вечер';
else 
  set return_text='Доброй ночи'; 
end if;
RETURN return_text;
END

-- 2.В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

CREATE TRIGGER check_catalog_id_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF isnull(NEW.name) and isnull(NEW.desription) THEN
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
  END IF; 
END
USE shop;

UPDATE products SET desription = NULL WHERE id = 5;
select * from products;

-- 3.Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
--# Вызов функции FIBONACCI(10) должен возвращать число 55.

CREATE DEFINER=`root`@`localhost` FUNCTION `FIBONACCI`(num INT) RETURNS INTEGER
  DETERMINISTIC
BEGIN
DECLARE i INT;
DECLARE new_number INT;
DECLARE old_number1 INT;
DECLARE old_number2 INT;
DECLARE result INT;
SET i=2;
SET old_number1=1;
SET old_number2=0;
IF num=0 THEN
  RETURN 0;
ELSEIF num=1 THEN
  RETURN 1;
END IF;

cycle: LOOP
  SET new_number=(old_number1)+(old_number2);
  IF i>=num THEN
    LEAVE cycle;
  END IF;
  SET old_number2=old_number1;
  SET old_number1=new_number;
  SET i=i+1;
END LOOP;
 
RETURN new_number;
END
     

-- Хранимые процедуры и функции

-- 1. Создаём функцию

-- Направленность дружбы
-- Кол-во приглашений в друзья к пользователю
-- /
-- Кол-во приглашений в друзья от пользователя

-- Чем больше - популярность выше
-- Если значение меньше единицы - пользователь инициатор связей.

USE vk;

DROP FUNCTION IF EXISTS friendship_direction;

DELIMITER //
CREATE FUNCTION friendship_direction(check_user_id INT)
RETURNS FLOAT READS SQL DATA

  BEGIN
    
    DECLARE requests_to_user INT;
    DECLARE requests_from_user INT;
    
    SET requests_to_user = 
      (SELECT COUNT(*) 
        FROM friendship
          WHERE friend_id = check_user_id);
    
    SET requests_from_user = 
      (SELECT COUNT(*) 
        FROM friendship
          WHERE user_id = check_user_id);
    
    RETURN requests_to_user / requests_from_user;
  END//
  
DELIMITER ;

SELECT TRUNCATE(friendship_direction(7), 2) AS friendship_direction;



-- 2. Создаём процедуру

-- Рассылка приглашений вида "Возможно, вам будет интересно пообщаться с ..."
-- Варианты:
-- из одного города
-- состоят в одной группе
-- друзья друзей
-- Из выборки показывать 5 человек в случайной комбинации.


DROP PROCEDURE IF EXISTS friendship_offers;

DELIMITER //

CREATE PROCEDURE friendship_offers (IN for_user_id INT)

  BEGIN 
    (
      SELECT pr2.user_id
        FROM profiles pr1
          JOIN profiles pr2
            ON pr1.hometown = pr2.hometown
        WHERE pr1.user_id = for_user_id
      
      UNION
      
      SELECT cu2.user_id
        FROM communities_users cu1
          JOIN communities_users cu2
            ON cu1.community_id = cu2.community_id
        WHERE cu1.user_id = for_user_id
      
      UNION
    
      SELECT DISTINCT(fr3.user_id)
        FROM friendship fr1
          JOIN friendship fr2
            ON fr1.friend_id = fr2.user_id
          JOIN friendship fr3
            ON fr2.friend_id = fr3.user_id
        WHERE fr1.user_id = for_user_id
          AND fr2.status IS TRUE
          AND fr3.status IS TRUE
    )
        
    ORDER BY RAND()
    LIMIT 5;
     
END//
  
DELIMITER ;

CALL friendship_offers(1);

-- Просмотр функций и процедур
SHOW FUNCTION STATUS LIKE 'friendship_direction'\G
SHOW CREATE FUNCTION friendship_direction;

SHOW PROCEDURE STATUS LIKE 'friendship_offers'\G
SHOW CREATE PROCEDURE friendship_offers;


-- Индексы

SELECT id, firstname, lastname 
  FROM users 
    WHERE email = 'ullrich.adella@example.net';

SELECT id, firstname, lastname 
  FROM users 
    WHERE email = 'ullrich.adella@example.net';
    
CREATE INDEX users_email_idx ON users(email);

-- После этой операции MySQL начнет использовать индекс age для выполнения 
-- подобных запросов.

-- Сортировка
SELECT * FROM profiles ORDER BY birthday;

-- действует такое же правило — создаем индекс на колонку, по которой происходит 
-- сортировка:

CREATE INDEX profiles_birthday_idx ON profiles(birthday);

-- Внутренности хранения индексов
-- Представим, что наша таблица выглядит так:
SELECT id, firstname, lastname, email FROM users;

-- После создания индекса на колонку email, MySQL сохранит все ее значения в 
-- отсортированном виде:
users_email_idx
+-----------------------------+
| acarroll@example.net        |
| alvera.terry@example.org    |
| alyce76@example.com         |
| arianna46@example.net       |
| arielle.murazik@example.org |
| aurelio.abbott@example.org  |
| beatty.tommie@example.com   |
| bergnaum.asia@example.org   |
| bergnaum.donato@example.org |
| blaise68@example.org        |
+-----------------------------+

-- MySQL поддерживает также уникальные индексы. Это удобно для колонок, 
-- значения в которых должны быть уникальными по всей таблице. 

-- Такие индексы улучшают эффективность выборки для уникальных значений. 
SELECT * FROM users WHERE email = 'acarroll@example.net';

-- На колонку email необходимо создать уникальный индекс:
CREATE UNIQUE INDEX users_email_uq ON users(email);
DROP INDEX users_email_uq ON users;

-- Составные индексы
-- MySQL может использовать только один индекс для запроса (кроме случаев, 
-- когда MySQL способен объединить результаты выборок по нескольким индексам).

-- Рассмотрим такой запрос:
SELECT * FROM media WHERE user_id = 9 AND media_type_id = 3;

-- Нам следует создать составной индекс на обе колонки:
CREATE INDEX media_user_id_media_type_id_idx ON media(user_id, media_type_id);

-- Устройство составного индекса
-- media_user_id_media_type_id_idx
13
24
33
...

-- Сортировка
-- Составные индексы также можно использовать, если выполняется сортировка:
SELECT * FROM profiles WHERE sex = 'm' ORDER BY birthday;

-- В этом случае нам нужно будет создать индекс в порядке
-- WHERE ORDER BY



-- Оконные функции

-- Задача
-- Найти сколько занимают места медиафайлы в разрезе типов в процентном соотношении

-- Решаем традиционным способом, применяя агрегатные функции
SELECT media_types.name, 
  SUM(media.size) AS total_by_type,
  (SELECT SUM(size) FROM media) AS total_size,
  SUM(media.size)/(SELECT SUM(size) FROM media) * 100 AS "%%" 
    FROM media
      JOIN media_types
        ON media.media_type_id = media_types.id
    GROUP BY media.media_type_id;

-- Реализация используя агрегатные функции как оконные
SELECT DISTINCT media_types.name, 
  SUM(media.size) OVER(PARTITION BY media.media_type_id) AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER(PARTITION BY media.media_type_id) / SUM(media.size) OVER() * 100 AS "%%"
    FROM media
      JOIN media_types
        ON media.media_type_id = media_types.id;

-- Расширяем вывод
SELECT DISTINCT media_types.name,
  AVG(media.size) OVER(PARTITION BY media.media_type_id) AS average,
  MIN(media.size) OVER(PARTITION BY media.media_type_id) AS min,
  MAX(media.size) OVER(PARTITION BY media.media_type_id) AS max,
  SUM(media.size) OVER(PARTITION BY media.media_type_id) AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER(PARTITION BY media.media_type_id) / SUM(media.size) OVER() * 100 AS "%%"
    FROM media
      JOIN media_types
        ON media.media_type_id = media_types.id;

-- Выносим окно отдельно
SELECT DISTINCT media_types.name,
  AVG(media.size) OVER w AS average,
  MIN(media.size) OVER w AS min,
  MAX(media.size) OVER w AS max,
  SUM(media.size) OVER w AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER w / SUM(media.size) OVER() * 100 AS "%%"
    FROM (media
      JOIN media_types
        ON media.media_type_id = media_types.id)
        WINDOW w AS (PARTITION BY media.media_type_id);

-- Оконные функции не сворачивают вывод
-- Убираем DISTINCT
SELECT media_types.name,
  AVG(media.size) OVER w AS average,
  MIN(media.size) OVER w AS min,
  MAX(media.size) OVER w AS max,
  SUM(media.size) OVER w AS total_by_type,
  SUM(media.size) OVER() AS total,
  SUM(media.size) OVER w / SUM(media.size) OVER() * 100 AS "%%"
    FROM (media
      JOIN media_types
        ON media.media_type_id = media_types.id)
        WINDOW w AS (PARTITION BY media.media_type_id);

-- Применяем чистые оконные функции
SELECT id, name, created_at,
  ROW_NUMBER() OVER w AS 'row_number',
  FIRST_VALUE(name)  OVER w AS 'first',
  LAST_VALUE(name)   OVER w AS 'last',
  NTH_VALUE(name, 2) OVER w AS 'second'
    FROM regions
      WINDOW w AS (PARTITION BY LEFT(created_at, 3) ORDER BY created_at);   



