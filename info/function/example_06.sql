/*
Пример 6. Использование функции RETURNS SETOF table
Создаем таблицу заполняем её значениями, чтобы
в колонке num значения повторялись.

Создаем функцию, которая возвращает
таблицу, в которой ячейки num = 1
 */

DROP TABLE IF EXISTS example06 CASCADE;
CREATE TABLE example06 (num  int, name varchar);
INSERT INTO example06 VALUES
(1, 'name1'), (2, 'name2'), (1, 'name3');

DROP FUNCTION IF EXISTS get_values();
CREATE FUNCTION get_values()
    RETURNS setof example06 AS $$
SELECT * FROM example06 WHERE num = 1;
$$ LANGUAGE sql;

SELECT * FROM get_values();