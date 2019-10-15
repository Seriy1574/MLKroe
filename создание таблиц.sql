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

Вставка новых записей

Оба варианта корректно работают только когда вносится одна запись, что неправильно при массовой миграции информации.
Дублирование данных а таблицу employees при внесении новых записей в таблицу profiles_employeers

как то не правильно чтоли.
--транзакция
/*START TRANSACTION;
INSERT INTO profiles_employeers
     (id,
     first_name,
     last_name,
     patronymic,
     birthday,
     id_region,
     created_at,
     block,
     date_block,
     id_pozition,
     updated_at,
      group_id )
VALUE     (NULL,'Крое','Сергей','Евгеньевич','1980-11-15',20,DEFAULT,0,DEFAULT,1,NULL, 1);

(NULL,'Зайчев','Игорь','Юрьевич','1970-10-08',20,DEFAULT,0,DEFAULT,1,NULL, 1);
(NULL,'Крое','Сергей','Евгеньевич','1980-11-15',20,DEFAULT,0,DEFAULT,1,NULL, 1);
(NULL,'Пертова','Ольга','Ивановна','1990-01-11',6,DEFAULT,0,DEFAULT,1,NULL, 7),
      (NULL,'Крое','Сергей','Евгеньевич','1980-11-15',20,DEFAULT,0,DEFAULT,1,NULL, 1),
      (NULL,'Зайчев','Игорь','Юрьевич','1970-10-08',20,DEFAULT,0,DEFAULT,1,NULL, 1);

INSERT INTO  employees (id, ds, df, id_group, id_pozition)
SELECT ID AS id, created_at AS ds, updated_at AS df, group_id, id_pozition FROM profiles_employeers
WHERE created_at IN (SELECT MAX(created_at) FROM profiles_employeers);
COMMIT;*/

---триггер тоже переносит данные, но только по одной записи, массовый пернос работает криво

DROP TRIGGER IF EXISTS check_new_users;
DELIMITER //
CREATE TRIGGER check_new_users AFTER INSERT ON profiles_employeers
    FOR EACH ROW
BEGIN
    INSERT INTO employees (id, ds, df, id_group, id_pozition)
    SELECT id, created_at AS ds, updated_at AS df, group_id, id_pozition FROM profiles_employeers ORDER BY  created_at DESC LIMIT 1;
END;//
DELIMITER ;

SELECT * FROM  profiles_employeers;
SELECT * FROM employees;




изменение существующих записей

DROP TRIGGER IF EXISTS check_upd_users;
DELIMITER //
CREATE TRIGGER check_upd_users AFTER UPDATE ON profiles_employeers
    FOR EACH ROW
BEGIN
SET employee.df = (SELECT updated_at from profiles_employeers) p
WHERE e.id = (SELECT id FROM profiles_employeers ORDER BY  updated_at DESC LIMIT 1) ;
INSERT INTO employees (id, ds, df, id_group, id_pozition)
SELECT id, updated_at AS ds, NULL AS df, group_id, id_pozition FROM profiles_employeers ORDER BY  updated_at DESC LIMIT 1;
END;//
DELIMITER ;





TRUNCATE TABLE employees;
TRUNCATE TABLE profiles_employeers;

SELECT * FROM  profiles_employeers;
SELECT * FROM employees;

UPDATE profiles_employeers
SET block = 1
WHERE id  =1;

UPDATE profiles_employeers
SET id_region = 1
WHERE id  = 2;

UPDATE users
SET updated_at = created_at
WHERE id IN (SELECT id FROM del
);