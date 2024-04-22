```
-- Table creation SQL
CREATE TABLE Spending (
    user_id INT,
    spend_date DATE,
    platform ENUM('desktop', 'mobile'),
    amount INT,
    PRIMARY KEY (user_id, spend_date, platform)
);

-- Data insertion SQL
INSERT INTO Spending (user_id, spend_date, platform, amount) VALUES
(1, '2019-07-01', 'mobile', 100),
(1, '2019-07-01', 'desktop', 100),
(2, '2019-07-01', 'mobile', 100),
(2, '2019-07-02', 'mobile', 100),
(3, '2019-07-01', 'desktop', 100),
(3, '2019-07-02', 'desktop', 100);
```


- QUERY SQL

```sql
WITH TEMP AS
  (SELECT spend_date,
          platform,
          user_id,
          sum(amount) AS amount
   FROM Spending s
   GROUP BY spend_date,
            platform,
            user_id
   ORDER BY spend_date,
            user_id)
SELECT spend_date,
       count(user_id),
       CASE
           WHEN platforms = 'desktop,mobile' THEN 'both'
           WHEN platforms = 'desktop' THEN 'desktop'
           WHEN platforms = 'mobile' THEN 'mobile'
       END AS platforms,
       sum(amount)
FROM
  (SELECT spend_date,
          user_id,
          GROUP_CONCAT(platform) AS platforms,
          sum(amount) amount
   FROM Spending
   GROUP BY spend_date,
            user_id) t1
GROUP BY spend_date,
         platforms
```
