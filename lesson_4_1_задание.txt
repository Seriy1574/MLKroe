Виктор приветствую!

1. Повторить все действия по корректировке БД, которые выполнялись на занятии.
На ваше усмотрение, но рекомендуется - привести свои версии БД к общему виду, в соответствии с кодом в examples.sql по третьему и четвёртому урокам.

Я сначала удалил все таблицы из базы

Создал новые таблицы с учетом корректировок на уроке.

--создал таблицу users

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

--изменил названия столбцов таблице users

--ALTER TABLE users RENAME COLUMN firstname TO first_name;
--ALTER TABLE users RENAME COLUMN lastname TO last_name;

--создал таблицу профиля

CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  hometown VARCHAR(100),
  photo_id INT UNSIGNED NOT NULL
  region_id INT unsigned DEFAULT NULL
);

--добавил столбец регион в таблицу profiles

--ALTER TABLE profiles ADD COLUMN region_id INT unsigned DEFAULT NULL;


--добавил таблицу регионов

CREATE TABLE regions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  parent_id INT unsigned DEFAULT NULL,
  code INT DEFAULT NULL,
  zip INT DEFAULT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

--добавил таблицу эмоджи

CREATE TABLE emoji (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  file MEDIUMBLOB NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
);

--добавил таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_communitie_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  important BOOLEAN,
  delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);


--добавил таблицу групп
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


--добавил таблицу связи пользователей и групп

CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (community_id, user_id)
);

--добавил времемя вступления в группу

--ALTER TABLE communities_users ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

--добавил таблицу медиафайлов

CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--добавил таблицу типов медиафайлов

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

--добавил таблицу лайков
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

--добавил таблицу типов лайков

CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

--добавил таблицу сообщений

CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  important BOOLEAN,
  delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

--добавил таблицу дружбы

CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


Вот что получилось, все таблицы созданы, данные сгенерировал заново, дамп приложу.

mysql> show tables;
+---------------------+
| Tables_in_VK        |
+---------------------+
| communities         |
| communities_users   |
| emoji               |
| friendship          |
| friendship_statuses |
| likes               |
| media               |
| media_types         |
| messages            |
| regions             |
| target_types        |
| users               |
+---------------------+

