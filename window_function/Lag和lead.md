
## LAG 和 LEAD 的用法

* 原始数据
```sql
mysql> select * from test;
+------+------+
| id   | num  |
+------+------+
|    1 |    1 |
|    2 |    1 |
|    3 |    1 |
|    4 |    2 |
|    5 |    1 |
|    6 |    2 |
|    7 |    2 |
+------+------+
```

* LAG(column_name , 落后的行数，默认值)
``` sql
mysql> select lag(id , 1 , 999) over(order by id ) id_lag , id from test;
+--------+------+
| id_lag | id   |
+--------+------+
|    999 |    1 |
|      1 |    2 |
|      2 |    3 |
|      3 |    4 |
|      4 |    5 |
|      5 |    6 |
|      6 |    7 |
+--------+------+
```


* LEAD(column_name , 领先的行数，默认值)
```sql 
mysql> select lead(id , 1 , 999) over(order by id ) id_lead , id from test;
+---------+------+
| id_lead | id   |
+---------+------+
|       2 |    1 |
|       3 |    2 |
|       4 |    3 |
|       5 |    4 |
|       6 |    5 |
|       7 |    6 |
|     999 |    7 |
+---------+------+
```
