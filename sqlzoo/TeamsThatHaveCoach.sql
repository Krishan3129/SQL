-- Find thr date and team anme where coach is Fernando Santos
SELECT 
  game.mdate, eteam.teamname
FROM 
  game 
JOIN eteam 
ON (
  game.team1 = eteam.id)
WHERE eteam.coach like 'Fernando Santos'
