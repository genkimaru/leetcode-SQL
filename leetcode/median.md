```
-- Create the Numbers table
CREATE TABLE Numbers (
    Number INT,
    Frequency INT
);

-- Insert data into the Numbers table
INSERT INTO Numbers (Number, Frequency) VALUES (0, 4);
INSERT INTO Numbers (Number, Frequency) VALUES (1, 4);
INSERT INTO Numbers (Number, Frequency) VALUES (2, 4);
INSERT INTO Numbers (Number, Frequency) VALUES (3, 4);
```

- Query SQL

```
with t1 as(
select *,
sum(frequency) over(order by number) as cum_sum, (sum(frequency) over())/2 as middle
from Numbers)

select avg(number) as median
from t1
where middle between (cum_sum - frequency) and cum_sum
```