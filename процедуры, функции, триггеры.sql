

--триггер уменьшения суммы задолженности при оплате


USE mobile_collection;

SELECT * FROM accounts WHERE id = 1;
+----+------------------+-----------+-----------------+------------+---------------------+-------------+-----+---------+----------+
| id | number_count     | id_client | id_type_product | sum_credit | date_credit         | credit_term | dpd | id_bank | sum_dept |
+----+------------------+-----------+-----------------+------------+---------------------+-------------+-----+---------+----------+
|  1 | 5563151554477328 |        80 |               1 |     702036 | 1975-07-17 00:00:00 |          18 | 861 |       7 |  1596550 |
+----+------------------+-----------+-----------------+------------+---------------------+-------------+-----+---------+----------+



DROP TRIGGER IF EXISTS get_payments
DELIMITER //
CREATE TRIGGER get_payments AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
    IF NEW.sum_payment IS NOT NULL then
        UPDATE accounts SET sum_dept = sum_dept - NEW.sum_payment WHERE accounts.id = NEW.id;
    END IF ;
END;//

DELIMITER ;

INSERT INTO payments (id, id_account, sum_payment, date_payment)
VALUE
    (NULL, 1, 500000, curtime()),
    (NULL, 1, 1000000, curtime());

SELECT * FROM accounts WHERE id = 1;

+----+------------------+-----------+-----------------+------------+---------------------+-------------+-----+---------+----------+
| id | number_count     | id_client | id_type_product | sum_credit | date_credit         | credit_term | dpd | id_bank | sum_dept |
+----+------------------+-----------+-----------------+------------+---------------------+-------------+-----+---------+----------+
|  1 | 5563151554477328 |        80 |               1 |     702036 | 1975-07-17 00:00:00 |          18 | 861 |       7 |    96550 |
+----+------------------+-----------+-----------------+------------+---------------------+-------------+-----+---------+----------+




Хотел сделать триггер такой, но он не работет много таблиц в поздапросе, не дают внешние ключи.

/*DROP TRIGGER IF EXISTS cl_empl
DELIMITER //
CREATE TRIGGER cl_empl AFTER INSERT ON clients
    FOR EACH ROW
BEGIN
    IF NEW.id IS NOT NULL then

        UPDATE clients_employees as dest,
            (SELECT pe.id AS id_employee, ac.id_client
             FROM profiles_employeers pe
                      JOIN (SELECT DISTINCT id_client, id_type, actual, id_region
                            FROM addresses_clients) ac
                           ON ac.id_region = pe.id_region
                               AND ac.id_type= 1
                               AND ac.actual = 1
                      JOIN
                  (SELECT acc.id_client, SUM(sum_dept) all_debt FROM accounts acc
                   GROUP BY acc.id_client
                   HAVING all_debt > 5000) sd
                  ON sd.id_client = ac.id_client
             WHERE ac.id_client = NEW.id ) AS sqr
        SET dest.id_employee = sqr.id_employee, dest.id_client = sqr.id_client
        WHERE id_employee = NEW.id;
    END IF ;
END;//

DELIMITER ;*/

