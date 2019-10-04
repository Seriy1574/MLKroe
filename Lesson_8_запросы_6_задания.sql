
Виктор, приветствую!

Запросы шестого задания

=========================================================================================================================

2. Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим
пользоваетелем.

Пользователь id = 648


SELECT CONCAT(u2.first_name, ' ',u2.last_name, ' ','send ', t2.all_mess,  ' message/es', ' ' ,u1.first_name, ' ',u1.last_name, '!') AS text
FROM
    (SELECT t.id, t.id_fr, COUNT(*) AS all_mess
     FROM
         (SELECT f.user_id AS id, f.friend_id AS id_fr
          FROM friendship AS f
          WHERE f.user_id = 648
            AND f.status_id = 1

          UNION

          SELECT f2.friend_id AS id, f2.user_id AS id_fr
          FROM friendship AS f2
          WHERE f2.friend_id = 648
            AND f2.status_id = 1) AS t
             JOIN messages AS m
                  ON m.from_user_id = t.id_fr
                      AND m.to_user_id = t.id

     GROUP BY t.id, t.id_fr
     ORDER BY all_mess DESC
     LIMIT 1) t2
        JOIN users AS u1
             ON u1.id = t2.id
        JOIN users AS u2
             ON u2.id = t2.id_fr;

+---------------------------------------------------------+
| text                                                    |
+---------------------------------------------------------+
| Winfield Rau send 3 message/es Christelle Pfannerstill! |
+---------------------------------------------------------+



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

В шестом уроке сделал.


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

