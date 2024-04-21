 
 -  Create salary table and  Insert data into salary table
```sql
CREATE TABLE salary (
    id INT,
    employee_id INT,
    amount INT,
    pay_date DATE
);

INSERT INTO salary (id, employee_id, amount, pay_date) VALUES
(1, 1, 9000, '2017-03-31'),
(2, 2, 6000, '2017-03-31'),
(3, 3, 10000, '2017-03-31'),
(4, 1, 7000, '2017-02-28'),
(5, 2, 6000, '2017-02-28'),
(6, 3, 8000, '2017-02-28');
```

- Create employee table and  Insert data into employee table
```
CREATE TABLE employee (
    employee_id INT,
    department_id INT
);


INSERT INTO employee (employee_id, department_id) VALUES
(1, 1),
(2, 2),
(3, 2);
```

----

- Query SQL
```sql

SELECT pay_date,
       department_id,
       CASE
           WHEN month_dep_avg > month_avg THEN 'higher'
           WHEN month_dep_avg < month_avg THEN 'lower'
           ELSE 'same'
       END AS comparison
FROM
  (SELECT pay_date,
          month_dep_avg,
          department_id,
          avg(month_dep_avg) over(PARTITION BY pay_date) AS month_avg
   FROM
     (SELECT s.pay_date AS pay_date,
             avg(s.amount) AS month_dep_avg,
             e.department_id
      FROM
        (SELECT date_format(pay_date, '%Y-%m') AS pay_date,
                employee_id,
                amount
         FROM salary) s
      LEFT JOIN employee e ON s.employee_id = e.employee_id
      GROUP BY pay_date,
               department_id) t) t2
ORDER BY pay_date DESC

```

- result 
```
+----------+---------------+------------+
| pay_date | department_id | comparison |
+----------+---------------+------------+
| 2017-03  |             1 | higher     |
| 2017-03  |             2 | lower      |
| 2017-02  |             1 | same       |
| 2017-02  |             2 | same       |
+----------+---------------+------------+



```