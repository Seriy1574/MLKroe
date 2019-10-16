﻿--1. Создание БД

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
    id_pozition  INT unsigned DEFAULT NULL,
    updated_at   DATETIME DEFAULT NOW() ON UPDATE NOW()
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

--таблица групп пользователей. подразделение где работает сотрудник
тут записи можно добавлять и удалять при открытии или закрытии нового подразделения

CREATE TABLE groups_employees
(
    id        SERIAL,
    ds        DATETIME NOT NULL ,
    df        DATETIME DEFAULT NULL,
    id_parent INT UNSIGNED NOT NULL
);

--таблица позиций, позиции на которых сотрудник работает(специалист, старший специалист и.т.) тут записи можно добавлять и редактировать

CREATE TABLE positions
(
    id  SERIAL,
   name VARCHAR(30) not null
);

--таблица регионов тут записи можно добавлять и редактировать

CREATE TABLE regions
(
    id        SERIAL,
    name      VARCHAR(50),
    id_parent INT UNSIGNED default NULL
);

--таблица активностей сотрудников

CREATE TABLE actions_employees
(
    id               SERIAL,
    id_client        INT UNSIGNED NOT NULL,
    id_employee      INT UNSIGNED NOT NULL,
    id_type_action   INT UNSIGNED NOT NULL,
    id_result_action INT UNSIGNED NOT NULL,
    date_action      DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_promise       INT UNSIGNED NOT NULL
);

--таблица типа контакта(на какой номер звонил или на какой адрес выезжал)

CREATE TABLE contacts
(
    id              SERIAL,
    id_type_contact INT UNSIGNED NOT NULL
);

--таблица типа активности(звонок, выезд, письмо и.т.д.)

CREATE TABLE types_actions
(
    id   SERIAL,
    name VARCHAR(50)
);

--таблица результата активности сотрудника данные добавляются из приложения

CREATE TABLE results_actions
(
   id   SERIAL,
   name VARCHAR(20) NOT NULL
);

--таблица с контактной информацией сотрудника
CREATE TABLE contacts_employees
(
   id           SERIAL,
   id_employee  INT UNSIGNED       NOT NULL,
   phone_number VARCHAR(20),
   email        VARCHAR(50) UNIQUE NOT NULL
);

--таблица клиентов тут записи можно добавлять
CREATE TABLE clients
(
    id               SERIAL,
    first_name       VARCHAR(20) NOT NULL,
    last_name        VARCHAR(20) NOT NULL,
    patronymic       VARCHAR(20) NOT NULL,
    passport         VARCHAR(20) NOT NULL
);

--таблица телефонов клиентов

CREATE TABLE phones_clients
(
    id        SERIAL,
    id_client INT UNSIGNED NOT NULL,
    number    VARCHAR(50),
    actual    BOOLEAN      NOT NULL
);
ALTER TABLE phones_clients ADD COLUMN id_type_phone INT UNSIGNED NOT NULL;

--таблица типов телефонов

CREATE TABLE types_phones
(
    id   SERIAL,
    name VARCHAR(20) NOT NULL
);

--таблица адресов клиента

CREATE TABLE addresses_clients
(
    id        SERIAL,
    id_client INT UNSIGNED NOT NULL,
    country   VARCHAR(30),
    region    VARCHAR(120),
    city      VARCHAR(120),
    street    VARCHAR(120),
    house     VARCHAR(10),
    flat      VARCHAR(10),
    id_type   INT UNSIGNED NOT NULL,
    actual    BOOLEAN
);

---тип адреса

CREATE TABLE types_adresses
(
    id   SERIAL,
    name VARCHAR(20) NOT NULL
);

----таблица кредитов

CREATE TABLE accounts
(
    id              SERIAL,
    number_count    VARCHAR(50),
    id_client       INT UNSIGNED NOT NULL,
    id_type_product INT UNSIGNED NOT NULL,
    sum_credit      FLOAT NOT NULL,
    date_credit     DATETIME NOT NULL,
    credit_term     INT UNSIGNED NOT NULL,
    dpd             INT UNSIGNED NOT NULL
);

ALTER TABLE accounts ADD COLUMN id_bank INT UNSIGNED NOT NULL;

--таблица банков
CREATE TABLE banks
(
    id   SERIAL,
    name VARCHAR(20) NOT NULL
);

--таблица типов кредитов

CREATE TABLE types_products
(
    id   SERIAL,
    name VARCHAR(20) NOT NULL
);

---таблица платежей

CREATE TABLE payments
(
    id SERIAL,
    id_account INT UNSIGNED NOT NULL,
    sum_payment FLOAT NOT NULL
);


--таблица обещаний оплатить
CREATE TABLE promises
(
    id           SERIAL,
    account_id   INT UNSIGNED NOT NULL,
    date_promise DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_payment DATETIME NOT NULL
);