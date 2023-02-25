/*
Пример 10. Использование WHILE в числах Фибоначи.
Числа Фибоначи - это сумма двух предыдущих:
1, 1, 2, 3, 5, 8, 13, 21...

Входной параметр n - какое по порядку число вернуть,
например 6-е число = 8, а 7-е число = 13
 */

CREATE OR REPLACE FUNCTION fib(n int) RETURNS int AS $$
DECLARE
    counter int := 0;
    i int := 0;
    j int := 1;
BEGIN
    IF n < 1 THEN RETURN 0;
    END IF;

    WHILE counter < n
    LOOP
        counter := counter + 1;
        SELECT j, i+j INTO i, j;
-- (j записываем в i, а в j записываем i + j)
    END LOOP;
    RETURN i;
END;
$$ LANGUAGE plpgsql;

SELECT fib(6); -- 6 число = 8
SELECT fib(7); -- 7 число = 13