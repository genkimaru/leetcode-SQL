/*
 
 Problem Statement
 We are given a Logs table structured as:
 
 Column Name	Type
 id	int
 num	varchar
 The id column is the primary key and is an autoincrement column.
 
 Our task is to write an SQL query to find all numbers that appear at least three times 
 consecutively. We can return the result table in any order.
 */
WITH consecutive_group AS (
    SELECT
        num,
        CASE
            WHEN LAG(num, 2) OVER ( ORDER BY id) = LAG(num, 1) OVER ( ORDER BY id) AND LAG(num, 1) OVER (ORDER BY id) = num  
            THEN 1
            WHEN LAG(num, 1) OVER (ORDER BY id) = num AND num = LEAD(num, 1) OVER (ORDER BY id) 
            THEN 1
            WHEN num = LEAD(num, 1) OVER ( ORDER BY id) AND LEAD(num, 1) OVER (ORDER BY id) = LEAD(num, 2) OVER (ORDER BY id) 
            THEN 1
            ELSE 0
        END is_valid
    FROM
        test
)
SELECT
    DISTINCT num ConsecutiveNums
FROM
    consecutive_group
WHERE
    is_valid = 1