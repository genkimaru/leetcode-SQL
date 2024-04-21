## 分区累加sum() over( partition by  order by )
## 分区平均avg() over( partition by  order by )

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

## **定义窗口大小**
>窗口函数中，ROWS后面可以接的参数主要有以下几种：

> *  BETWEEN n PRECEDING AND m FOLLOWING: 这种形式指定了窗口的大小为当前行向前n行和向后m行的范围。例如，ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING表示窗口包括当前行和前两行以及后两行共5行。

> *  BETWEEN n PRECEDING AND CURRENT ROW: 这种形式指定了窗口的大小为当前行向前n行的范围。例如，ROWS BETWEEN 2 PRECEDING AND CURRENT ROW表示窗口包括当前行和前两行共3行。

> *  BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW: 这种形式指定了窗口的大小为从开头到当前行的范围。例如，ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW表示窗口包括从开头到当前行的所有行。

> *  BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING: 这种形式指定了窗口的大小为从当前行到末尾的范围。例如，ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING表示窗口包括从当前行到末尾的所有行。


* 例子
sum() over( partition by  order by ) ROWS BETWEEN 2 preceding AND CURRENT ROW