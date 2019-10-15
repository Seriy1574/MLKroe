проверил сколько таких
SELECT u.*, u.created_at > u.updated_at FROM users AS u
WHERE u.created_at > u.updated_at = 1;

создал таблицу чтоб по ней удалить
CREATE TABLE del AS
SELECT u.id FROM users AS u
WHERE u.created_at > u.updated_at = 1;


апдейтил
UPDATE users
SET updated_at = created_at
WHERE id IN (SELECT id FROM del
                     );
так не отработало
UPDATE users
SET updated_at = created_at
WHERE id IN (SELECT u.id FROM users AS u
             WHERE u.created_at > u.updated_at = 1);


SELECT u.*, u.created_at = u.updated_at FROM users AS u ;

TRUNCATE TABLE media_typesж
INSERT INTO media_types (id, name) VALUES
(1, 'Фото'),
('2', 'Видео'),
и т.д.

------------+------------------+------+-----+-------------------+-----------------------------------------------+
| Field      | Type             | Null | Key | Default           | Extra                                         |
+------------+------------------+------+-----+-------------------+-----------------------------------------------+
| id         | int(10) unsigned | NO   | PRI | NULL              | auto_increment                                |
| first_name | varchar(100)     | NO   |     | NULL              |                                               |
| last_name  | varchar(100)     | NO   |     | NULL              |                                               |
| email      | varchar(120)     | NO   | UNI | NULL              |                                               |
| phone      | varchar(120)     | NO   | UNI | NULL              |                                               |
| created_at | datetime         | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
| updated_at | datetime         | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
                                                                                            +------------+------------------+------+-----+-------------------+-----------------------------------------------+
