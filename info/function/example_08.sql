/*
Пример 8. plpgsql функция с исходящими аргументами

Создаем и заполняем таблицу
Создаем функцию plpgsql, которая ищет минимальное и максимальное
значение в столбце и присваивает их выходным аргументам

Вызываем созданную функцию

Не совсем оптимальное присваивание (2 запроса)
BEGIN
min_value := MIN(num) FROM example08;
max_value := MAX(num) FROM example08;
END;
Более оптимальный вариант ниже

 */
DROP TABLE IF EXISTS example08 CASCADE;
CREATE TABLE example08 (num int);
INSERT INTO example08 VALUES (1), (2), (3);

DROP FUNCTION IF EXISTS get_min_max();
CREATE FUNCTION get_min_max(OUT min_value int, OUT max_value int)
AS $$
BEGIN
    SELECT MIN(num), MAX(num)
    INTO min_value, max_value
    FROM example08;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_min_max();

