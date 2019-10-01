-- Урок 8
-- Сложные запросы, JOIN
-- Внешние ключи


-- Разбор ДЗ
-- 2.Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим 
-- пользоваетелем.

-- Выберем id друзей
SELECT * FROM friendship WHERE user_id = 52 OR friend_id = 52;

-- В один столбец
SELECT friend_id AS id FROM friendship WHERE user_id = 52
UNION
SELECT user_id AS id FROM friendship WHERE friend_id = 52;

-- Выбираем id отправителей сообщений
SELECT from_user_id FROM messages 
  WHERE to_user_id = 52 
    AND from_user_id IN (
      SELECT friend_id AS id FROM friendship WHERE user_id = 52
      UNION
      SELECT user_id AS id FROM friendship WHERE friend_id = 52    
);

-- Добавляем имя
SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend 
  FROM messages 
    WHERE to_user_id = 52 
      AND from_user_id IN (
        SELECT friend_id AS id FROM friendship WHERE user_id = 52
        UNION
        SELECT user_id AS id FROM friendship WHERE friend_id = 52    
);

-- Добавляем подсчёт и сортировку
SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend,
  COUNT(*) AS total_messages 
  FROM messages 
    WHERE to_user_id = 52 
      AND from_user_id IN (
        SELECT friend_id AS id FROM friendship WHERE user_id = 52
        UNION
        SELECT user_id AS id FROM friendship WHERE friend_id = 52    
        )
    GROUP BY messages.from_user_id
    ORDER BY total_messages DESC
    LIMIT 1
;

-- Последние правки
SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend,
  COUNT(*) AS total_messages 
  FROM messages 
    WHERE to_user_id = 52 
      AND from_user_id IN (
        SELECT friend_id AS id 
          FROM friendship 
            WHERE user_id = messages.to_user_id
        UNION
        SELECT user_id AS id 
          FROM friendship 
            WHERE friend_id = messages.to_user_id    
        )
    GROUP BY messages.from_user_id
    ORDER BY total_messages DESC
    LIMIT 1
;

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- Смотрим типы для лайков
SELECT * FROM target_types;

-- Выбираем профили с сортировкой по дате рождения
SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10;

-- Выбираем лайки по типу пользователь
SELECT * FROM likes WHERE target_type_id = 3;

-- Объединяем, но так не работает
SELECT * FROM likes WHERE target_type_id = 3
  AND target_id IN (
    SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
  )
;

-- Идём обходным путём
SELECT target_id, COUNT(*) FROM likes 
  WHERE target_type_id = 3
    AND target_id IN (SELECT * FROM (
      SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
    ) AS sorted_profiles ) 
    GROUP BY target_id
;

-- Суммируем для всех пользователей
SELECT SUM(likes_per_user) AS likes_total FROM ( 
  SELECT COUNT(*) AS likes_per_user 
    FROM likes 
      WHERE target_type_id = 3
        AND target_id IN (
          SELECT * FROM (
            SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
          ) AS sorted_profiles 
        ) 
      GROUP BY target_id
) AS counted_likes;


-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT CASE(sex)
		WHEN 'm' THEN 'male'
		WHEN 'f' THEN 'female'
	END AS sex, 
	COUNT(*) as likes_count 
	  FROM (
	    SELECT 
	      user_id as user, 
		    (SELECT sex FROM profiles WHERE user_id = user) as sex 
		  FROM likes) dummy_table 
  GROUP BY sex;
  
  -- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной 
-- сети.     
SELECT CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) 
	AS overall_activity 
	FROM users
	ORDER BY overall_activity
	LIMIT 10;
	
-- Добавляем внешние ключи в БД vk
-- Для таблицы профилей
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL,
  ADD CONSTRAINT profiles_region_id_fk
    FOREIGN KEY (region_id) REFERENCES regions(id)
      ON DELETE SET NULL;
      
-- Для таблицы сообщений
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);


-- Использование JOIN

USE shop;
SELECT users.*, orders.* FROM users, orders;

