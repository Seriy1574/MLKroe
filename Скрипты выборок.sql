
--соответствие региона адреса регистрации клиента- региону работы сотрудника, несколько сотрудников могут работать с одним клиентом

SELECT pe.id, ac.id_client FROM profiles_employeers pe
                                    JOIN (
    SELECT DISTINCT id_client, id_type, actual, id_region
    FROM addresses_clients) ac
                                         ON ac.id_region = pe.id_region
                                             AND ac.id_type= 1
                                             AND ac.actual = 1;

