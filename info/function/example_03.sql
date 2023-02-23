/*
Пример 03.
Использование функции с входящими аргументами
При вызове функции указываем значение, которое нам надо найти (6)
и функция должна найти эту ячейку, если такое значение есть.

Создаем таблицу с одним стобцом, добавляем несколько значений
Создаем функцию, (IN filter_num int - входящий аргумент)
вызываем её и она ищет нужное значение.
Также мы можем добавить выражение по умолчанию и получится
IN filter_num int DEFAULT 6
на тот случай, если мы не указываем аргумент,
а просто вызываем функцию
 */

DROP TABLE IF EXISTS example03 CASCADE;
CREATE TABLE example03 (num int);
INSERT INTO example03(num) VALUES (5),(6),(7);

DROP FUNCTION IF EXISTS filter_values();
CREATE OR REPLACE FUNCTION filter_values(IN filter_num int)
RETURNS int AS $$
    SELECT (num)
    FROM example03
    WHERE num = filter_num
$$ LANGUAGE SQL;

SELECT filter_values(6);