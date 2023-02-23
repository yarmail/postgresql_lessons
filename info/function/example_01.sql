/*
Простая функция
Создаем таблицу, создаем одну колонку, помещаем туда одно число.
Создаем функцию, где, если находим это число, то меняем его на другое.
Вызываем функцию
Вызываем заново таблицу, чтобы посмотреть что число изменилось
 */
DROP TABLE IF EXISTS example01 CASCADE;
CREATE TABLE example01 (num int);
INSERT INTO example01(num)VALUES (5);

DROP FUNCTION IF EXISTS update_value();
CREATE OR REPLACE FUNCTION update_value()
RETURNS void AS $$
    UPDATE example01
    SET num = 6
    WHERE num = 5;
$$ LANGUAGE SQL;

SELECT update_value();

SELECT *FROM example01;

