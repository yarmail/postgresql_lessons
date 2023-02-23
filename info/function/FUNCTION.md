<a href="/../../README.md">вернуться к оглавлению</a><br>

Тема: Функции <br><br>

**_Введение_**<br>
Функции - объект БД, принимающий аргументы и возвращающий результат.<br>
Функции делятся на SQL - функции и процедурные - PL/pgSQL - основной диалект,
есть и другие, но это основные.<br><br>

**_Синтаксис:_**
```
CREATE FUNCTION func_name([arg1, arg2...]) 
RETURNS data_type AS $$
--logic
$$ LANGUAGE lang
```
Также можно использовать выражение CREATE OR REPLACE, и в такой форме используется чаще <br>
Пример 1. Использование простой функции <br>
(файл <a href="example_01.sql">example_01.sql</a>) в этой папке. <br>
В данном случае используется диалект SQL (language SQL)
<details>
<summary>Результат выполнения в программе pgAdmin</summary>
<img src="example_01.png">
</details>
<br>

**_Скалярные функции_**<br>
Скалярные функции в качестве возврата имеют единственное значение <br>
Пример 2. Использование скалярной функции 
(файл <a href="example_02.sql">example_02.sql</a>).

<details>
<summary>Результат</summary>
<img src="example_02.png">
</details>
<br>

**_Функции с аргументами_**<br>
Аргументы которые мы получаем помечаются ключевым словом IN, 
исходящие аргументы - OUT, INOUT - входящие и исходящие аргументы, 
но их лучше не использовать, VARIADIC - массив входящих параметров, 
DEFAULT value - некоторым аргументам мы можем присваивать значения 
по умолчанию<br> 
Пример 3. Использование функции с входящими аргументами 
(<a href="example_03.sql">example_03.sql</a>)

<details>
<summary>Результат</summary>
<img src="example_03.png">
</details>
Пример 4. Использование функции с исходящими аргументами 
(<a href="example_04.sql">example_04.sql</a>)

<details>
<summary>Результат выполнения скрипта в IDE</summary>
<img src="example_04.png">
</details>

**_Возврат множества строк_**<br>
Есть несколько вриантов, среди них:<br>
~ RETURNS SETOF data_type - возврат n-значений типа data_type <br>
~ RETURNS SETOF table - если нужно вернуть все столбцы из таблицы<br>
~ RETURNS SETOF record - (только когда типы колонок неизвестны, 
желательно не использовать без необходимости)<br>
~ RETURNS TABLE (column_name data_type, ...) тоже самое, что и SETOF table,
но имеем возможность явно указать столбцы <br>
Пример 5. Использование функции RETURNS SETOF data_type 
(<a href="example_05.sql">example_05.sql</a>)

<details>
<summary>Результат выполнения скрипта в IDE</summary>
<img src="example_05.png">
</details>

Пример 6. Использование функции RETURNS SETOF table 
(<a href="example_06.sql">example_06.sql</a>)

<details>
<summary>Результат выполнения скрипта в IDE</summary>
<img src="example_06.png">
</details>
