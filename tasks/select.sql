
-- Найдите номер модели, скорость и размер жесткого диска для всех
-- ПК стоимостью менее 500 дол.
-- Вывести: model, speed и hd

SELECT model, speed, hd
FROM PC
WHERE price < 500;

-- Найдите производителей принтеров.
-- Вывести: maker

SELECT DISTINCT maker
FROM Product
WHERE type = 'Printer';

-- Найдите номер модели, объем памяти и размеры экранов
-- ПК-блокнотов, цена которых превышает 1000 дол.

SELECT model, ram, screen
FROM LAPTOP
WHERE price > 1000;

-- Найдите все записи таблицы Printer для цветных принтеров.

SELECT *
FROM Printer
WHERE color = 'y';

-- Найдите номер модели, скорость и размер жесткого диска ПК,
-- имеющих 12x или 24x CD и цену менее 600 дол.

SELECT model, speed, hd
FROM PC
WHERE (cd = '12x' or cd = '24x') and PRICE < 600;

-- Для каждого производителя, выпускающего ПК-блокноты c объёмом
-- жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов.
-- Вывод: производитель, скорость.

SELECT DISTINCT maker, speed
FROM Product p INNER JOIN Laptop l ON p.model = l.model
WHERE hd >= 10;

-- Найдите номера моделей и цены всех имеющихся в продаже
-- продуктов (любого типа) производителя B (латинская буква).

SELECT p.model, price
FROM Product p
INNER JOIN PC pc
ON p.model = pc.model
WHERE maker = 'B'
UNION
SELECT p.model, price
FROM Product p
INNER JOIN Laptop l
ON p.model = l.model
WHERE maker = 'B'
UNION
SELECT p.model, price
FROM Product p
INNER JOIN Printer pr
ON p.model = pr.model
WHERE maker = 'B';

-- Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT maker FROM Product WHERE type = 'PC'
EXCEPT
SELECT maker FROM Product WHERE type = 'Laptop';

-- Найдите производителей ПК с процессором не менее 450 Мгц.
-- Вывести: Maker

SELECT DISTINCT maker
FROM Product pr
INNER JOIN PC pc
ON pr.model = pc.model
WHERE speed >= 450;

-- Найдите модели принтеров, имеющих самую высокую цену.
-- Вывести: model, price

SELECT model, price
FROM Printer
WHERE price = (SELECT MAX(price) FROM Printer);

-- Найдите среднюю скорость ПК.

SELECT AVG(speed)
FROM PC;

-- Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT AVG(speed)
FROM Laptop
WHERE price > 1000;