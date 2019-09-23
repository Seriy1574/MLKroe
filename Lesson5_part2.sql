Виктор приветствую!

Практическое задание теме “Агрегация данных”

1. Подсчитайте средний возраст пользователей в таблице users

SELECT AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25) AS avg_age
FROM users;
+-------------+
| avg_age     |
+-------------+
| 29.93165903 |
+-------------+


SELECT FLOOR(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25)) AS avg_age
FROM users;

+---------+
| avg_age |
+---------+
|      29 |
+---------+


SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())),2) AS age
FROM users;

+-------+
| age   |
+-------+
| 29.38 |
+-------+


2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
 DAYNAME(DATE_FORMAT(u.birthday_at, '2019-%m-%d')) day_week,
 COUNT(u.name) count_users
from users u
 GROUP BY DAYNAME(DATE_FORMAT(u.birthday_at, '2019-%m-%d'));

+-----------+-------------+
| day_week  | count_users |
+-----------+-------------+
| Saturday  |           4 |
| Tuesday   |           3 |
| Monday    |           2 |
| Thursday  |           2 |
| Wednesday |           1 |
| Friday    |           1 |
+-----------+-------------+


Третье задание не смог сделать((


