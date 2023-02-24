/*
 Пример 7. plpgsql сумма значений строк
 Создаем таблицу, добавляем колонку и 3 значения в ней

 Создаем функцию, которая складывает значения
 всех ячеек в колонке (сумма должна быть равна 6)

 Вызываем функцию
 (как я понимаю Идея не очень понимает этот диалект)
 */

DROP TABLE IF EXISTS example07 CASCADE;
CREATE TABLE example07 (num int);
INSERT INTO example07 VALUES (1), (2), (3);

DROP FUNCTION IF EXISTS get_sum();
CREATE FUNCTION get_sum() RETURNS int AS $$
BEGIN
    RETURN sum(num) FROM example07;
END;
$$ LANGUAGE plpgsql

SELECT get_sum();



