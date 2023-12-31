--This was used to insert some of the missing manufacturers(Mercedes-Benz,Porsche & TATA motors)--
INSERT INTO [automakers_stocks_2010-2022](Date, [Open], High, Low, [Close], Adj_Close, Volume)
SELECT Date, [Open], High, Low, [Close], Adj_Close, Volume
FROM [MBG.DE]

INSERT INTO [automakers_stocks_2010-2022](Date, [Open], High, Low, [Close], Adj_Close, Volume)
SELECT Date, [Open], High, Low, [Close], Adj_Close, Volume
FROM [P911.DE]

INSERT INTO [automakers_stocks_2010-2022](Date, [Open], High, Low, [Close], Adj_Close, Volume)
SELECT Date, [Open], High, Low, [Close], Adj_Close, Volume
FROM [TATAMOTORS.NS]
	
--This was used to fill up the NULL values where the Symbol was missing--
UPDATE [automakers_stocks_2010-2022]
SET Symbol = 'MBG.DE' 
WHERE Symbol is NULL

UPDATE [automakers_stocks_2010-2022]
SET Symbol = 'P911.DE' 
WHERE Symbol is NULL

UPDATE [automakers_stocks_2010-2022]
SET Symbol = 'TATAMOTORS.NS' 
WHERE Symbol is NULL

--Using inner join to merge the two tables with specific columns.
SELECT car_stock.Date,car_names.Name, car_names.Symbol,car_names.country,car_names.Rank,car_names.price_USD,
	   car_stock.Adj_Close,car_stock.Close_,car_stock.Open_, car_stock.High,car_stock.Low,car_stock.Volume
FROM Largest_automakers_by_market_capitalization AS car_names

INNER JOIN [automakers_stocks_2010-2022] AS car_stock
ON car_names.Symbol = car_stock.Symbol

--N.B: The results were saved as [Top 50 Automakers] and used for the Analysis Process--


--Ranking the most valuable Car manufacturers--
SELECT DISTINCT(Name),rank
FROM [Top 50 Automakers]
ORDER BY rank


--Recent prices that a share of stock is trading for on the market.--
SELECT DISTINCT Name, Price_USD
FROM [Top 50 Automakers]
GROUP BY Name, Price_USD
ORDER BY Price_USD DESC


--Comparison of the average adjusted closing price across 10 years--
WITH cte1 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2012'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY Name) ,
	 
	 cte2 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2013'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY Name) ,

	cte3 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2014'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2014-01-01' AND '2014-12-31'
GROUP BY Name) ,

	cte4 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2015'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY Name) ,

	cte5 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2016'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY Name) ,

	cte6 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2017'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY Name) ,

	cte7 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2018'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY Name) ,

	cte8 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2019'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY Name) ,

	cte9 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2020'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY Name) ,
	cte10 AS (SELECT DISTINCT[Name] AS Auto_name,AVG(adjusted_close_price) AS '2021'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY Name) 

SELECT cte1.Auto_name, cte1.[2012], cte2.[2013], cte3.[2014], 
	cte4.[2015], cte5.[2016], cte6.[2017], cte7.[2018], 
	cte8.[2019], cte9.[2020], cte10.[2021]
FROM cte2
LEFT JOIN cte1
ON cte2.Auto_name = cte1.Auto_name
LEFT JOIN cte3
ON cte2.Auto_name = cte3.Auto_name
LEFT JOIN cte4
ON cte2.Auto_name = cte4.Auto_name
LEFT JOIN cte5
ON cte2.Auto_name = cte5.Auto_name
LEFT JOIN cte6
ON cte2.Auto_name = cte6.Auto_name
LEFT JOIN cte7
ON cte2.Auto_name = cte7.Auto_name
LEFT JOIN cte8
ON cte2.Auto_name = cte8.Auto_name
LEFT JOIN cte9
ON cte2.Auto_name = cte9.Auto_name
LEFT JOIN cte10
ON cte2.Autoname = cte10.Auto_name


--Counting the car manufacturers by Country--
SELECT Country, COUNT(DISTINCT Name) AS Manufacturer_count_by_country
FROM [Top 50 Automakers]
GROUP BY Country
ORDER BY Manufacturer_count_by_country DESC


--Comparing the Volume for each Manufacturer from 2012-2021--
WITH vol1 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2012'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY Name) ,
	
	vol2 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2013'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY Name) ,
	
	vol3 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2014'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2014-01-01' AND '2014-12-31'
GROUP BY Name) ,

	vol4 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2015'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY Name) ,

vol5 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2016'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY Name) ,

vol6 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2017'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY Name) ,

vol7 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2018'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY Name) ,

vol8 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2019'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY Name) ,

vol9 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2020'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY Name) ,

vol10 AS (SELECT DISTINCT[Name],(AVG(CONVERT(bigint,Volume))) AS '2021'
FROM [Top 50 Automakers]
WHERE Date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY Name)
	 
SELECT vol1.Name, vol1.[2012], vol2.[2013], vol3.[2014], vol4.[2015], 
	vol5.[2016], vol6.[2017],vol7.[2018], vol8.[2019],vol9.[2020], vol10.[2021]
FROM vol1
LEFT JOIN vol2
ON vol1.Name = vol2.Name
LEFT JOIN vol3
ON vol1.Name = vol3.Name
LEFT JOIN vol4
ON vol1.Name = vol4.Name
LEFT JOIN vol5
ON vol1.Name = vol5.Name
LEFT JOIN vol6
ON vol1.Name = vol6.Name
LEFT JOIN vol7
ON vol1.Name = vol7.Name
LEFT JOIN vol8
ON vol1.Name = vol8.Name
LEFT JOIN vol9
ON vol1.Name = vol9.Name
LEFT JOIN vol10
ON vol1.Name = vol10.Name

--N.B: Some Manufacturers are missing like Porsche in paarticular as their stock market for their supercar division started as late as October 2022--



