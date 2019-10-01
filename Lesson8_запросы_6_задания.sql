
Виктор, приветствую!

Запросы шестого задания

=========================================================================================================================

2. Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим
пользоваетелем.

Пользователь id = 648


SELECT CONCAT
    ('Пользователь '
    ,u1.first_name
    ,' '
    ,u1.last_name
    ,' получил '
    ,t1.all_mess
    ,' сообщ. от пользователя '
    ,u2.first_name
    ,' '
    ,u2.last_name) AS text_mess
  FROM
       (SELECT m.to_user_id, m.from_user_id, count(m.id) all_mess
          FROM messages m
         WHERE m.to_user_id = 648
         GROUP BY m.to_user_id, m.from_user_id
         ORDER BY all_mess DESC
         LIMIT 1) t1
               JOIN users u1
               ON u1.id = t1.to_user_id
               JOIN users u2
               ON u2.id = t1.from_user_id;


+--------------------------------------------------------------------------------------------------------------------------+
| text_mess                                                                                                                |
+--------------------------------------------------------------------------------------------------------------------------+
| Пользователь Christelle Pfannerstill получил 3 сообщ. от пользователя Winfield Rau                                       |
+--------------------------------------------------------------------------------------------------------------------------+


Пользователь id = 3

SELECT CONCAT
    ('Пользователь '
    ,t1.first_name_to
    ,' '
    ,t1.last_name_to
    ,' получил '
    ,t1.all_mess
    ,' сообщ. от пользователя '
    ,t1.first_name_from
    ,' '
    ,t1.last_name_from) AS text_mess
FROM (SELECT u1.first_name AS first_name_to,
             u1.last_name AS last_name_to,
             u2.first_name AS first_name_from,
             u2.last_name AS last_name_from,
             COUNT(m.id) AS all_mess
  FROM messages m
       JOIN users u1
       ON u1.id = m.to_user_id
       AND m.to_user_id = 3
       JOIN users u2
       ON u2.id = m.from_user_id
GROUP BY m.to_user_id, m.from_user_id
ORDER BY all_mess DESC
LIMIT 1) AS t1;


+------------------------------------------------------------------------------------------------------------------+
| text_mess                                                                                                        |
+------------------------------------------------------------------------------------------------------------------+
| Пользователь Charlene Turner получил 2 сообщ. от пользователя Garnett Kuhn                                       |
+------------------------------------------------------------------------------------------------------------------+



Виктов, вопрос? что делать в нашем случае если наш пользователь получить от других одинаковое кол-во сообщений?=)
Видимо выведет того кто первый попадется?


========================================================================================================================
3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей

Тут с вложенным запросом
SELECT count(l.id) AS All_likes
  FROM likes AS l
       JOIN
            (SELECT *
               FROM profiles AS p
              ORDER BY p.birthday DESC
              LIMIT 10) t1
       ON l.user_id = t1.user_id;

+-------------+
| All_likes   |
+-------------+
|         354 |
+-------------+


SELECT SUM(t1.all_likes) AS all_likes
  FROM
       (SELECT l.user_id, p.birthday, COUNT(l.id) AS all_likes
          FROM likes AS l
               JOIN profiles AS p
               ON l.user_id = p.user_id
         GROUP BY l.user_id, p.birthday
         ORDER BY p.birthday DESC
         LIMIT 10) AS t1;

+-----------+
| all_likes |
+-----------+
|       354 |
+-----------+


========================================================================================================================

4. Определить кто больше поставил лайков (всего) - мужчины или женщины?


SELECT p.sex AS SEX, COUNT(l.id) AS all_likes
  FROM likes AS l
       JOIN profiles AS p
       ON l.user_id = p.user_id
 GROUP BY p.sex;


========================================================================================================================

5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной
сети

В шестом уроке сделал

SELECT
    CONCAT(first_name,' ',last_name) AS user_name
     ,(l.all_likes/TIMESTAMPDIFF(MONTH , created_at , NOW())) AS 'like/month'
     ,(m.all_message/TIMESTAMPDIFF(MONTH , created_at , NOW()) ) AS 'messages/month'
     ,(m2.all_media/TIMESTAMPDIFF(MONTH , created_at , NOW()))  AS 'media/month'
     ,(com.all_comm/TIMESTAMPDIFF(MONTH , created_at , NOW())) AS 'comment/month'
     ,((l.all_likes/TIMESTAMPDIFF(MONTH , created_at , NOW()))+
       (m.all_message/TIMESTAMPDIFF(MONTH , created_at , NOW()))+
       (m2.all_media/TIMESTAMPDIFF(MONTH , created_at , NOW()))+
       (com.all_comm/TIMESTAMPDIFF(MONTH , created_at , NOW()))) /4 AS AVG_ACT
from users AS u
         LEFT JOIN
     (SELECT user_id, COUNT(target_id)  AS all_likes
      FROM likes
      GROUP BY user_id
     ) AS l
     on u.id = l.user_id
         LEFT JOIN
     (SELECT from_user_id, COUNT(id) AS all_message
      FROM messages
      GROUP BY  from_user_id
     ) AS m
     on u.id = m.from_user_id
         LEFT JOIN
     (SELECT user_id, COUNT(id) all_media
      FROM media
      GROUP BY user_id
     ) AS m2
     on u.id = m2.user_id
         LEFT JOIN
     (SELECT user_id, COUNT(user_id) AS all_comm
      FROM communities_users
      GROUP BY user_id) as com
     on u.id = com.user_id

ORDER BY  AVG_ACT
limit 10;


