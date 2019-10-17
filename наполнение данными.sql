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

INSERT INTO regions(id, name, id_parent)
VALUE
    (DEFAULT, 'Россия', NULL ),
    (DEFAULT, 'Москва', 1),
    (DEFAULT, 'Санкт-Петербург', 1),
    (DEFAULT, 'Свердловская область', 1),
    (DEFAULT, 'Челябинская область', 1),
    (DEFAULT, 'Московская область', 1),
    (DEFAULT, 'Иркутская область', 1),
    (DEFAULT, 'Екатеринбург', 4),
    (DEFAULT, 'Первоуральск', 4),
    (DEFAULT, 'Тавда', 4),
    (DEFAULT, 'Челябиснк', 5),
    (DEFAULT, 'Копейск', 5),
    (DEFAULT, 'Златоуст', 5),
    (DEFAULT, 'Аша', 5),
    (DEFAULT, 'Красногорск', 6),
    (DEFAULT, 'Солнечногорск', 6),
    (DEFAULT, 'Серпухов', 6),
    (DEFAULT, 'Балашиха', 6),
    (DEFAULT, 'Мытищи', 6),
    (DEFAULT, 'Иркутск', 7);


INSERT INTO positions(id, name)
VALUE
    (DEFAULT, 'Специалист'),
    (DEFAULT, 'Старший специалист'),
    (DEFAULT, 'Эксперт');

INSERT INTO profiles_employeers(id, first_name, last_name, patronymic, birthday, id_region, created_at, block, date_block, id_pozition, updated_at)
VALUE
    (DEFAULT, 'Андрей','Первушин', 'Юрьевич', '1967-11-12', 11, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Игнат', 'Кочергин', 'Ратмирович', '1971-10-15', 12, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Демид', 'Зуев', 'Олегович', '1972-12-15', 8, DEFAULT, 0, DEFAULT, 3, DEFAULT),
    (DEFAULT, 'Эрик', 'Родионов', 'Ринатович', '1999-01-11', 9, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Мирослав', 'Губанов', 'Максович', '1990-11-05', 8, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Денис', 'Григорьев', 'Егорович', '1990-07-08', 9, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Григорий', 'Гордеев', 'Ильяович', '1996-06-15', 17, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Петр', 'Золотов', 'Эльбрусович', '1998-11-01', 17, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Василий', 'Беликов', 'Демидович', '1990-01-01', 17, DEFAULT, 0, DEFAULT, 3, DEFAULT),
    (DEFAULT, 'Емельян', 'Глебов', 'Мстиславович', '1985-11-02', 17, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Эрик', 'Мухин', 'Вячеславович', '1986-04-03', 19, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Виталий', 'Калмыков', 'Дмитриевич', '1987-11-03', 20, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Федор', 'Фомин', 'Ильяович', '1988-05-04', 20, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Иосиф', 'Львов', 'Романович', '1990-05-05', 20, DEFAULT, 0, DEFAULT, 3, DEFAULT),
    (DEFAULT, 'Кузьма', 'Дьяков', 'Трофимович', '1971-11-25', 20, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Тихон', 'Крылов', 'Ярославович', '1973-11-24', 11, DEFAULT, 0, DEFAULT, 3, DEFAULT),
    (DEFAULT, 'Эдуард', 'Постников', 'Иосифович', '1990-11-26', 20, DEFAULT, 0, DEFAULT, 3, DEFAULT),
    (DEFAULT, 'Юлий', 'Измайлов', 'Ильяович', '1977-11-29', 8, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Роман', 'Озеров', 'Эмилевич', '1986-11-01', 9, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Влас', 'Глушков', 'Виталиевич', '1981-11-02', 14, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Мстислав', 'Воронков', 'Ярославович', '1980-11-03', 14, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Эрик', 'Зеленин', 'Димитриевич', '1981-11-05', 17, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Виталий', 'Лобанов', 'Олегович', '1971-11-04', 14, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Владлен', 'Яковлев', 'Сергеевич', '1985-11-08', 14, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Пахом', 'Егоров', 'Тимурович', '1995-06-15', 14, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Валерий', 'Окулов', 'Аланович', '1996-07-11', 10, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Владлен', 'Прохоров', 'Эдуардович', '1997-08-11', 14, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Данил', 'Бондарев', 'Климович', '1968-09-12', 11, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Ярослав', 'Горшков', 'Архипович', '1988-01-13', 14, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Станислав', 'Воронин', 'Егорович', '1996-02-14', 19, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Филипп', 'Коновалов', 'Эдгарович', '1994-03-15', 19, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Артем', 'Шаров', 'Марселевич', '1966-01-16', 18, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Илларион', 'Козловский', 'Ринатович', '1990-05-18', 18, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Ильяс', 'Лобанов', 'Игнатович', '1968-08-25', 18, DEFAULT, 0, DEFAULT, 3, DEFAULT),
    (DEFAULT, 'Карим', 'Верещагин', 'Рамилевич', '1990-09-15', 19, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Дорофей', 'Нестеров', 'Кириллович', '1994-11-17', 20, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Яков', 'Пахомов', 'Альбертович', '1990-11-20', 12, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Матвей', 'Хомяков', 'Аланович', '1990-12-15', 11, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Яков', 'Дорофеев', 'Вячеславович', '1990-02-15', 14, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Альберт', 'Зеленин', 'Богданович', '1978-03-08', 15, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Осип', 'Дьяконов', 'Алексиевич', '1975-04-11', 16, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Всеволод', 'Миронов', 'Федорович', '1974-04-12', 17, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Петр', 'Малахов', 'Аланович', '1982-10-13', 18, DEFAULT, 0, DEFAULT, 2, DEFAULT),
    (DEFAULT, 'Илья', 'Буров', 'Николаевич', '1998-03-14', 19, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Арсен', 'Горелов', 'Даниилович', '1990-05-15', 20, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Дамир', 'Бондарев', 'Тихонович', '1977-05-16', 8, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Алексей', 'Дорофеев', 'Климович', '1989-07-15', 9, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Савва', 'Быков', 'Эдипович', '1967-08-15', 10, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Анатолий', 'Завьялов', 'Давидович', '1986-12-15', 11, DEFAULT, 0, DEFAULT, 3, DEFAULT),
    (DEFAULT, 'Макс', 'Филиппов', 'Аланович', '1988-11-15', 12, DEFAULT, 0, DEFAULT, 1, DEFAULT),
    (DEFAULT, 'Дмитрий', 'Данилов', 'Пахомович', '1981-06-30', 13, DEFAULT, 0, DEFAULT, 1, DEFAULT);

Наполнил данные клиентов

UPDATE clients SET birthday = birthday - interval 10 year  WHERE birthday > '2001-11-11';

INSERT  INTO banks (id, name) VALUE
(default, 'Альфа банк'),
(default, 'City Bank'),
(default, 'Сбербанк'),
(default, 'Промсвязьбанк'),
(default, 'ВТБ'),
(default, 'Россельхозбанк'),
(default, 'Москомприват'),
(default, 'МКБ'),
(default, 'Восточный'),
(default, 'Росбанк');

yt gjkexftncz yjhvfkbpjdfnm

