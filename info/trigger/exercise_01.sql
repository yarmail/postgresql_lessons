/*
Тема Триггеры
Практическое задание № 1.
Логгировать временную метку последнего изменения строки
Создаем таблицу из 2-х колонок num и last_update
Выполняем операции с num, timestamp должна
менять или добавлять функция с триггером
*/

DROP TABLE IF EXISTS exercise01 CASCADE;
CREATE TABLE exercise01(num int, last_updated timestamp);

/*
 Создаем функцию которая будет
 RETURNS trigger - использована триггером
 NEW.last_updated = now() - обращаемся к новой
 созданной строке и в ячейку last_updated добавляем текущее время
 RETURN NEW - и возвращаем эту строку
 */
CREATE OR REPLACE FUNCTION func_timestamp()
RETURNS trigger AS $$
BEGIN
    NEW.last_updated = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*
Далее создаем объект триггера и привязываем его к таблице
а к нему привязываем функцию
BEFORE INSERT OR UPDATE - триггер будет срабатывать перед
вставкой или обновлением строк в таблице
FOR EACH ROW EXECUTE PROCEDURE - функция будет включаться
на каждую строку
 */
DROP TRIGGER IF EXISTS trigger_exercise ON exercise01;
CREATE TRIGGER trigger_exercise BEFORE INSERT OR UPDATE ON exercise01
    FOR EACH ROW EXECUTE PROCEDURE func_timestamp();

/*
 Тестируем. Добавляем только num
 Смотрим на колонку last_updated
 Как видно last_updated обновляется автоматически
 */
INSERT INTO exercise01 (num) VALUES (1);
SELECT pg_sleep(1); -- пауза 1 сек
INSERT INTO exercise01 (num) VALUES (2);
SELECT pg_sleep(1);
INSERT INTO exercise01 (num) VALUES (3);
SELECT * FROM exercise01;


