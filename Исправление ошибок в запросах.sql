

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

