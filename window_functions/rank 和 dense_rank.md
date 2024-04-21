## rank 和 dense_rank

```sql
mysql> select id, num , rank() over (order by num) as num_rank from test;
+------+------+----------+
| id   | num  | num_rank |
+------+------+----------+
|    1 |    1 |        1 |
|    2 |    1 |        1 |
|    3 |    1 |        1 |
|    5 |    1 |        1 |
|    4 |    2 |        5 |
|    6 |    2 |        5 |
|    7 |    2 |        5 |
+------+------+----------+
```


```sql
mysql> select id, num , dense_rank() over (order by num) as dense_num_rank from
test;
+------+------+----------------+
| id   | num  | dense_num_rank |
+------+------+----------------+
|    1 |    1 |              1 |
|    2 |    1 |              1 |
|    3 |    1 |              1 |
|    5 |    1 |              1 |
|    4 |    2 |              2 |
|    6 |    2 |              2 |
|    7 |    2 |              2 |
+------+------+----------------+

```