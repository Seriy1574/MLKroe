

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

