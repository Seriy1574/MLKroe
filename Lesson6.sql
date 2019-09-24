
Виктор, приветствую.


1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения
(JOIN пока не применять).

По этой задаче все понятно.

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


Везде где where like, заменил бы слова на id.

Да и как писал в чате, появляются проблемы, если id не уникальны.


=========================================================================================================================

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

========================================================================================================================
3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей




/*тут обернул SELECT  в еще один SELECT , чтою сработал LIMIT 10*/

SELECT COUNT(id) AS All_likes
 FROM likes AS l
 WHERE l.user_id IN
  SELECT * FROM (SELECT user_id
    FROM profiles
    ORDER BY (TO_DAYS(NOW()) - TO_DAYS(birthday))/365.25
    limit 10)t2);

+-----------+
| All_likes |
+-----------+
|       354 |
+-----------+

========================================================================================================================

4. Определить кто больше поставил лайков (всего) - мужчины или женщины?


SELECT t.SEX, COUNT(user_id) AS all_likes
from(
    (SELECT l.user_id, 'm' AS SEX
        FROM likes AS l
        WHERE l.user_id IN
             (SELECT user_id
                 FROM profiles AS p
                 WHERE p.sex like 'm'))
     UNION ALL
    (SELECT l.user_id, 'f' AS SEX
        FROM likes AS l
        WHERE l.user_id IN
              (SELECT user_id
                  FROM profiles AS p
                  WHERE p.sex like 'f'))) AS t
GROUP BY t.SEX ;


========================================================================================================================

5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной
сети

я взял лаайки, сообщения, загруженное медиа, и сообщества. По хорошему так конечно никто не делает)))
но получилось так)))

SELECT
       CONCAT(first_name,' ',last_name) AS user_name
       ,if(l.all_likes IS NULL, 0, l.all_likes/TIMESTAMPDIFF(MONTH , created_at , NOW())) AS 'like/month'
       ,if(m.all_message IS NULL, 0, m.all_message/TIMESTAMPDIFF(MONTH , created_at , NOW()) ) AS 'messages/month'
       ,if(m2.all_media IS NULL, 0,m2.all_media/TIMESTAMPDIFF(MONTH , created_at , NOW()))  AS 'media/month'
       ,if(com.all_comm IS NULL, 0, com.all_comm/TIMESTAMPDIFF(MONTH , created_at , NOW())) AS 'comment/month'
       ,(if(l.all_likes IS NULL, 0, l.all_likes/TIMESTAMPDIFF(MONTH , created_at , NOW()))+
       if(m.all_message IS NULL, 0, m.all_message/TIMESTAMPDIFF(MONTH , created_at , NOW()))+
       if(m2.all_media IS NULL, 0,m2.all_media/TIMESTAMPDIFF(MONTH , created_at , NOW()))+
       if(com.all_comm IS NULL, 0, com.all_comm/TIMESTAMPDIFF(MONTH , created_at , NOW()))) /4 AS AVG_ACT
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



Как-то все громоздко получается. В челом- все понятно

про partition by кейс пока не придумал)))
