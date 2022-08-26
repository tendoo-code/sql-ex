
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

-- Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(speed)
FROM PC pc
INNER JOIN product pr
ON pc.model = pr.model
WHERE pr.maker = 'A';

-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT s.class, name, country
FROM ships s
INNER JOIN classes c
ON c.class = s.class
WHERE c.numguns >= 10;

-- Найдите размеры жестких дисков, совпадающих у двух и более PC.
-- Вывести: HD

SELECT hd
FROM PC
GROUP BY hd
HAVING COUNT(hd) >= 2;

-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз,
-- т.е. (i,j), но не (j,i),
-- Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT pc_1.model, pc_2.model, pc_1.speed, pc_1.ram
FROM PC pc_1
INNER JOIN PC pc_2
ON pc_1.speed = pc_2.speed
AND pc_1.ram = pc_2.ram
AND pc_1.model != pc_2.model
AND pc_1.model > pc_2.model;

-- Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
-- Вывести: type, model, speed

SELECT DISTINCT type, l.model, speed
FROM Laptop l
INNER JOIN product p
ON l.model = p.model
WHERE speed < ALL (SELECT pc.speed FROM PC);

-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT DISTINCT maker, price
FROM printer p1
INNER JOIN product p2
ON p1.model = p2.model
WHERE price = (
    SELECT MIN(price)
    FROM printer
    WHERE color = 'y'
) AND color = 'y';

-- Для каждого производителя, имеющего модели в таблице Laptop,
-- найдите средний размер экрана выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.

SELECT maker, AVG(screen) as Avg_screen
FROM product p
INNER JOIN laptop l
ON p.model = l.model
GROUP BY maker;

-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК.
-- Вывести: Maker, число моделей ПК.

