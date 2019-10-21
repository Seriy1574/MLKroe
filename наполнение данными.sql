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

--адреса клиентов все вставлять не стал

INSERT INTO `addresses_clients` VALUES

('2532','791','1','0','9','5332 Ullrich Canyon Apt. 276\nEast Terrell, IA 68438'),
('2533','237','4','0','13','3532 Hazle Centers Suite 735\nMerrittfort, ND 57869-3179'),
('2534','717','3','1','12','876 Denesik Ramp Apt. 580\nNorth Cassandra, WV 23455'),
('2535','660','3','0','10','64654 Keeling Greens Apt. 188\nMitchellville, DE 55454'),
('2536','762','2','1','18','9069 Idella Neck Suite 769\nMonahanton, KY 89482'),
('2537','809','1','1','19','708 Luettgen Squares Suite 220\nSouth Hazelville, AZ 72737'),
('2538','259','4','0','19','50852 Brandy Squares Apt. 453\nArchstad, AZ 24601-2226'),
('2539','746','1','0','9','9170 Haley Heights Apt. 604\nSouth Ralphchester, DC 74018');


INSERT  INTO results_actions
    VALUE
    (DEFAULT, 'Нет контакта'),
    (DEFAULT, 'Контакт с клиентом'),
    (DEFAULT, 'Отказ от оплаты'),
    (DEFAULT, 'Обещание заплатить'),
    (DEFAULT, 'Контакт с 3-м лицом');


INSERT  INTO contacts
    VALUE
    (DEFAULT, 'Звонок на моб'),
    (DEFAULT, 'Выезд рег'),
    (DEFAULT, 'Выезд прож'),
    (DEFAULT, 'Выезд др адрес'),
    (DEFAULT, 'Звонок на дом');


INSERT INTO `actions_employees` VALUES
('2','262','186','1','8','2007-03-29 15:36:40','2','97'),
('3','952','172','5','9','2013-05-28 13:15:17','1','85'),
('4','181','173','5','7','1996-08-29 13:47:16','1','55'),
('5','335','199','1','9','2001-07-03 16:37:57','4','15'),
('6','601','168','4','6','1994-12-27 02:26:42','1','10'),
('7','532','186','2','8','1981-04-28 13:53:49','1','84'),
('8','621','184','4','9','2004-10-01 23:26:33','1','78'),
('9','977','164','1','6','2018-04-07 19:01:08','5','93'),
('10','780','192','3','6','2005-05-27 15:15:27','2','24'),
('11','450','175','4','9','2002-01-17 05:39:35','3','89'),
('12','684','161','4','9','1984-10-08 05:23:49','4','59'),
('13','430','197','2','6','1972-03-02 00:02:43','1','16'),
('14','562','180','1','10','2015-06-03 07:43:18','3','81'),
('15','76','199','4','6','1985-06-24 02:19:36','5','1'),
('16','769','165','1','10','2015-03-18 06:11:22','3','30'),
('17','311','196','5','9','2002-09-15 01:31:09','3','1'),
('18','689','174','2','8','1981-05-25 03:44:28','3','36'),
('19','68','189','4','9','2006-08-09 10:03:08','5','86'),
('20','337','165','5','9','1996-10-03 13:31:37','3','18'),
('21','581','194','5','8','2000-01-02 02:04:45','5','85');