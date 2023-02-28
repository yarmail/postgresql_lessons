/*
Тема Триггеры
Практическое задание № 2
Вешаем триггеры и функции на состояние а не изменения строки

1. Создаем таблицу, за которой будем наблюдать. (просто имена)
2. Создаем таблицу аудита и фиксируем там изменения первой таблицы

Создаем исходную таблицу
*/
DROP TABLE IF EXISTS exercise02 CASCADE;
CREATE TABLE exercise02(name varchar);

/*
 Создаем аудирующую таблицу, помещаем туда колонки, как в первой,
 и колонки аудита: имя (name), проведенная операция (op),
 время операции (time_stamp)
 Эта таблица будет заполняться автоматически
 Добавляем сначала колонки аудита, а потом имена
 */
DROP TABLE IF EXISTS exercise02_audit CASCADE;
CREATE TABLE exercise02_audit(op char(1), time_stamp timestamp, name varchar);

/*
Создаем функцию, привязанную к триггеру (RETURNS trigger AS)
IF tg_op = 'INSERT' THEN - если операция INSERT,
SELECT 'I', now(), nt.* - мы вставляем данные в колонки аудита,
 а потом во все остальные
FROM new_table AS nt - измененная таблица

Получается, что когда триггер обращается к этой функции,
у него уже определено, что такое new_table - это состояние
новой (обновленной) таблицы (REFERENCING NEW TABLE AS new_table)

Получается, эта функция обслуживает 3 триггера
 */
CREATE OR REPLACE FUNCTION func_exercise02()
RETURNS trigger AS $$
BEGIN
    IF tg_op = 'INSERT' THEN
        INSERT INTO exercise02_audit
        SELECT 'I', now(), nt.* FROM new_table AS nt;
    ELSEIF tg_op = 'UPDATE' THEN
        INSERT INTO exercise02_audit
        SELECT 'U', now(), nt.* FROM new_table AS nt;
    ELSEIF tg_op = 'DELETE' THEN
        INSERT INTO exercise02_audit
        SELECT 'D', now(), ot.* FROM old_table AS ot;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

/*
Привязываем первый триггер к событию -
AFTER INSERT таблицы exercise02
REFERENCING NEW TABLE AS new_table - ссылка на новое состояние таблицы,
которую мы будем называть new_table
FOR EACH STATEMENT EXECUTE PROCEDURE - неважно сколько в запросе
надо поменять строк - срабатывает на INSERT, запускает функцию.
 */
DROP TRIGGER IF EXISTS trig_insert ON exercise02;
CREATE TRIGGER trig_insert AFTER INSERT ON exercise02
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE func_exercise02();

/*
 Второй триггер на UPDATE, похож на первый
 */
DROP TRIGGER IF EXISTS trig_update ON exercise02;
CREATE TRIGGER trig_update AFTER UPDATE ON exercise02
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE func_exercise02();

/*
 Третий триггер на DELETE
 */
DROP TRIGGER IF EXISTS trig_delete ON exercise02;
CREATE TRIGGER trig_delete AFTER DELETE ON exercise02
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE PROCEDURE func_exercise02();

/*
 Тестируем. После загрузки всех таблиц, функций
 и триггеров начинаем добавлять несколько строк
 в одну таблицу (exercise02), а потом смотрим
 на таблицу аудита exercise02_audit
 */
INSERT INTO exercise02 (name) VALUES ('name1');
SELECT pg_sleep(1); -- пауза 1 сек
INSERT INTO exercise02 (name) VALUES ('name2');
SELECT pg_sleep(1);
INSERT INTO exercise02 (name) VALUES ('name3');

SELECT * FROM exercise02_audit;

UPDATE exercise02
SET name = 'UPDATE_NAME'
WHERE name = 'name1';

DELETE FROM exercise02
WHERE name = 'name3';

SELECT * FROM exercise02_audit;