
SELECT 
    class
FROM (
    SELECT 
        class,
        COUNT(1) AS ct
    FROM (
        SELECT
            class,
            student
        FROM 
            courses
        GROUP BY 1,2
    ) A
    GROUP BY 1
) B
WHERE ct >= 5
;
