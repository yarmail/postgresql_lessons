/*
Пример 9. plpgsql возвращаем RETURNS SETOF table
(возврат множества строк с использованием RETURN QUERY)
Создаем таблицу где в колонке num попадаются одинаковые
значения
Создаем функцию которая возвращает таблицу
только с одинаковыми значениям в колонке num
 */
DROP TABLE IF EXISTS example09 CASCADE;
CREATE TABLE example09 (num int, name varchar);
INSERT INTO example09 VALUES
(1, 'name1'), (2, 'name2'), (1, 'name3');

DROP FUNCTION IF EXISTS get_same();
CREATE FUNCTION get_same()
RETURNS  SETOF example09 AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM example09 WHERE num = 1;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_same();