 
 -  Create salary table and  Insert data into salary table
```
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
```

select pay_date, department_id , 
case 
 when month_dep_avg >  month_avg then 'higher'
 when month_dep_avg <  month_avg then 'lower'
 else 'same'
end as comparison from (
select  pay_date , month_dep_avg , department_id , avg(month_dep_avg) over(partition by pay_date) as month_avg from (
select s.pay_date as pay_date , avg(s.amount) as month_dep_avg, e.department_id from 
(select date_format(pay_date,'%Y-%m') as pay_date , employee_id , amount  from salary 
) s left join employee e 
on s.employee_id = e.employee_id
group by  pay_date , department_id
) t
) t2 order by pay_date desc 

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