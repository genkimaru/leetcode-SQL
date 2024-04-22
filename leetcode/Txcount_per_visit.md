```sql
CREATE TABLE Visits (
    user_id INT,
    visit_date DATE
);

CREATE TABLE Transactions (
    user_id INT,
    transaction_date DATE,
    amount INT
);

INSERT INTO Visits (user_id, visit_date) VALUES
(1, '2020-01-01'),
(2, '2020-01-02'),
(12, '2020-01-01'),
(19, '2020-01-03'),
(1, '2020-01-02'),
(2, '2020-01-03'),
(1, '2020-01-04'),
(7, '2020-01-11'),
(9, '2020-01-25'),
(8, '2020-01-28');

INSERT INTO Transactions (user_id, transaction_date, amount) VALUES
(1, '2020-01-02', 120),
(2, '2020-01-03', 22),
(7, '2020-01-11', 232),
(1, '2020-01-04', 7),
(9, '2020-01-25', 33),
(9, '2020-01-25', 66),
(8, '2020-01-28', 1),
(9, '2020-01-25', 99);
```


```
+---------+------------------+--------+------------+
| user_id | transaction_date | amount | visit_date |
+---------+------------------+--------+------------+
|    NULL | NULL             |   NULL | 2020-01-01 |
|    NULL | NULL             |   NULL | 2020-01-02 |
|    NULL | NULL             |   NULL | 2020-01-01 |
|    NULL | NULL             |   NULL | 2020-01-03 |
|       1 | 2020-01-02       |    120 | 2020-01-02 |
|       2 | 2020-01-03       |     22 | 2020-01-03 |
|       1 | 2020-01-04       |      7 | 2020-01-04 |
|       7 | 2020-01-11       |    232 | 2020-01-11 |
|       9 | 2020-01-25       |     99 | 2020-01-25 |
|       9 | 2020-01-25       |     66 | 2020-01-25 |
|       9 | 2020-01-25       |     33 | 2020-01-25 |
|       8 | 2020-01-28       |      1 | 2020-01-28 |
+---------+------------------+--------+-----------
```

- Query SQL
```
with t1 as (
select t.user_id , t.transaction_date,t.amount,v.visit_date from Visits v left join Transactions t on v.user_id = t.user_id
and v.visit_date = t.transaction_date)
select tx_cnt , coalesce(count(tx_cnt) ,0) from(
select transaction_date,user_id,
coalesce(count(*) ,0) tx_cnt 
from t1
group by transaction_date , user_id 
) t2
group by tx_cnt 
```
