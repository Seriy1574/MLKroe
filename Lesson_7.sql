﻿Виктор, приветствую!

1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине

Тут все просто. соединять можно в обе стороны, да и вариантов много

1.
SELECT u.id, u.name
  FROM users AS u
  JOIN orders AS o
    ON u.id = o.user_id;

2.
SELECT u.id, u.name
  FROM users AS u
 WHERE u.id in
       (SELECT o.user_id
          FROM orders AS o);

3.
SELECT u.id, u.name
  FROM users AS u
 WHERE EXISTS
       (SELECT *
          FROM orders AS o
         WHERE o.user_id = u.id);

4.
SELECT u.id, u.name
  FROM orders AS o
       JOIN users AS u
       ON u.id = o.user_id
 GROUP BY u.id, u.name;

5.
SELECT DISTINCT u.id, u.name
  FROM orders AS o
       JOIN users AS u
       ON u.id = o.user_id;


Какой запрос оптимальней? Вероятно, что когда к users джойним с orders, т.к. не вся таблица orders просматирвается,
а до первого найденного. или это не так?)
============================================================================================================

2. Выведите список товаров products и разделов catalogs, который соответствует товару.


Тут тоже возможны вариации, как и в первом задании,

SELECT DISTINCT
       p.id, p.name, p.description, c.name AS type_product
  FROM products AS p
       LEFT JOIN catalogs AS c
       ON p.catalog_id = c.id;

Тут применил LEFT JOIN, потому что в таблице products, возможно пустое значение p.catalog_id. чтоб его отловить. вот типа этого
+----+-------------------------+------------------------------------------------------------------------------------+--------------------+
| id | name                    | description                                                                        | type_product       |
+----+-------------------------+------------------------------------------------------------------------------------+--------------------+
|  1 | Intel Core i3-8100      | Процессор для настольных персональных компьютеров, основанных на платформе Intel.  | Процессоры         |
|  2 | Intel Core i5-7400      | Процессор для настольных персональных компьютеров, основанных на платформе Intel.  | Процессоры         |
|  3 | AMD FX-8320E            | Процессор для настольных персональных компьютеров, основанных на платформе AMD.    | Процессоры         |
|  4 | AMD FX-8320             | Процессор для настольных персональных компьютеров, основанных на платформе AMD.    | Процессоры         |
|  5 | ASUS ROG MAXIMUS X HERO | Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX         | Материнские платы  |
|  6 | Gigabyte H310M S2H      | Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX             | Материнские платы  |
|  7 | MSI B250M GAMING PRO    | Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX              | Материнские платы  |
|  8 | Intel Core i3-81000     | Процессор для настольных персональных компьютеров, основанных на платформе Intel.  | NULL               |
+----+-------------------------+------------------------------------------------------------------------------------+--------------------+

============================================================================================================

3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов


SELECT f.id, c1.name AS 'from', c2.name AS 'to'
  FROM flights AS f
       JOIN cities AS c1
       ON f.from = c1.label
            JOIN cities AS c2
            ON f.to = c2.label;