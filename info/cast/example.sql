/*
Тема: Приведение типов
Практический пример приведения типов
Создадим функцию, которая ничего не возвращает
    RAISE NOTICE 'ran %', money_val;
логируем переменную money_val
 */
CREATE OR REPLACE FUNCTION type_testing(money_val int)
RETURNS void AS $$
    BEGIN
        RAISE NOTICE 'run %', money_val;
    END;
$$ LANGUAGE plpgsql;

SELECT type_testing(1);
-- Output: run 1

-- SELECT type_testing(0.5);
-- Output: ошибка

SELECT type_testing(0.5::int);
SELECT type_testing(CAST(0.5 AS int));
-- Output: run 1
-- приведение к целому округляется до ближайшего целого
-- (два одинаковых примера) один короткий, другой через CAST

SELECT type_testing('1.5'::numeric::int);
-- Output: 2
-- Можно преобразовать строку в число через numeric

SELECT 'abc' || 1;
-- Output: abc1

SELECT ' 10 ' = 10;
-- Output: true
-- приводится к числу и сравнивается левая сторона