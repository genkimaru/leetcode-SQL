## row_number() 的用法


* row_number()  over () ， over中没有接partition和order，将给每行分配一个唯一id
```sql
mysql> select id , num , row_number() over () as rowid from test;
+------+------+-------+
| id   | num  | rowid |
+------+------+-------+
|    1 |    1 |     1 |
|    2 |    1 |     2 |
|    3 |    1 |     3 |
|    4 |    2 |     4 |
|    5 |    1 |     5 |
|    6 |    2 |     6 |
|    7 |    2 |     7 |
+------+------+-------+

```
*  over中接上partition by  和 order by 

```sql
mysql> select id , num , row_number() over (partition by num order by id ) as ro
wid from test;
+------+------+-------+
| id   | num  | rowid |
+------+------+-------+
|    1 |    1 |     1 |
|    2 |    1 |     2 |
|    3 |    1 |     3 |
|    5 |    1 |     4 |
|    4 |    2 |     1 |
|    6 |    2 |     2 |
|    7 |    2 |     3 |
+------+------+-------+
```

*  over  中单独接partition by  或者 order by
``` sql
mysql> select id , num , row_number() over ( order by id desc ) as rowid from te
st;
+------+------+-------+
| id   | num  | rowid |
+------+------+-------+
|    7 |    2 |     1 |
|    6 |    2 |     2 |
|    5 |    1 |     3 |
|    4 |    2 |     4 |
|    3 |    1 |     5 |
|    2 |    1 |     6 |
|    1 |    1 |     7 |
+------+------+-------+
```