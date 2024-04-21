```
-- Creation Table SQL for Department
CREATE TABLE Department (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);
-- Creation Table SQL for Employee
CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    DepartmentId INT,
    FOREIGN KEY (DepartmentId) REFERENCES Department(Id)
);
-- Data Insertion SQL for Department
INSERT INTO Department (Id, Name) VALUES
(1, 'IT'),
(2, 'Sales');

-- Data Insertion SQL for Employee
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES
(1, 'Joe', 85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam', 60000, 2),
(4, 'Max', 90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will', 70000, 1);


```
- SQL Query
```
SELECT employee,
       salary,
       department
FROM
  (SELECT e.name AS employee,
          e.salary,
          d.name AS department,
          dense_rank() OVER (PARTITION BY d.name
                             ORDER BY e.salary DESC) AS salary_rank
   FROM Employee e
   JOIN Department d ON e.departmentid = d.id) t
WHERE salary_rank <4 ;

```

- result
```
+----------+--------+------------+
| employee | salary | department |
+----------+--------+------------+
| Max      |  90000 | IT         |
| Randy    |  85000 | IT         |
| Joe      |  85000 | IT         |
| Will     |  70000 | IT         |
| Henry    |  80000 | Sales      |
| Sam      |  60000 | Sales      |
+----------+--------+------------+

```