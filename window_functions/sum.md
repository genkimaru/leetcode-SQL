## 累加sum() over( partition by  order by )

*  累加
```sql
mysql> select id ,num, sum(num) over (order by id ) as cumulative_sum  from test
;
+------+------+----------------+
| id   | num  | cumulative_sum |
+------+------+----------------+
|    1 |    1 |              1 |
|    2 |    1 |              2 |
|    3 |    1 |              3 |
|    4 |    2 |              5 |
|    5 |    1 |              6 |
|    6 |    2 |              8 |
|    7 |    2 |             10 |
|    8 |    3 |             13 |
|    9 |    3 |             16 |
+------+------+----------------+

```

*  对分块数据进行累加
``` sql 

mysql> select id , num , sum(num) over(partition by ntile_number ) from ( select id ,num,
    -> ntile(3) over (order by id ) as ntile_number from test) tmp ;
+------+------+-------------------------------------------+
| id   | num  | sum(num) over(partition by ntile_number ) |
+------+------+-------------------------------------------+
|    1 |    1 |                                         3 |
|    2 |    1 |                                         3 |
|    3 |    1 |                                         3 |
|    4 |    2 |                                         5 |
|    5 |    1 |                                         5 |
|    6 |    2 |                                         5 |
|    7 |    2 |                                         8 |
|    8 |    3 |                                         8 |
|    9 |    3 |                                         8 |
+------+------+-------------------------------------------+

```
