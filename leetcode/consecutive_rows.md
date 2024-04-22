```
-- Create the stadium table
CREATE TABLE stadium (
    id INT PRIMARY KEY,
    visit_date DATE,
    people INT
);

-- Insert data into the stadium table
INSERT INTO stadium (id, visit_date, people) VALUES (1, '2017-01-01', 10);
INSERT INTO stadium (id, visit_date, people) VALUES (2, '2017-01-02', 109);
INSERT INTO stadium (id, visit_date, people) VALUES (3, '2017-01-03', 150);
INSERT INTO stadium (id, visit_date, people) VALUES (4, '2017-01-04', 99);
INSERT INTO stadium (id, visit_date, people) VALUES (5, '2017-01-05', 145);
INSERT INTO stadium (id, visit_date, people) VALUES (6, '2017-01-06', 1455);
INSERT INTO stadium (id, visit_date, people) VALUES (7, '2017-01-07', 199);
INSERT INTO stadium (id, visit_date, people) VALUES (8, '2017-01-08', 188);
```


- QUERY SQL
```

select * from(
select s.* , lag(people , 1 , 0) over() as yesterday , lag(people , 2 , 0) over() as before_yesterday
from stadium s ) t1
where people >= 100  and yesterday >= 100 and before_yesterday >= 100;
```


- QUERY SQL
```
select * from stadium s1 join stadium s2 on s1.id = (s2.id - 1)
join stadium s3 on s1.id = (s3.id -2)
where s1.people >= 100 and s2.people >= 100 and s3.people >= 100;
```