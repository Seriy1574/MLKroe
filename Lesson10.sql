Виктор, приветствую!

Второе  задание не сделал. нет времени.

1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.


--Таблица users, как Вы сказалии  на уроке, важный индекс, email используется для авторизации?  + уникальность email
    CREATE INDEX users_email_idx ON users(email);


--таблица communities- индексы не нужны + уже есть первичный ключ.


--таблица communities_users- индекс id попльзователя, пользователь должен постоянно видеть свои группы и индекс по дате- больше для аналитики, чтоб вести статистику вступления в группу
    CREATE INDEX communities_user_id_idx ON communities_users(user_id);
    CREATE INDEX communities_created_at_idx ON communities_users(created_at);


--таблица friendship- у нас есть первичный составной ключ user_id+friend_id пользователь должен видеть своих друзей, я хотел изменить порядок в составном ключе
     ALTER TABLE friendship DROP PRIMARY KEY, ADD PRIMARY KEY(friend_id, user_id);
получил ошибку
ERROR 1553 (HY000): Cannot drop index 'PRIMARY': needed in a foreign key constraint

Решил создать индекс friend_id
     CREATE INDEX friendship_friend_id_idx ON friendship(friend_id);


--таблица friendship_ststus- индексы не нужны, есть первичный ключ


--таблица  hometowns - индексы не нужны, есть первичный ключ


--таблица likes  т.к. у каждого пользователя, на каждом файле свои лайки используем составной индекс target_type_id+target_id+user_id и индекс для аналитики user_id+target_type_id+created_at
CREATE INDEX likes_tti_ti_ui_idx ON likes(target_type_id,target_id,user_id);
CREATE INDEX likes_ui_ti_ca_idx ON likes(user_id,target_type_id,created_at);

--таблица media у пользователя всегда должны быть сгруппированные по группам медиафайлы индекс user_id+media_type_id плюс составной индекс по дате добавления b bpvtytybz

CREATE INDEX media_ui_mt_idx ON media(user_id, media_type_id);
CREATE INDEX media_ca_ua_idx ON media(created_at, updated_at);


--таблица media_types индексы не нужны, есть первичный ключ

--таблица profiles  индекасы не нужны, есть первичный ключ, данные из таблицы чаще ищутся в других таблицах


--таблица regions - есть первичный ключ и  индекс на perent_id

CREATE INDEX regions_parent_id_idx ON regions(parent_id);

========================================================================================================================
Тут я не совсем понял как уложить в один запрос это, в планен визуализации

3. на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группе
SELECT AVG(av.all_users_in_group)
FROM
     (SELECT DISTINCT c.name,
                      COUNT(cu.user_id) OVER(PARTITION BY c.name) all_users_in_group

      FROM communities c
           JOIN communities_users cu
             ON c.id = cu.community_id) av;

без оконной проще запрос быб бы

самый молодой пользователь в группе
самый пожилой пользователь в группе

SELECT c.name,
       t2.yang,
       t3.old
  FROM communities c
       LEFT JOIN
           (SELECT t.name, t.yang
              FROM
                   (SELECT DISTINCT c.name,
                                    CONCAT(u.first_name,' ', u.last_name) yang ,
                                    ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY p.birthday) RN
                     FROM communities c
                          JOIN communities_users cu
                            ON c.id = cu.community_id
                               JOIN profiles p
                                 ON cu.user_id = p.user_id
                                    JOIN users u
                                      ON cu.user_id = u.id) t
            WHERE t.RN = 1) t2
         ON  c.name = t2.name
        LEFT JOIN
                  (SELECT t.name,
                          t.old
                     FROM
                          (SELECT DISTINCT c.name,
                                           CONCAT(u.first_name,' ', u.last_name) old,
                                           ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY p.birthday DESC) RN
                             FROM communities c
                                  JOIN communities_users cu
                                    ON c.id = cu.community_id
                                       JOIN profiles p
                                         ON cu.user_id = p.user_id
                                            JOIN users u
                                              ON cu.user_id = u.id) t
                   WHERE t.RN = 1) t3
                      ON c.name = t3.name;


общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

SELECT DISTINCT c.name,
                COUNT(cu.user_id) OVER(PARTITION BY c.name) all_users_in_group,
                CONCAT(ROUND(COUNT(cu.user_id) OVER(PARTITION BY c.name)/COUNT(cu.user_id)OVER()*100, 2),'%') share

 FROM communities c
      JOIN communities_users cu on c.id = cu.community_id;