CREATE TABLE "Сотрудник" (
	"Код_сотр" serial NOT NULL,
	"Имя_сотр" varchar(20) NOT NULL,
	"Фам_сотр" varchar(20) NOT NULL,
	"Отч_сотр" varchar(20),
	"Дат_р" DATE NOT NULL,
	"Тел_сотр" varchar(12) NOT NULL,
	"Пас_дан" varchar(20) NOT NULL,
	"Дат_выд_пас" DATE NOT NULL,
	"Мест_выд_пас" varchar(100) NOT NULL,
	"Код_отдел" integer NOT NULL,
	"Дат_н_р" DATE NOT NULL,
	"Отдел_сотр_фил" varchar(100) NOT NULL,
	"Должн" varchar(100) NOT NULL,
	"Окл" integer NOT NULL,
	CONSTRAINT "Сотрудник_pk" PRIMARY KEY ("Код_сотр")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Отдел" (
	"Код_отдел" serial NOT NULL,
	"Назв_отдел_фил" varchar(100) NOT NULL,
	"Код_фил" integer NOT NULL,
	CONSTRAINT "Отдел_pk" PRIMARY KEY ("Код_отдел")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Филиал" (
	"Код_фил" serial NOT NULL,
	"Рег_фил" varchar(100) NOT NULL,
	"Гор_фил" varchar(100) NOT NULL,
	"Ул_фил" varchar(100) NOT NULL,
	CONSTRAINT "Филиал_pk" PRIMARY KEY ("Код_фил")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Материал" (
	"Код_мат" serial NOT NULL,
	"Назв" varchar(100) NOT NULL,
	"Кол_мат" integer NOT NULL,
	"Цен_за_ед" integer NOT NULL,
	"Код_зав" integer NOT NULL,
	CONSTRAINT "Материал_pk" PRIMARY KEY ("Код_мат")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Щит" (
	"Код_щит" serial NOT NULL,
	"Назв" varchar(100) NOT NULL,
	"Занят" varchar(100) NOT NULL,
	"Выс" integer NOT NULL,
	"Шир" integer NOT NULL,
	"Код_фил" integer NOT NULL,
	"Код_зак" integer NOT NULL,
	"Код_дог" integer NOT NULL,
	CONSTRAINT "Щит_pk" PRIMARY KEY ("Код_щит")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Клиент" (
	"Код_кл" serial NOT NULL,
	"Имя_кл" varchar(20) NOT NULL,
	"Фам_кл" varchar(20) NOT NULL,
	"Отч_кл" varchar(20),
	"Дат_р" DATE NOT NULL,
	"Эл_почт" varchar(100),
	"Тел_кл" varchar(12) NOT NULL,
	"Пас_дан" varchar(100) NOT NULL,
	"Дат_выд_пас" DATE NOT NULL,
	"Мест_выд_пас" varchar(50) NOT NULL,
	"Гор_р" varchar(100) NOT NULL,
	"Мест_жит" varchar(100) NOT NULL,
	CONSTRAINT "Клиент_pk" PRIMARY KEY ("Код_кл")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Договор" (
	"Код_дог" serial NOT NULL,
	"Дата_зак" DATE NOT NULL,
	"Мес_сум_опл" integer NOT NULL,
	"Срок" DATE NOT NULL,
	"Код_фил" integer NOT NULL,
	"Код_кл" integer NOT NULL,
	"Код_орг" integer,
	"Цен_за_пер" integer NOT NULL,
	CONSTRAINT "Договор_pk" PRIMARY KEY ("Код_дог")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Оплата" (
	"Код_опл" serial NOT NULL,
	"Сум" serial NOT NULL,
	"Код_дог" integer NOT NULL,
	CONSTRAINT "Оплата_pk" PRIMARY KEY ("Код_опл")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "ЩитМатериал" (
	"Код_щит" integer NOT NULL,
	"Код_мат" integer NOT NULL,
	"Кол_во" integer NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Организация" (
	"Код_орг" serial NOT NULL,
	"Назв_орг" varchar(200),
	"Опис_орг" varchar(200),
	CONSTRAINT "Организация_pk" PRIMARY KEY ("Код_орг")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "ЗаказНаряд" (
	"Код_зак" serial NOT NULL,
	"Код_дог" integer NOT NULL,
	"Кол_во" integer NOT NULL,
	CONSTRAINT "ЗаказНаряд_pk" PRIMARY KEY ("Код_зак")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Сотрудник" ADD CONSTRAINT "Сотрудник_fk0" FOREIGN KEY ("Код_отдел") REFERENCES "Отдел"("Код_отдел");

ALTER TABLE "Отдел" ADD CONSTRAINT "Отдел_fk0" FOREIGN KEY ("Код_фил") REFERENCES "Филиал"("Код_фил");


ALTER TABLE "Материал" ADD CONSTRAINT "Материал_fk0" FOREIGN KEY ("Код_зав") REFERENCES "Филиал"("Код_фил");

ALTER TABLE "Щит" ADD CONSTRAINT "Щит_fk0" FOREIGN KEY ("Код_фил") REFERENCES "Филиал"("Код_фил");
ALTER TABLE "Щит" ADD CONSTRAINT "Щит_fk1" FOREIGN KEY ("Код_зак") REFERENCES "ЗаказНаряд"("Код_зак");


ALTER TABLE "Договор" ADD CONSTRAINT "Договор_fk0" FOREIGN KEY ("Код_фил") REFERENCES "Филиал"("Код_фил");
ALTER TABLE "Договор" ADD CONSTRAINT "Договор_fk1" FOREIGN KEY ("Код_кл") REFERENCES "Клиент"("Код_кл");
ALTER TABLE "Договор" ADD CONSTRAINT "Договор_fk2" FOREIGN KEY ("Код_орг") REFERENCES "Организация"("Код_орг");

ALTER TABLE "Оплата" ADD CONSTRAINT "Оплата_fk0" FOREIGN KEY ("Код_дог") REFERENCES "Договор"("Код_дог");

ALTER TABLE "ЩитМатериал" ADD CONSTRAINT "ЩитМатериал_fk0" FOREIGN KEY ("Код_щит") REFERENCES "Щит"("Код_щит");
ALTER TABLE "ЩитМатериал" ADD CONSTRAINT "ЩитМатериал_fk1" FOREIGN KEY ("Код_мат") REFERENCES "Материал"("Код_мат");


ALTER TABLE "ЗаказНаряд" ADD CONSTRAINT "ЗаказНаряд_fk0" FOREIGN KEY ("Код_дог") REFERENCES "Договор"("Код_дог");

INSERT INTO "Филиал" ("Код_фил", "Рег_фил", "Гор_фил", "Ул_фил")
VALUES (1, 'Москва', 'Москва', 'Льва Толстова');

INSERT INTO "Филиал" ("Код_фил", "Рег_фил", "Гор_фил", "Ул_фил")
VALUES (2, 'Санкт Петербург', 'Санкт Петербург', 'Пискарёвский просп, 2');

INSERT INTO "Филиал" ("Код_фил", "Рег_фил", "Гор_фил", "Ул_фил")
VALUES (3, 'Владимерская обл', 'Ковров', 'Лопатина,2');

INSERT INTO "Филиал" ("Код_фил", "Рег_фил", "Гор_фил", "Ул_фил")
VALUES (4, 'Нижний Новгород', 'Нижний Новгород', 'ул. Родионова, 23');

INSERT INTO "Филиал" ("Код_фил", "Рег_фил", "Гор_фил", "Ул_фил")
VALUES (5, 'Cвердловская об', 'Екатиренбург', 'ул. Хохрякова, 10'); 

select * From  "Филиал";

INSERT INTO "Отдел" ("Код_отдел", "Назв_отдел_фил", "Код_фил")
VALUES (1, 'Дизайн', 1);

INSERT INTO "Отдел" ("Код_отдел", "Назв_отдел_фил", "Код_фил")
VALUES (2, 'Менеджмент', 5);

INSERT INTO "Отдел" ("Код_отдел", "Назв_отдел_фил", "Код_фил")
VALUES (3, 'Логистика', 5);

INSERT INTO "Отдел" ("Код_отдел", "Назв_отдел_фил", "Код_фил")
VALUES (4, 'Маркетинг', 1);

INSERT INTO "Отдел" ("Код_отдел", "Назв_отдел_фил", "Код_фил")
VALUES (5, 'Производство', 2);

select * From "Отдел";

INSERT INTO "Сотрудник" 
("Код_сотр","Имя_сотр","Фам_сотр","Отч_сотр","Дат_р","Тел_сотр","Пас_дан" ,"Дат_выд_пас" ,"Мест_выд_пас" ,"Код_отдел" ,"Дат_н_р", "Отдел_сотр_фил", "Должн", "Окл" )
VALUES (1, 'Артемий', 'Лебедев', 'Татьянович', '1975-02-12','+79220940202', '7293 445512', '2010-02-10', 'Москва', 1, '2012-02-10', 'Дизайн', 'Главынй дизайнер', '200000' );

INSERT INTO "Сотрудник" 
("Код_сотр","Имя_сотр","Фам_сотр","Отч_сотр","Дат_р","Тел_сотр","Пас_дан" ,"Дат_выд_пас" ,"Мест_выд_пас" ,"Код_отдел" ,"Дат_н_р", "Отдел_сотр_фил", "Должн", "Окл" )
VALUES (2, 'Никита', 'Сергеевич ', 'Хрущёв', '1976-02-12','+79220020202', '1221 141516', '2013-02-10', 'Москва', 2, '2012-02-12','Менеджер', 'Главынй менеджер', '210000' );

INSERT INTO "Сотрудник" 
("Код_сотр","Имя_сотр","Фам_сотр","Отч_сотр","Дат_р","Тел_сотр","Пас_дан" ,"Дат_выд_пас" ,"Мест_выд_пас" ,"Код_отдел" ,"Дат_н_р", "Отдел_сотр_фил", "Должн", "Окл" )
VALUES (3, 'Максим', 'Анатольевич', 'Собчак', '1985-02-01','+79112221314', '7612 566123', '2000-02-11', 'Москва', 5,'2012-02-13','Маркетинг', 'Главынй маркетолог', '120000' );

select * From "Сотрудник";

INSERT INTO "Материал" ("Код_мат", "Назв", "Кол_мат", "Цен_за_ед", "Код_зав")
VALUES (1, 'Армированный винил', 100, 100.5, 2);

INSERT INTO "Материал" ("Код_мат", "Назв", "Кол_мат", "Цен_за_ед", "Код_зав")
VALUES (2, 'Виниловое полотно', 1000, 150, 2);

INSERT INTO "Материал" ("Код_мат", "Назв", "Кол_мат", "Цен_за_ед", "Код_зав")
VALUES (3, 'Пластичны полиуретановые', 25, 120, 2);

INSERT INTO "Материал" ("Код_мат", "Назв", "Кол_мат", "Цен_за_ед", "Код_зав")
VALUES (4, 'Светодиодные ленты', 100, 200, 2);

INSERT INTO "Материал" ("Код_мат", "Назв", "Кол_мат", "Цен_за_ед", "Код_зав")
VALUES (5, 'Алюминий', 1000, 1000, 2);

INSERT INTO "Материал" ("Код_мат", "Назв", "Кол_мат", "Цен_за_ед", "Код_зав")
VALUES (6, 'Тентовая ткань', 1000, 125.25, 2);  

select * From "Материал";

INSERT INTO "Клиент" ("Код_кл", "Имя_кл", "Фам_кл", "Отч_кл", "Дат_р", "Эл_почт", "Тел_кл", "Пас_дан", "Дат_выд_пас", "Мест_выд_пас", "Гор_р", "Мест_жит")
VALUES (1,'Сергей','Аксаков','Дмитриеевич', '1995-05-12', 'MoscowCity@city.ru', '+7499209032', '1210 729300', '2012-06-16', 'Санкт Петербург','Москва', 'Москва'); 

INSERT INTO "Клиент" ("Код_кл", "Имя_кл", "Фам_кл", "Отч_кл", "Дат_р", "Эл_почт", "Тел_кл", "Пас_дан", "Дат_выд_пас", "Мест_выд_пас", "Гор_р", "Мест_жит")
VALUES (2,'Александр','Бродский','Иванович', '1990-05-14', 'rtspb@rt.ru', '+78126701022', '1010 101983', '2000-07-12', 'Санкт Петербург', 'Москва', 'Санкт Петербург');

INSERT INTO "Клиент" ("Код_кл", "Имя_кл", "Фам_кл", "Отч_кл", "Дат_р", "Эл_почт", "Тел_кл", "Пас_дан", "Дат_выд_пас", "Мест_выд_пас", "Гор_р", "Мест_жит")
VALUES (3,'Алексей','Любимов','Александрович', '1994-05-16', 'merlow@gmail.com', '+74996711422', '2020 202923', '2012-06-11', 'Москва', 'Москва','Москва');
 
select * From "Клиент";

INSERT INTO "Организация" ("Код_орг", "Назв_орг", "Опис_орг")
VALUES (0, 'ООО АСК инвест','Сторительная коспания');

INSERT INTO "Организация" ("Код_орг", "Назв_орг", "Опис_орг")
VALUES (1,'ООО Реал Лайв','Рекламная компания');

select * From "Организация";

INSERT INTO "Договор" ("Код_дог", "Дата_зак", "Мес_сум_опл", "Срок", "Код_фил", "Код_кл","Код_орг", "Цен_за_пер")
VALUES (1,'2021-02-12','3500','2021-03-22', 1, 1, 0, 42000);

INSERT INTO "Договор" ("Код_дог", "Дата_зак", "Мес_сум_опл", "Срок", "Код_фил", "Код_кл","Код_орг", "Цен_за_пер")
VALUES (2,'2021-02-13','4200','2021-03-23', 1, 2, 0, 12600);

INSERT INTO "Договор" ("Код_дог", "Дата_зак", "Мес_сум_опл", "Срок", "Код_фил", "Код_кл","Код_орг", "Цен_за_пер")
VALUES (3,'2021-02-14','1200','2021-03-24', 1, 3, 1, 1335);

INSERT INTO "Договор" ("Код_дог", "Дата_зак", "Мес_сум_опл", "Срок", "Код_фил", "Код_кл","Код_орг", "Цен_за_пер")
VALUES (4,'2021-02-15','1000','2021-03-25', 2, 3, 1, 1035);

select * From "Договор";

INSERT INTO "Оплата" ("Код_опл", "Сум", "Код_дог")
VALUES (1,42000,1);

INSERT INTO "Оплата" ("Код_опл", "Сум", "Код_дог")
VALUES (2,12600,2);

INSERT INTO "Оплата" ("Код_опл", "Сум", "Код_дог")
VALUES (3,1335,3);

INSERT INTO "Оплата" ("Код_опл", "Сум", "Код_дог")
VALUES (4,1035,4);

select * From "Оплата";

INSERT INTO "ЗаказНаряд" ("Код_зак", "Код_дог", "Кол_во")
VALUES (1, 1, 2);

INSERT INTO "ЗаказНаряд" ("Код_зак", "Код_дог", "Кол_во")
VALUES (2, 2, 2);

INSERT INTO "ЗаказНаряд" ("Код_зак", "Код_дог", "Кол_во")
VALUES (3, 3, 3)

INSERT INTO "ЗаказНаряд" ("Код_зак", "Код_дог", "Кол_во")
VALUES (4, 4, 1)

select * From "ЗаказНаряд";

INSERT INTO "Щит" ("Код_щит", "Назв", "Занят", "Выс", "Шир", "Код_фил","Код_зак", "Код_дог")
VALUES (1,'Билборд', 'до 25.02.21', 3, 6, 2, 1, 1);

INSERT INTO "Щит" ("Код_щит", "Назв", "Занят", "Выс", "Шир", "Код_фил","Код_зак", "Код_дог")
VALUES (2,'Суперборд', 'Свободен', 4, 14, 2, 1, 2);

INSERT INTO "Щит" ("Код_щит", "Назв", "Занят", "Выс", "Шир", "Код_фил","Код_зак", "Код_дог")
VALUES (3,'Суперсайт','до 02.02.21', 5, 15, 2, 2, 2);

INSERT INTO "Щит" ("Код_щит", "Назв", "Занят", "Выс", "Шир", "Код_фил","Код_зак", "Код_дог")
VALUES (4,'Пиллар','до 04.01.22', 2.7, 3.7, 2, 3, 4);
INSERT INTO "Щит" ("Код_щит", "Назв", "Занят", "Выс", "Шир", "Код_фил","Код_зак", "Код_дог")
VALUES (5,'Ситиформат','до 22.10.20', 1.2, 1.8, 2, 4, 4);

select * From "Щит"

INSERT INTO "ЩитМатериал" ("Код_щит", "Код_мат")
VALUES (1,1);

INSERT INTO "ЩитМатериал" ("Код_щит", "Код_мат")
VALUES (1,2);

INSERT INTO "ЩитМатериал" ("Код_щит", "Код_мат")
VALUES (2,2);

INSERT INTO "ЩитМатериал" ("Код_щит", "Код_мат")
VALUES (2,3);

select * From "ЩитМатериал";

