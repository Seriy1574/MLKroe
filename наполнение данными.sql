USE mobile_collection;
    INSERT INTO types_actions (id, name)
    VALUE
        (DEFAULT, 'Звонок исходящий'),
        (DEFAULT, 'Звонок взодящий'),
        (DEFAULT, 'Выезд'),
        (DEFAULT, 'Отправлено письмо'),
        (DEFAULT, 'Отправлено СМС');

INSERT INTO types_adresses (id, name)
    VALUE
    (DEFAULT, 'Регистрации'),
    (DEFAULT, 'Проживания'),
    (DEFAULT, 'Фактический'),
    (DEFAULT, 'Рабочий'),
    (DEFAULT, 'Прочие адреса');

INSERT INTO types_phones (id, name)
    VALUE
    (DEFAULT, 'Мобильный'),
    (DEFAULT, 'Рабочий'),
    (DEFAULT, 'Домашний');

INSERT INTO types_products(id, name)
    VALUE
    (DEFAULT, 'Кредитная карта'),
    (DEFAULT, 'Кредит наличными'),
    (DEFAULT, 'Ипотека'),
    (DEFAULT, 'Автокредит'),
    (DEFAULT, 'Потреб. кредит');