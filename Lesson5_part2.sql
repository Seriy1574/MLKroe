Виктор приветствую!

Практическое задание теме “Агрегация данных”

1. Подсчитайте средний возраст пользователей в таблице users

SELECT AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25) AS avg_age
FROM users;

SELECT FLOOR(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25)) AS avg_age
FROM users;

SELECT FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) AS age
FROM users;


2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
 DAYNAME(DATE_FORMAT(u.birthday_at, '2019-%m-%d')) day_week,
 COUNT(u.name) count_users
from users u
 GROUP BY DAYNAME(DATE_FORMAT(u.birthday_at, '2019-%m-%d'));

Третье задание не смог сделать((


