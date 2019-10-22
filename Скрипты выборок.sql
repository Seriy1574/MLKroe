
--соответствие региона адреса регистрации клиента- региону работы сотрудника, несколько сотрудников могут работать с одним клиентом


SELECT pe.id AS id_employee, ac.id_client
FROM profiles_employeers pe
         JOIN (
    SELECT DISTINCT id_client, id_type, actual, id_region
    FROM addresses_clients) ac
              ON ac.id_region = pe.id_region
                  AND ac.id_type= 1
                  AND ac.actual = 1
         JOIN
     (SELECT acc.id_client, SUM(sum_dept) all_debt FROM accounts acc
      GROUP BY acc.id_client
      HAVING all_debt > 5000) sd
     ON sd.id_client = ac.id_client;



представление для контроля за работой, кто что сделал по дням

CREATE VIEW control_paym AS
SELECT DATE_FORMAT(ae.date_action,'%d.%m.%Y') 'Дата',
       CONCAT(pe.last_name,' ', pe.first_name) 'Сотрудник',
       CONCAT(c.last_name,' ', c.first_name) 'Клиент',
       ta.name 'Тип активности сотрудника',
       ra.name 'Результат'

FROM actions_employees ae
         JOIN clients c
              ON ae.id_client = c.id
         JOIN accounts a
              ON c.id = a.id_client
         JOIN profiles_employeers pe
              ON ae.id_employee = pe.id
         JOIN types_actions ta
              ON ae.id_type_action = ta.id
         JOIN results_actions ra
              ON ra.id = ae.id_result_action;

выборка для статистики по регионам где сколько сделали по годам

SELECT DATE_FORMAT(ae.date_action,'%Y'),
       r.name 'Регион',
       COUNT(ae.id) 'Всего активностей'

FROM actions_employees ae
JOIN profiles_employeers pe
    ON ae.id_employee = pe.id
JOIN regions r
    ON pe.id_region = r.id
JOIN types_actions ta
    ON ae.id_type_action = ta.id
JOIN results_actions ra
    ON ra.id = ae.id_result_action
GROUP BY DATE_FORMAT(ae.date_action,'%Y'),

         r.name
ORDER BY r.name, DATE_FORMAT(ae.date_action,'%Y') ;

Кто сколько взыскал по месяцам

SELECT DATE_FORMAT(p.date_payment,'%d.%m'),pe.first_name,pe.last_name, sum(p.sum_payment)
FROM payments p
JOIN accounts a
    ON p.id_account = a.id
JOIN clients c
    ON a.id_client = c.id
JOIN clients_employees ce
    ON c.id = ce.id_client
JOIN profiles_employeers pe
    ON ce.id_employee = pe.id
GROUP BY
         DATE_FORMAT(p.date_payment,'%d.%m'),pe.first_name,pe.last_name;