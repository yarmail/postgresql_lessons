/*
Пример 02.
Скалярная функция, возвращаем сумму в столбце.

Создаем таблицу с одним стобцом, добавляем 2 значения
Создаем функцию, вызываем её и она возвращает сумму
всех чисел столбца (RETURN int)
Вызываем функцию
 */

DROP TABLE IF EXISTS example02 CASCADE;
CREATE TABLE example02 (num int);
INSERT INTO example02(num) VALUES (5), (5);

DROP FUNCTION IF EXISTS sum_values();
CREATE OR REPLACE FUNCTION sum_values()
RETURNS int AS $$
    SELECT SUM(num)
    FROM example02
$$ LANGUAGE SQL;

SELECT sum_values();