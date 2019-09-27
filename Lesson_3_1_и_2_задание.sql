Виктор приветствую!

1. Проанализоровать структуру БД vk, которую мы создали на занятии, и внести предложения по усовершенствованию (если такие идеи есть). Напишите пожалуйста, всё-ли понятно по структуре.

По структуре все понятно. Единственное что не понял это PRIMARY KEY (user_id, friend_id) в таблице friendship и PRIMARY KEY (community_id, user_id) в таблице communities_users, мы их прописали, но по факту столбцы не создались в таблицах. может быть я что то не правильно сделал?)
 
Предложения:
1. таблица users. я бы вынеоставил в этой таблице только id и created_at и добавил дату блокировки user

CREATE TABLE users
 (

  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  created_at DATETIME DEFAULT NOW()
  block_dt DATETIME DEFAULT NOW() ON UPDATE NOW() -- дата блокировки user
 );



2. таблица profiles. Сюда бы добавил данные из таблицы users

CREATE TABLE profiles
 (

  user_id INT UNSIGNED NOT NULL PRIMARY KEY,

  firstname VARCHAR(100) NOT NULL,

  lastname VARCHAR(100) NOT NULL,

  email VARCHAR(120) NOT NULL UNIQUE,

  phone VARCHAR(120) NOT NULL UNIQUE,

  sex CHAR(1) NOT NULL,

  birthday DATE,

  hometown VARCHAR(100),

  photo_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW(),
--значение равно значению created_at из таблицы users
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),

  id_type_upd VARCHAR(100) NOT NULL-- id типа изменений в профиле
    );

Причем, каждое изменение как-то должно записаться новой строкой в таблице, для историчности(наверное)=))

3. добавил бы таблицу типа изменнеий профиля(изменено имя, телефон и т.д.)

CREATE TABLE type_update
 (

  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  name VARCHAR(20) NOT NULL UNIQUE

);




2. Добавить необходимую таблицу/таблицы для того, чтобы можно было использовать лайки для медиафайлов, постов и пользователей.

Лайки медиа

CREATE TABLE likes_media
 (

  id_like INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  liker_id INT UNSIGNED NOT NULL,
  media_id INT UNSIGNED NOT NULL,
  date_like DATETIME DEFAULT NOW(),
  type_like INT UNSIGNED NOT NULL--лайк, дизлайк
  );

таблица типов лайков
CREATE TABLE type_likes
 (

  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  name VARCHAR(20) NOT NULL UNIQUE--лайк, дизлайк
  );

лайки поостов.

Сначала создаем таблицу постов

CREATE TABLE posts
 (

  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 
 user_id INT UNSIGNED NOT NULL,

  body TEXT NOT NULL,

  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()

 );

CREATE TABLE likes_posts
 (

  id_like INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  liker_id INT UNSIGNED NOT NULL,
  post_id INT UNSIGNED NOT NULL,
  date_like DATETIME DEFAULT NOW(),
  type_like INT UNSIGNED NOT NULL--лайк, дизлайк );

Лайк пользователей что то я не понимаю что это такое, не видел ни разу с соцсетях, хотя может быть и есть такое, я ими не пользуюсяь как то. Но суть такктя же как и лайки медиа и постов.