-- CROSS JOIN
SELECT users.id, users.name, users.birthday_at, orders.id, orders.user_id
  FROM users, orders;
  
-- CROSS JOIN с условием  
SELECT users.id, users.name, users.birthday_at, orders.id, orders.user_id
  FROM users, orders
  WHERE users.id = orders.user_id;

-- Указание связи с помощью ON  
SELECT users.id, users.name, users.birthday_at, orders.id, orders.user_id
  FROM users
    JOIN orders
  ON users.id = orders.user_id;
  
-- INNER JOIN с явным указанием типа
SELECT users.id, users.name, users.birthday_at, orders.id, orders.user_id
  FROM users
    INNER JOIN orders
  ON users.id = orders.user_id;
  
-- INNER JOIN с агрегирующей функцией
-- Подсчёт заказов пользователя  
SELECT users.name, COUNT(orders.user_id) AS total_orders
  FROM users
    JOIN orders
  ON users.id = orders.user_id
  GROUP BY orders.user_id
  ORDER BY total_orders;
  
-- Аналогично запросу выше, но с сокращением записи имён таблиц
SELECT u.name, COUNT(o.user_id) AS total_orders
  FROM users u
    JOIN orders o
  ON u.id = o.user_id
  GROUP BY o.user_id
  ORDER BY total_orders;
  
-- LEFT OUTER JOIN (LEFT JOIN)
SELECT users.id, users.name, users.birthday_at, orders.id, orders.user_id 
  FROM users
    LEFT OUTER JOIN orders
  ON users.id = orders.user_id;
  
-- Пользователи, у которых нет заказов
-- Подумайте, какой тип JOIN тут нужен  
SELECT users.id, users.name, users.birthday_at, orders.id, orders.user_id 
  FROM users
    LEFT OUTER JOIN orders
  ON users.id = orders.user_id
  WHERE orders.id IS NULL;

-- То же самое
SELECT users.id, users.name, users.birthday_at, orders.id, orders.user_id 
  FROM users
    LEFT JOIN orders
  ON users.id = orders.user_id
  WHERE orders.id IS NULL;
  
-- RIGHT OUTER JOIN (RIGHT JOIN)
SELECT users.id AS id_from_users, users.name, users.birthday_at, orders.id AS id_from_orders, orders.user_id 
  FROM users
    LEFT JOIN orders
  ON users.id = orders.user_id;

-- Сравним два варианта ниже  
SELECT users.id AS id_from_users, users.name, users.birthday_at, orders.id AS id_from_orders, orders.user_id 
  FROM orders
    RIGHT JOIN users
  ON users.id = orders.user_id;  

SELECT users.id AS id_from_users, users.name, users.birthday_at, orders.id AS id_from_orders, orders.user_id
  FROM users
    JOIN orders
  ON users.id = orders.user_id;


-- Запросы на БД Vk
USE vk;

-- Выборка данных по пользователю
SELECT first_name, last_name, email, sex, birthday, hometown
  FROM users
    INNER JOIN profiles
      ON users.id = profiles.user_id
  WHERE users.id = 1;

-- Выборка медиафайлов пользователя
SELECT media.user_id, media.filename, media.created_at
  FROM media
    JOIN users
      ON media.user_id = users.id     
  WHERE media.user_id = 1;
  
-- Выборка фотографий пользователя
SELECT media.user_id, media.filename, media.created_at
  FROM media
    JOIN users
      ON media.user_id = users.id
    JOIN media_types
      ON media.media_type_id = media_types.id     
  WHERE media.user_id = 1 AND media_types.id = 
    (SELECT id FROM media_types WHERE name = 'photo');
  
-- Выборка медиафайлов друзей пользователя
SELECT DISTINCT media.user_id, media.filename, media.created_at
  FROM media
    JOIN friendship friendship1
      ON media.user_id = friendship1.user_id
    JOIN friendship friendship2
      ON media.user_id = friendship2.friend_id
    JOIN users 
      ON users.id = friendship1.friend_id
        OR users.id = friendship2.user_id   
  WHERE users.id = 100;

