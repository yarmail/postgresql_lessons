/*
 Пример 10. Использование IF ELSE.
 Задание: написать конвертер температуры.
 Входящие параметры:
 Аргумент: температура
 Флаг (булево) значение, по умолчанию true
 подтверждает что подается температура
 в градусах Цельсия, false - означает,
 что в Фаренгейтах. В зависимости от флага
 выбирается та или иная ветвь вычислений
 На выходе результат - сконвертированная температура

 */

CREATE OR REPLACE FUNCTION converter_temp_to
    (temperature real, to_celsius bool DEFAULT true)
RETURNS real AS $$
DECLARE
    result_temp real;
BEGIN
    IF to_celsius THEN -- аналогично IF to_celsius = true
       result_temp = (5.0 / 9.0) * (temperature - 32); -- в Цельсий
    ELSE
        result_temp = (9 * temperature + (32 * 5)) / 5.0; -- в Фаренгейты
    END IF;
    RETURN result_temp;
END;
$$ LANGUAGE plpgsql;

SELECT converter_temp_to(80);
-- Вывод 26.(6) град. Цельсия

SELECT converter_temp_to(26.666666, FALSE);
-- Вывод: 80 град. Фаренгейта