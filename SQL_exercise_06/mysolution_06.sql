
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
    
SELECT s.Name, p.Name, p.Hours
FROM assignedto a, scientists s, projects p 
WHERE a.Project = p.Code 
AND a.Scientist = s.SSN
ORDER BY p.Name ASC, s.Name ASC;


-- 6.2 Select the project names which are not assigned yet
SELECT  * 
FROM 
    (SELECT * 
    FROM projects p 
    LEFT OUTER JOIN  assignedto a ON p.Code = a.Project) x
WHERE Scientist IS NULL;

SELECT * 
    FROM projects p 
    WHERE p.Code NOT IN 
    (
        SELECT DISTINCT Project 
        FROM assignedto)

