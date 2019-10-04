

Виктор приветствую!!! поправил  ошибки в логике формирования запросов

--Второй запрос.

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


3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей

Два решения, с сотрировку возраста добавил сотритовку по user_id, чтоб данные в подзапросах получались одинаковые
а то у меня много "ровестников")) получилось и каждый раз при запуске запроса, разное кол-во лайков получается


1.
SELECT COUNT(l.id) AS all_likes
  FROM likes AS l
       JOIN
           (SELECT *
              FROM profiles AS p
             ORDER BY p.birthday DESC, p.user_id
             LIMIT 10) as t1
         ON l.target_id = t1.user_id
        AND l.target_type_id = 1;


2.
SELECT SUM(t.liles) AS all_likes
  FROM
    (SELECT p.user_id, p.birthday, COUNT(l.id) AS liles
       FROM likes AS l
            JOIN profiles AS p
              ON l.target_id = p.user_id
             AND l.target_type_id = 1
      GROUP BY p.user_id, p.birthday
      ORDER BY p.birthday DESC,  p.user_id
      LIMIT 10) AS t;

