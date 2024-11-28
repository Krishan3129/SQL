SELECT name 
FROM world
WHERE GDP > 
	  (
		SELECT MAX(gdp) 
	  	FROM world 
	   	WHERE continent LIKE 'Europe'
	)
