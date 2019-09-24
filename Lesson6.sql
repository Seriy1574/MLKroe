
2. Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим
пользоваетелем.

ПОльзователь id = 648

--Подсчет кто больше писал пользователю

SELECT m.to_user_id, m.from_user_id, count(m.id) all_messages
 FROM messages m
 where m.to_user_id = 648 and m.from_user_id in
       (SELECT friend_id
         FROM friendship
         WHERE status_id in
               (SELECT id
                 FROM friendship_statuses
                  WHERE id = 1) )
GROUP BY m.to_user_id, m.from_user_id
ORDER BY all_messages DESC
LIMIT 1;
+------------+--------------+--------------+
| to_user_id | from_user_id | all_messages |
+------------+--------------+--------------+
|        648 |          335 |            3 |
+------------+--------------+--------------+

а тут жесть у меня)))))))))))))))))


SELECT CONCAT(
(SELECT CONCAT('Пользователь ',first_name, ' ',last_name, ' получил от пользователя ')
    from users u where id =
(SELECT t1.to_user_id from (SELECT m.to_user_id, m.from_user_id, count(m.id) all_messages
FROM messages m
where m.to_user_id = 648 and m.from_user_id in
   (SELECT friend_id
     FROM friendship
     WHERE status_id in
     (SELECT id
       FROM friendship_statuses
       WHERE id = 1) )
GROUP BY m.to_user_id, m.from_user_id
ORDER BY all_messages DESC
LIMIT 1) t1)),

(SELECT CONCAT(first_name, ' ',
last_name, ' ')
 from users u where id =
 (SELECT t2.from_user_id from (SELECT m.to_user_id, m.from_user_id, count(m.id) all_messages
   FROM messages m
   where m.to_user_id = 648 and m.from_user_id in
    (SELECT friend_id
     FROM friendship
      WHERE status_id in
      (SELECT id
       FROM friendship_statuses
        WHERE id = 1) )
        GROUP BY m.to_user_id, m.from_user_id
        ORDER BY all_messages DESC
        LIMIT 1) t2)),

(SELECT count(m.id) all_messages
 FROM messages m
 where m.to_user_id = 648 and m.from_user_id in
  (SELECT friend_id
    FROM friendship
    WHERE status_id in
     (SELECT id
       FROM friendship_statuses
       WHERE id = 1) )
       GROUP BY m.to_user_id, m.from_user_id
       ORDER BY all_messages DESC
       LIMIT 1),
    ' сообщ.'

    );
+---------------------------------------------------------------------------------------------
| Пользователь Christelle Pfannerstill получил от пользователя Winfield Rau 3 сообщ.                                                                                                                                                                               |
+---------------------------------------------------------------------------------------------

--c джойном красивее получается)
SELECT CONCAT
    ('Пользователь ',u1.first_name,' ',u1.last_name,' получил ',t1.all_mess,' сообщ. от пользователя ',u2.first_name,' ',u2.last_name)
from
     (SELECT m.to_user_id, m.from_user_id, count(m.id) all_mess
     FROM messages m
     where m.to_user_id = 648
     group by m.to_user_id, m.from_user_id
     order by all_mess DESC
     LIMIT 1) t1
         join users u1
             on u1.id = t1.to_user_id
         join users u2
             on u2.id = t1.from_user_id;
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Пользователь Christelle Pfannerstill получил 3 сообщ. от пользователя Winfield Rau                                                                                                  |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+


3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей

SELECT * FROM profiles;

SELECT user_id, (TIMESTAMPDIFF(YEAR, birthday  NOW())) AS age
FROM profiles;
DESCRIBE profiles;


+---------------------+
| Tables_in_VK        |
+---------------------+
| communities         |
| communities_users   |
| emoji               |
| friendship          |
| friendship_statuses |
| hometowns           |
| likes               |
| media               |
| media_types         |
| messages            |
| profiles            |
| regions             |
| target_types        |
| users               |
+---------------------+
