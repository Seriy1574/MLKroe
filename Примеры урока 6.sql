
-- Примеры на основе базы данных vk
USE vk;

-- Получаем данные пользователя
SELECT * FROM users WHERE id = 1;

SELECT first_name, last_name, 'main_photo', 'city' FROM users WHERE id = 1;

SELECT
  first_name,
  last_name,
  (SELECT filename FROM media WHERE id = 
    (SELECT photo_id FROM profiles WHERE user_id = 1)
  ),
  (SELECT hometown FROM profiles WHERE user_id = 1)
  FROM users
    WHERE id = 1;

/*тут не ограничили тип медиа*/

-- Получаем фотографии пользователя
SELECT filename FROM media
  WHERE user_id = 1
    AND media_type_id = (
      SELECT id FROM media_types WHERE name LIKE '%photo%'
    );
/*WHERE name LIKE '%photo%' я бы заменил на WHERE id = 1/2/3 ,быстрее работает*/


-- Выбираем историю по добавлению фотографий пользователем
SELECT CONCAT(
  'Пользователь добавил фото ', 
  filename, 
  ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 1 
      AND media_type_id = (
        SELECT id FROM media_types WHERE name LIKE 'photo'
);

/*WHERE name LIKE 'photo' я бы заменил на WHERE id = 1/2/3 ,быстрее работает*/


-- Улучшаем запрос
SELECT CONCAT(
  'Пользователь ', 
  (SELECT CONCAT(first_name, ' ', last_name)
    FROM users WHERE id=1),
  ' добавил фото ', 
  filename, ' ', 
  created_at) AS news 
    FROM media 
    WHERE user_id = 1 
      AND media_type_id = (
        SELECT id FROM media_types WHERE name LIKE 'photo'
);

-- Найдём кому принадлежат 10 самых больших медиафайлов
SELECT user_id, filename, size
  FROM media 
  ORDER BY size DESC
  LIMIT 10;

-- Улучшим запрос
SELECT 
  filename, 
  size,
  (SELECT CONCAT(first_name, ' ', last_name) 
    FROM users u 
      WHERE u.id = m.user_id) AS owner 
  FROM media m
  ORDER BY size DESC
  LIMIT 10;
  
 -- Выбираем друзей пользователя
(SELECT friend_id FROM friendship WHERE user_id = 1)
UNION
(SELECT user_id FROM friendship WHERE friend_id = 1);

/*заменил UNION на UNION ALL*/


-- Выбираем только друзей с подтверждённым статусом
(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 1
    AND confirmed_at IS NOT NULL 
    AND status_id = (
      SELECT id FROM friendship_statuses 
        WHERE name = 'active'
    )
)
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 1
    AND confirmed_at IS NOT NULL 
    AND status_id = (
      SELECT id FROM friendship_statuses 
        WHERE name = 'active'
    )
);


-- Выбираем медиафайлы друзей
SELECT filename FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 1
    AND confirmed_at IS NOT NULL 
    AND status_id = (
      SELECT id FROM friendship_statuses 
        WHERE name = 'active'
    )
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 1
      AND confirmed_at IS NOT NULL 
      AND status_id = (
      SELECT id FROM friendship_statuses 
        WHERE name = 'active'
    )
  )
);

-- Объединяем медиафайлы пользователя и его друзей для создания ленты новостей

SELECT filename, user_id, created_at FROM media WHERE user_id = 1
UNION
SELECT filename, user_id, created_at FROM media WHERE user_id IN (
  (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 1
    AND confirmed_at IS NOT NULL 
    AND status_id = (
      SELECT id FROM friendship_statuses 
        WHERE name = 'active'
    )
  )
  UNION
  (SELECT user_id 
    FROM friendship 
    WHERE friend_id = 1
      AND confirmed_at IS NOT NULL 
      AND status_id = (
      SELECT id FROM friendship_statuses 
        WHERE name = 'active'
    )
  )
);

-- Определяем пользователей, общее занимаемое место медиафайлов которых 
-- превышает 1МБ

SELECT user_id, SUM(size) AS total
  FROM media
  GROUP BY user_id
  HAVING total > 1000000
  ORDER BY total DESC;

-- Подсчитываем лайки для медиафайлов пользователя и его друзей

SELECT target_id AS mediafile, COUNT(*) AS likes 
  FROM likes 
    WHERE target_id IN (
      SELECT id FROM media WHERE user_id = 1
        UNION
      SELECT id FROM media WHERE user_id IN (
        SELECT friend_id 
          FROM friendship 
            WHERE user_id = 1 
              AND status_id = (
                SELECT id FROM friendship_statuses 
                  WHERE name = 'active'
              ))
    )
    AND target_type_id IN (1, 4, 5)
    GROUP BY target_id;

-- 
SELECT * FROM likes 
  WHERE target_id = 1 
    AND target_type_id IN (1, 4, 5) 
  ORDER BY target_type_id;

-- Начинаем создавать архив новостей для медиафайлов по месяцам
SELECT COUNT(id) AS arhive, MONTHNAME(created_at) AS month 
  FROM media
  GROUP BY month;
  
-- Архив с правильной сортировкой новостей по месяцам
SELECT COUNT(id) AS news, MONTHNAME(created_at) AS month 
  FROM media
  WHERE YEAR(created_at) = YEAR(NOW())
  GROUP BY month
  ORDER BY MONTH(created_at) DESC;

SELECT COUNT(id) AS news, MONTHNAME(created_at) AS month
  FROM media
  GROUP BY month
  ORDER BY MONTH(created_at) DESC;

/*У меня не отсортировалось))*/

-- Выбираем сообщения от пользователя и к пользователю
SELECT from_user_id, to_user_id, body, delivered, created_at 
  FROM messages
    WHERE from_user_id = 1
      OR to_user_id = 1
    ORDER BY created_at DESC;
    
-- Непрочитанные сообщения
SELECT from_user_id, 
  to_user_id, 
  body, 
  IF(delivered, 'delivered', 'not delivered') AS status 
    FROM messages
      WHERE (from_user_id = 7 OR to_user_id = 7)
        AND delivered IS NOT TRUE
    ORDER BY created_at DESC;
    
 -- Выводим друзей пользователя с преобразованием пола и возраста 
SELECT 
    (SELECT CONCAT(first_name, ' ', last_name) 
      FROM users 
      WHERE id = user_id) AS friend, 
      
    CASE (sex)
      WHEN 'm' THEN 'man'
      WHEN 'f' THEN 'women'
    END AS sex,
    
    TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age
     
  FROM profiles
  WHERE user_id IN (
    SELECT friend_id 
    
      FROM friendship
      WHERE user_id = 1
        AND confirmed_at IS NOT NULL
        AND status_id = (
          SELECT id FROM friendship_statuses 
            WHERE name = 'check'
          )
  );
    
-- Поиск пользователя по шаблонам имени  
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  HAVING fullname LIKE 'M%';
  
-- Используем регулярные выражения
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  HAVING fullname RLIKE '^M.*s$';


