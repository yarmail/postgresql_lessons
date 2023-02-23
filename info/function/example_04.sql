/*
 Пример 4. Использование функции с исходящими аргументами
 Пробуем найти минимальное и максимальное значение в колонке
 (5 и 7)

 Создаем таблицу, добавляем одну колонку и несколько значений
 Создаем функцию с исходящими аргументами, в которые помещаем
 минимальное и максимальное значение столбца
 В данном примере важен порядок следования аргументов
 Вызываем функцию
 */
DROP TABLE IF EXISTS example04 CASCADE;
CREATE TABLE example04 (num int);
INSERT INTO example04 VALUES (5), (6), (7);

DROP FUNCTION IF EXISTS min_max();
CREATE FUNCTION min_max(OUT min_value int, OUT max_value int)AS $$
    SELECT MIN(num), MAX(num)
    FROM example04
$$ LANGUAGE SQL;

SELECT * FROM min_max();

