Виктор, приветствую!



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


--
========================================================================================================================


2. Задание на денормализацию
Разобраться как построен и работает следующий запрос:
Список медиафайлов пользователя с количеством лайков
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
Правильно-ли он построен?
Какие изменения, включая денормализацию, можно внести в структуру БД
чтобы существенно повысить скорость работы этого запроса?


========================================================================================================================
3. Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группе
самый молодой пользователь в группе
самый пожилой пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
