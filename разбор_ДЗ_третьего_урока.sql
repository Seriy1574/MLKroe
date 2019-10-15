-- Урок 4
-- CRUD операции

-- 1. Рекомендации по улучшению структуры БД vk

-- 1.1 Проставить внешние ключи

-- 1.2 Добавить индексы

-- 1.3 Применить тип данных ENUM

CREATE TABLE `media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  
  `media_type_id` enum('картинки','видео','музыка') COLLATE utf8_unicode_ci NOT NULL COMMENT 'Тип медиаданным',
  
  `user_id` int(10) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Описание картинки',
  `album_id` int(10) unsigned NOT NULL COMMENT 'Индетефикатор альбома',
  `post_id` int(10) unsigned NOT NULL COMMENT 'Индетефикатор поста, если постится изображение в ленте, иначе пустота',
  `amount_like` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Индетефикатор медиафайла',
  `users_like` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Массив id с пользователями, кому понравилось в формате json',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `album_id` (`album_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_ibfk_3` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)

-- 1.4 Создать таблицу регионов и добавить region_id в профили

DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT PROMARY KEY,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `zip` int(10) DEFAULT NULL
);

-- Применим
CREATE TABLE regions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  parent_id INT unsigned DEFAULT NULL,
  code INT DEFAULT NULL,
  zip INT DEFAULT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

ALTER TABLE profiles ADD COLUMN region_id INT unsigned DEFAULT NULL; 

-- 1.5 Поле name пользователей заменил на более подходящие first_name, last_name

ALTER TABLE users RENAME COLUMN firstname TO first_name;
ALTER TABLE users RENAME COLUMN lastname TO last_name;

-- 1.6 В communities_users нужно поле даты/времени создания строки. Важно знать
-- когда произошло подписание конкретного пользователя.

ALTER TABLE communities_users ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

-- 1.7 Добавить emoji
CREATE TABLE `emoji` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `file` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
);

-- Применим
CREATE TABLE emoji (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  file MEDIUMBLOB NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
);

-- 1.8 Создать таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_communitie_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  important BOOLEAN,
  delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

-- Применим
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  user_id INT UNSIGNED NOT NULL,
  communitie_id INT UNSIGNED NOT NULL,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  important BOOLEAN,
  delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- 1.9 Рассмотреть таблицы дружбы и связи пользователей и групп

CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  important BOOLEAN,
  delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);



-- 2. Варианты реализации лайков

-- 2.1 Рейтинговая система
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  shared INT UNSIGNED NOT NULL,
  likes INT UNSIGNED NOT NULL
);

-- 2.2 Одна таблица с ENUM
CREATE TABLE `likes` (
      `id` bigint(20) NOT NULL AUTO_INCREMENT,
      `content_type` enum('user','media','messages') NOT NULL,
      `desc_id` int(11) NOT NULL,
      `user_id` bigint(20) unsigned NOT NULL,
      `value` int(11) NOT NULL,
      PRIMARY KEY (`id`),
      KEY `user_id_fk` (`user_id`),
      CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
    );
    
-- 2.3 Отдельная таблица для каждой сущности, которую можно ставить лайки
CREATE TABLE `media_likes` (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
      `user_id` bigint(20) unsigned NOT NULL,
      `media_id` bigint(20) unsigned NOT NULL,
      `value` tinyint(1) DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `media_id` (`media_id`),
      KEY `media_likes_ibfk_1` (`user_id`),
      CONSTRAINT `media_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
      CONSTRAINT `media_likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`user_id`) ON DELETE CASCADE
    );
    
CREATE TABLE `message_likes` (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
      `user_id` bigint(20) unsigned NOT NULL,
      `message_id` int(10) unsigned NOT NULL,
      `value` tinyint(1) DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `user_id` (`user_id`),
      KEY `message_id` (`message_id`),
      CONSTRAINT `message_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
      CONSTRAINT `message_likes_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`)
    );
    
