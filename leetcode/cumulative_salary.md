
Write a SQL to get the cumulative sum of an employee's salary over a period of 3 months but exclude the most recent month.

```sql
CREATE TABLE EmployeeSalary (
    Id INT,
    Month INT,
    Salary INT
);
INSERT INTO EmployeeSalary (Id, Month, Salary) VALUES
(1, 1, 20),
(2, 1, 20),
(1, 2, 30),
(2, 2, 30),
(3, 2, 40),
(1, 3, 40),
(3, 3, 60),
(1, 4, 60),
(3, 4, 70);

```

```sql
with t1 as (
select * , max(month) over(partition by id) as recent_month from EmployeeSalary
)

SELECT id,
       MONTH,
       sum(salary) over(PARTITION BY id
                        ORDER BY id ROWS BETWEEN 2 preceding AND CURRENT ROW) as salary
FROM t1
WHERE MONTH < recent_month
ORDER BY id ASC,
         MONTH DESC ;

```

- result
```
+------+-------+--------+
| id   | MONTH | salary |
+------+-------+--------+
|    1 |     3 |     90 |
|    1 |     2 |     50 |
|    1 |     1 |     20 |
|    2 |     1 |     20 |
|    3 |     3 |    100 |
|    3 |     2 |     40 |
+------+-------+--------+
```