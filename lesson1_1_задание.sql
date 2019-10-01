1. Добавить необходимые внешние ключи для всех таблиц базы данных vk (приложить команды).

-- profiles- users
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
         ON DELETE CASCADE;
-- profiles- regions

ALTER TABLE profiles
    ADD CONSTRAINT profiles_region_id_fk
        FOREIGN KEY (region_id) REFERENCES regions(id)
             ON DELETE CASCADE;

--  media- media_tupes


ALTER TABLE media
    ADD CONSTRAINT media_type_id_fk
        FOREIGN KEY (media_type_id) REFERENCES media_types(id)
             ON DELETE CASCADE;

-- likes- users

ALTER TABLE likes
    ADD CONSTRAINT user_id_fk
        FOREIGN KEY (user_id) REFERENCES users(id)
             ON DELETE CASCADE;


-- likes- target_types

ALTER TABLE likes
    ADD CONSTRAINT target_type_id_fk
        FOREIGN KEY (target_type_id) REFERENCES target_types(id)
             ON DELETE CASCADE;

-- profiles.photo- media
ALTER TABLE profiles
    ADD CONSTRAINT profiles_photo_id_fk
        FOREIGN KEY (photo_id) REFERENCES media(id)
            ON DELETE SET NULL;


-- media - users

ALTER TABLE media
    ADD CONSTRAINT user_id_fk2
        FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE;


-- messages- users

ALTER TABLE messages
    ADD CONSTRAINT user_id_fk_to
        FOREIGN KEY (to_user_id) REFERENCES users(id)
            ON DELETE CASCADE,
    ADD CONSTRAINT user_id_fk_from
        FOREIGN KEY (from_user_id) REFERENCES users(id)
            ON DELETE CASCADE;

-- communitises_users - communities

ALTER TABLE communities_users
    ADD CONSTRAINT comminty_id_fk
        FOREIGN KEY (community_id) REFERENCES communities(id)
            ON DELETE CASCADE;

-- communitises_users - users
ALTER TABLE communities_users
    ADD CONSTRAINT comminty_id_fku
        FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE;

-- profiles- hometowns
ALTER TABLE profiles
    ADD CONSTRAINT profiles_htown_id_fk
        FOREIGN KEY (hometown_id) REFERENCES hometowns(id)
            ON DELETE CASCADE;
тут был разный тип, долго не мог найти в чем проблема, изменил тип
ALTER TABLE profiles MODIFY hometown_id INT unsigned not null ;


-- таблицы дружбы

ALTER TABLE friendship
    ADD CONSTRAINT status_id_fk
        FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
            ON DELETE CASCADE,
    ADD CONSTRAINT user_id_fr_fk
        FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE,
    ADD CONSTRAINT friend_id_fr_fk
        FOREIGN KEY (friend_id) REFERENCES users(id)
            ON DELETE CASCADE;

--таблица регионов
ALTER TABLE regions
    ADD CONSTRAINT region_id_fk
        FOREIGN KEY (parent_id) REFERENCES regions(id)
            ON DELETE CASCADE;

========================================================================================================================

3. Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).




========================================================================================================================

4. (необязательно) Скорректировать запросы из урока (перечислены ниже) в части правильного подсчёта.
"Количество друзей у пользователя с сортировкой" и "Количество друзей у пользователя (статус - активный) с сортировкой"

Я не совсем понял логику вашего запроса, но мне на ум пришло следующее решение:


SELECT t.user, t.first_name, t.last_name, SUM(t.all_friends) AS total_friends
  FROM
       (SELECT f.user_id AS user, u1.first_name, u1.last_name, COUNT(friend_id) AS all_friends
          FROM friendship AS f
               JOIN users AS u1
               ON u1.id = f.user_id
         WHERE f.status_id = 1 AND f.user_id = 863
         GROUP BY f.user_id

 UNION ALL

        SELECT f.friend_id AS user, u2.first_name, u2.last_name, COUNT(user_id) all_friends
          FROM friendship AS f
               JOIN users AS u2
               ON u2.id = f.friend_id
         WHERE f.status_id = 1 AND f.friend_id = 863
         GROUP BY f.friend_id) AS t
 GROUP BY t.user, t.first_name, t.last_name
 ORDER BY total_friends DESC;

/*Виктор, на вебинаре я обратил внимание на группировку. В случае если не указать t.first_name, t.last_name, группировка не работает */

Осмелюсь предположить , что таким способом который был на уроке мы не сможем получить данные
Мысли следующие: JOINы- по сути поиск и подстановка данных в имеющююся таблицу по какому то условию.
И мы получаем кол-во строк, которые и считаем.

Убрав агрегацю, этим способом, я получил следующий результат

+-----+------------+-----------+-------------------------------+---------------------+---------------------+---------------------+---------+-----------+-----------+---------+-----------+-----------+
| id  | first_name | last_name | email                         | phone               | created_at          | updated_at          | user_id | friend_id | status_id | user_id | friend_id | status_id |
+-----+------------+-----------+-------------------------------+---------------------+---------------------+---------------------+---------+-----------+-----------+---------+-----------+-----------+
| 863 | Jacynthe   | Brekke    | kautzer.cassandra@example.org | (894)357-5018x68134 | 1987-02-17 00:45:28 | 1987-02-17 00:45:28 |     863 |       722 |         1 |     356 |       863 |         1 |
| 863 | Jacynthe   | Brekke    | kautzer.cassandra@example.org | (894)357-5018x68134 | 1987-02-17 00:45:28 | 1987-02-17 00:45:28 |     863 |       722 |         1 |     519 |       863 |         1 |
+-----+------------+-----------+-------------------------------+---------------------+---------------------+---------------------+---------+-----------+-----------+---------+-----------+-----------+

Агрекация считает кол-во записей, группируя по id

+-----+------------+-----------+---------------+
| id  | first_name | last_name | total_friends |
+-----+------------+-----------+---------------+
| 863 | Jacynthe   | Brekke    |             2 |
+-----+------------+-----------+---------------+

