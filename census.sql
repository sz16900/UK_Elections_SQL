-- This file is for your solutions to the census question.
-- Lines starting with --! are recognised by a script that we will
-- use to automatically test your queries, so you must not change
-- these lines or create any new lines starting with this symbol.
--
-- You may break your queries over several lines, include empty
-- lines and SQL comments wherever you wish.
--
-- Remember that the answer to each question goes after the --!
-- marker for it and that the answer to each question must be
-- a single SQL query.
--
-- Upload this file to SAFE as part of your coursework.

--! !census!

--! question0

-- Sample solution to question 0.
SELECT data FROM Statistic WHERE wardId = 'E05001982' AND
occId = 2 AND gender = 0;

--! question1

SELECT data FROM Statistic WHERE gender = 1 AND occId = 7
AND wardId = 'E05001979';

--! question2

SELECT SUM(data) AS people FROM Statistic WHERE occId = 4 AND wardId = 'E05000697';

--! question3

SELECT name AS occ, SUM(data) AS num FROM Occupation JOIN Statistic ON
Statistic.occId = Occupation.id WHERE wardId = 'E05003701' GROUP BY occ;

--! question4

SELECT SUM(data) AS Working_Population, Ward.code, Ward.name AS Ward_Name, County.name
AS County_name FROM Statistic INNER JOIN (Ward, County) ON (Statistic.wardId = Ward.code
AND County.code = Ward.parent) GROUP BY Ward.code ORDER BY Working_Population DESC
LIMIT 1 OFFSET 0;

--! question5

SELECT COUNT(*) AS 'How many wards have at least 10’000 working inhabitants?' FROM
(SELECT SUM(data) AS Working_Population, Ward.code, Ward.name AS Ward_Name
FROM Statistic INNER JOIN Ward ON Statistic.wardId = Ward.code GROUP BY Ward.code
HAVING Working_Population >= 10000) AS new_table;

--! question6

SELECT Region.name AS name, AVG(wardPop) AS average FROM
(SELECT SUM(data) AS wardPop, County.parent AS Cparent FROM Statistic
JOIN (Ward, County) ON (Statistic.wardId = Ward.code AND Ward.parent = County.code)
GROUP BY Ward.code) AS t1 JOIN Region ON Cparent = Region.code GROUP BY Region.name;

--! question7

SELECT County.name AS CLU, Occupation.name AS occupation,
CASE Statistic.gender WHEN 1 THEN 'F' WHEN 0 THEN 'M' ELSE 'X' END AS gender, SUM(data) AS count
FROM Region JOIN (County, Ward, Statistic, Occupation)
ON (County.parent = Region.code AND Ward.parent = County.code AND Statistic.wardId = Ward.code
AND Statistic.occId = Occupation.id AND Region.code = 'E12000001')
GROUP BY County.name, Occupation.name, Statistic.gender HAVING count >= 10000 ORDER BY count ASC;


--! question8

SELECT t1.region AS region, t1.women, t2.men, (t1.women / t2.men)
AS `% of women to men in managerial positions` FROM (SELECT Region.name AS region,
SUM(data) AS women FROM Statistic JOIN (Ward, County, Region) ON (Statistic.wardId = Ward.code
AND County.code = Ward.parent AND Statistic.occId = 1 AND Statistic.gender = 1
AND Region.code = County.parent) GROUP BY Region.name) AS t1
JOIN
(SELECT Region.name AS region, SUM(data) AS men FROM Statistic
JOIN (Ward, County, Region) ON (Statistic.wardId = Ward.code
AND County.code = Ward.parent AND Statistic.occId = 1 AND Statistic.gender = 0
AND Region.code = County.parent) GROUP BY Region.name) AS t2 ON t1.region = t2.region
ORDER BY `% of women to men in manegerial positions` ASC;

--! question9

SELECT Region.name AS name, AVG(wardPop) AS average FROM
(SELECT SUM(data) AS wardPop, County.parent AS Cparent FROM Statistic
JOIN (Ward, County) ON (Statistic.wardId = Ward.code AND Ward.parent = County.code)
GROUP BY Ward.code) AS t1 JOIN Region ON Cparent = Region.code GROUP BY Region.name
UNION ALL
SELECT 'England' AS name, AVG(wardPop) FROM (SELECT SUM(data) AS wardPop FROM Statistic
JOIN (Ward, County, Region) ON (Statistic.wardId = Ward.code AND County.code = Ward.parent
AND Region.code = County.parent AND Region.parent = 'E92000001') GROUP BY Ward.code) AS t4
UNION ALL
SELECT 'All' AS name, AVG(wardPop) AS average FROM (SELECT SUM(data) AS wardPop FROM Statistic
JOIN Ward ON Statistic.wardId = Ward.code GROUP BY Ward.code) AS t3;

--! !end!