CREATE TABLE `user_likes` (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
      `from_user_id` bigint(20) unsigned NOT NULL,
      `to_user_id` bigint(20) unsigned NOT NULL,
      `value` tinyint(1) DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `from_user_id` (`from_user_id`),
      KEY `to_user_id` (`to_user_id`),
      CONSTRAINT `user_likes_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
      CONSTRAINT `user_likes_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
    );

-- 2.4 Одна таблица, отлельные столбцы для каждого типа лайка
CREATE TABLE likes (
user_id INT UNSIGNED,
media_id INT UNSIGNED,
message_id BIGINT UNSIGNED,
who_put_like_id INT UNSIGNED NOT NULL,
PRIMARY KEY (user_id, media_id, message_id, who_put_like_id)
);


-- 2.5 Вариант с одной таблицей лайков и таблицей получателей лайков

CREATE TABLE `likable_sources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
); 

CREATE TABLE `likes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `liked_source_type` int(10) unsigned NOT NULL,
  `liked_source_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
);

-- Соответствует третьей нормальной форме
-- Легко расширяется
-- Легко организовать проверку допустимых значений
-- Легко получить все допустимые варианты

-- Немного изменим и применим
-- Таблица лайков
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- 3. CRUD операции
-- INSERT
-- Однострочная и многострочная вставка
SHOW TABLES;
DESC target_types;

SELECT * FROM target_types;

-- Вставим первую строку
INSERT INTO target_types VALUES (1, 'media', NOW());

-- Проверка уникальности
INSERT INTO target_types (name) VALUES ('media');

-- Используем ключевое слово DEFAULT
INSERT INTO target_types VALUES (DEFAULT, 'post', NOW());

INSERT INTO target_types (name) VALUES ('newsline'), ('user');

SELECT * FROM target_types;

-- Игнорируем ошибки
INSERT IGNORE INTO target_types (name) VALUES ('media');

-- Используем SET
-- SET указывает на имена столбцов явно
INSERT INTO target_types SET name = 'community';

-- REPLACE копия INSERT IGNORE 
-- REPLACE имеет смысл, только если у таблицы есть PRIMARY KEY или индекс UNIQUE. 
-- Иначе это становится эквивалентным INSERT, потому что нет индекса, чтобы определить, 
-- дублирует ли новая строка другую.
REPLACE INTO target_types (name) VALUES ('community');

-- SELECT
-- вывод определённых столбцов
-- *
SELECT * FROM target_types;

-- ALL
SELECT ALL * FROM target_types;

-- DISTINCT
SELECT DISTINCT * FROM target_types;
SELECT YEAR(created_at) FROM target_types;
SELECT DISTINCT YEAR(created_at) FROM target_types;

-- LIMIT
SELECT ALL * FROM target_types LIMIT 1;

-- Обновление данных
-- UPDATE
UPDATE target_types SET id = id * 10;

-- Обновление по условию
UPDATE target_types SET name = 'group' WHERE name = 'community';

-- Используем IGNORE
UPDATE target_types SET name = 'group' WHERE name = 'user';
UPDATE IGNORE target_types SET name = 'group' WHERE name = 'user';

-- Просмотр предупреждений
SHOW WARNINGS;

-- Удаление строк
-- DELETE
-- Удаление по условию
DELETE FROM target_types WHERE name = 'group';

-- Удаление и LIMIT
DELETE FROM target_types LIMIT 1;

-- Удалить все записи
DELETE FROM target_types;

-- И смотрим счётчик
INSERT INTO target_types VALUES (DEFAULT, 'media', NOW());

-- TRUNCATE
TRUNCATE target_types;

-- Сбрасывает счётчики, проверим
INSERT INTO target_types VALUES (DEFAULT, 'media', NOW());

-- Когда Вы не должны знать число удаленных строк, TRUNCATE TABLE более быстрый способ 
-- освободить таблицу, чем DELETE без WHERE

MySQL8 на русском
http://www.rldp.ru/mysql/mysql80/index.htm