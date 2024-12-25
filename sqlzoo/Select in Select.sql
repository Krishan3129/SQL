--name	continent	area	population	gdp
-- Afghanistan	Asia	652230	25500100	20343000000
-- Albania	Europe	28748	2831741	12960000000
-- Algeria	Africa	2381741	37100000	188681000000
-- Andorra	Europe	468	78115	3712000000
-- Angola	Africa	1246700	20609294	100990000000



-- Contents
-- 1	Bigger than Russia
SELECT name 
FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')


-- 2	Richer than UK

select name
from world
where continent = 'Europe' and  gdp/population> 
(select gdp/population
from world
where name = 'United Kingdom'
)


-- 3	Neighbours of Argentina and Australia
select name, continent
from world
where continent IN 
(
select continent  
from world
where name ='Argentina' or name = 'Australia'
)
order by name


-- 4	Between Canada and Poland
select name, population
from world
where population > 
(select population
from world
where name= 'United Kingdom' 
) 
AND population < (
select population
from world
where  name = 'Germany'
)

-- 5	Percentages of Germany

SELECT name, CONCAT(ROUND(100*population/(SELECT population
                          FROM world 
                          WHERE name= 'Germany') ),'%')
FROM world
WHERE continent = 'Europe'


-- 6	Bigger than every country in Europe


-- 7	Largest in each continent
-- 8	First country of each continent (alphabetically)
-- 9	Difficult Questions That Utilize Techniques Not Covered In Prior Sections
-- 10	Three time bigger