-- Проверка
SELECT user_id, friend_id FROM friendship WHERE user_id = 100 OR friend_id = 100;

-- Выборка фотографий друзей пользователя
SELECT DISTINCT media.user_id, media.filename, media.created_at
  FROM media
    JOIN friendship friendship1
      ON media.user_id = friendship1.user_id
    JOIN friendship friendship2
      ON media.user_id = friendship2.friend_id
    JOIN media_types
      ON media.media_type_id = media_types.id
    JOIN users 
      ON users.id = friendship1.friend_id
        OR users.id = friendship2.user_id   
  WHERE users.id = 2 AND media_types.id = 1;

-- Проверка
SELECT user_id, friend_id FROM friendship WHERE user_id = 2 OR friend_id = 2;
SELECT * FROM media WHERE media_type_id = 1 AND user_id IN (5, 30, 46, 58);

-- Сообщения от пользователя
SELECT messages.body, users.first_name, users.last_name, messages.created_at
  FROM messages
    JOIN users
      ON users.id = messages.to_user_id
  WHERE messages.from_user_id = 100;

-- Сообщения к пользователю
SELECT body, first_name, last_name, messages.created_at
  FROM messages
    JOIN users
      ON users.id = messages.from_user_id
  WHERE messages.to_user_id = 100;
  
-- Объединяем все сообщения от пользователя и к пользователю
SELECT messages.from_user_id, messages.to_user_id, messages.body, messages.created_at
  FROM users
    JOIN messages
      ON users.id = messages.to_user_id
        OR users.id = messages.from_user_id
  WHERE users.id = 100;

-- Количество друзей у пользователя с сортировкой
-- (проверьте, верный ли подсчёт и скорректируйте запрос)
SELECT id, first_name, last_name, COUNT(*) AS total_friends
  FROM users
    LEFT JOIN friendship friendship1
      ON users.id = friendship1.user_id
    LEFT JOIN friendship friendship2
      ON users.id = friendship2.friend_id
  GROUP BY users.id
  ORDER BY total_friends DESC;

-- Проверка
SELECT * FROM friendship WHERE user_id = 52 OR friend_id = 52;

-- Количество друзей у пользователя (статус - активный) с сортировкой
-- (проверьте, верный ли подсчёт и скорректируйте запрос)
SELECT id, first_name, last_name, COUNT(users.id) AS total_friends
  FROM users
    LEFT JOIN friendship friendship1
      ON users.id = friendship1.user_id
        AND friendship1.status_id = 1
    LEFT JOIN friendship friendship2
      ON users.id = friendship2.friend_id
        AND friendship2.status_id = 1
  GROUP BY users.id
  ORDER BY total_friends DESC;

-- Список медиафайлов пользователя с количеством лайков
SELECT media.filename,
  target_types.name,
  COUNT(*) AS total_likes,
  CONCAT(first_name, ' ', last_name) AS owner
  FROM media
    JOIN likes
      ON media.id = likes.target_id
    JOIN target_types
      ON likes.target_type_id = target_types.id
    JOIN users
      ON users.id = media.user_id
  WHERE users.id = 2 AND target_types.id = 1
  GROUP BY media.id;

SELECT * FROM likes 
  WHERE target_type_id = 1 
    AND target_id IN (SELECT id FROM media WHERE user_id = 2);
SELECT * FROM media WHERE id = 2;

-- 10 пользователей с наибольшим количеством лайков за медиафайлы
SELECT users.id, first_name, last_name, COUNT(*) AS total_likes
  FROM users
    JOIN media
      ON users.id = media.user_id
    JOIN likes
      ON media.id = likes.target_id
    JOIN target_types
      ON likes.target_type_id = target_types.id
  WHERE target_types.id = 1
  GROUP BY users.id
  ORDER BY total_likes DESC
  LIMIT 10;

SELECT * FROM likes 
  WHERE target_type_id = 1 
    AND target_id IN (SELECT id FROM media WHERE user_id = 6);
SELECT * FROM media WHERE id = 6;
    


