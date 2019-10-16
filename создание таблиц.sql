--1. Создание БД

CREATE DATABASE mobile_collection;

--Создание таблиц
--таблицы создавал пока без связей с другими таблицами и без индексов, т.к. сcоздвал базу "из головы"

--таблица профиля сотрудников. таблица заполняется где то там в отделе кадров, после изменений данных сотрудника в этой таблице, данные будут меняться в таблице employee, для историчности

CREATE TABLE profiles_employeers
(
    id           SERIAL,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    patronymic   VARCHAR(50) NOT NULL,
    birthday     DATETIME DEFAULT NULL,
    id_region    INT UNSIGNED NOT NULL,
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    block        BOOLEAN,
    date_block   DATETIME DEFAULT NULL,
    id_pozition INT unsigned DEFAULT NULL,
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

ALTER TABLE profiles_employeers ADD COLUMN group_id INT UNSIGNED NOT NULL;


    --таблица сотрудника, в ней будет информация по изменениям у сотруднников

CREATE TABLE employees
(
    id           INT UNSIGNED NOT NULL,
    ds           DATETIME NOT NULL ,
    df           DATETIME DEFAULT NULL,
    id_group     INT UNSIGNED NOT NULL,
    id_pozition  INT UNSIGNED NOT NULL

);

