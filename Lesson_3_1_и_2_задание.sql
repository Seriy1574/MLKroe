������ �����������!

1. ���������������� ��������� �� vk, ������� �� ������� �� �������, � ������ ����������� �� ������������������ (���� ����� ���� ����). �������� ����������, ��-�� ������� �� ���������.

�� ��������� ��� �������. ������������ ��� �� ����� ��� PRIMARY KEY (user_id, friend_id) � ������� friendship � PRIMARY KEY (community_id, user_id) � ������� communities_users, �� �� ���������, �� �� ����� ������� �� ��������� � ��������. ����� ���� � ��� �� �� ��������� ������?)
 
�����������:
1. ������� users. � �� ����������� � ���� ������� ������ id � created_at � ������� ���� ���������� user

CREATE TABLE users
 (

  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  created_at DATETIME DEFAULT NOW()
  block_dt DATETIME DEFAULT NOW() ON UPDATE NOW() -- ���� ���������� user
 );



2. ������� profiles. ���� �� ������� ������ �� ������� users

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
--�������� ����� �������� created_at �� ������� users
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),

  id_type_upd VARCHAR(100) NOT NULL-- id ���� ��������� � �������
    );

������, ������ ��������� ���-�� ������ ���������� ����� ������� � �������, ��� ������������(��������)=))

3. ������� �� ������� ���� ��������� �������(�������� ���, ������� � �.�.)

CREATE TABLE type_update
 (

  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  name VARCHAR(20) NOT NULL UNIQUE

);




2. �������� ����������� �������/������� ��� ����, ����� ����� ���� ������������ ����� ��� �����������, ������ � �������������.

����� �����

CREATE TABLE likes_media
 (

  id_like INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  liker_id INT UNSIGNED NOT NULL,
  media_id INT UNSIGNED NOT NULL,
  date_like DATETIME DEFAULT NOW(),
  type_like INT UNSIGNED NOT NULL--����, �������
  );

������� ����� ������
CREATE TABLE type_likes
 (

  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

  name VARCHAR(20) NOT NULL UNIQUE--����, �������
  );

����� �������.

������� ������� ������� ������

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
  type_like INT UNSIGNED NOT NULL--����, ������� );

���� ������������� ��� �� � �� ������� ��� ��� �����, �� ����� �� ���� � ��������, ���� ����� ���� � ���� �����, � ��� �� ���������� ��� ��. �� ���� ������ �� ��� � ����� ����� � ������.