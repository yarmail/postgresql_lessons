/*
Пример 5. Использование функции RETURNS SETOF data_type
Создаем таблицу заполняем её значениями, чтобы
в колонке num значения повторялись.

Создаем функцию, которая возвращает
столбец num в котором все ячейки имеют значение 1
 */
DROP TABLE IF EXISTS example05 CASCADE;
CREATE TABLE example05 (num int, name varchar);
INSERT INTO example05 VALUES
(1, 'name1'), (2, 'name2'), (1, 'name3');

DROP FUNCTION IF EXISTS get_values();
CREATE FUNCTION get_values()
RETURNS SETOF int AS $$
    SELECT num FROM example05 WHERE num = 1;
$$ LANGUAGE SQL;

SELECT * FROM get_values();