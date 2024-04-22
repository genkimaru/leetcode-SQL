```sql
-- Create Users table
CREATE TABLE Users (
    Users_Id INT PRIMARY KEY,
    Banned ENUM('Yes', 'No'),
    Role ENUM('client', 'driver', 'partner')
);

-- Insert data into Users table
INSERT INTO Users (Users_Id, Banned, Role) VALUES
(1, 'No', 'client'),
(2, 'Yes', 'client'),
(3, 'No', 'client'),
(4, 'No', 'client'),
(10, 'No', 'driver'),
(11, 'No', 'driver'),
(12, 'No', 'driver'),
(13, 'No', 'driver');

-- Create Trips table
CREATE TABLE Trips (
    Id INT PRIMARY KEY,
    Client_Id INT,
    Driver_Id INT,
    City_Id INT,
    Status ENUM('completed', 'cancelled_by_driver', 'cancelled_by_client'),
    Request_at DATE,
    FOREIGN KEY (Client_Id) REFERENCES Users(Users_Id),
    FOREIGN KEY (Driver_Id) REFERENCES Users(Users_Id)
);

-- Insert data into Trips table
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) VALUES
(1, 1, 10, 1, 'completed', '2013-10-01'),
(2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),
(3, 3, 12, 6, 'completed', '2013-10-01'),
(4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),
(5, 1, 10, 1, 'completed', '2013-10-02'),
(6, 2, 11, 6, 'completed', '2013-10-02'),
(7, 3, 12, 6, 'completed', '2013-10-02'),
(8, 2, 12, 12, 'completed', '2013-10-03'),
(9, 3, 10, 12, 'completed', '2013-10-03'),
(10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');
```


> -  write a SQL query to find the cancellation rate of requests made by unbanned users (both client and driver must be unbanned) between Oct 1, 2013 and Oct 3, 2013. The cancellation rate is computed by dividing the number of canceled (by client or driver) requests made by unbanned users by the total number of requests made by unbanned users. 
> - For the above tables, your SQL query should return the following rows with the cancellation rate being rounded to two decimal places.


- QUERY SQL
```sql

with temp as (
select   t1.* from 
   ( select  t.* , u.banned as client_banned  from Trips  t 
    join Users u on u.Users_Id= t.Client_Id ) t1
    join Users u on u.Users_Id = t1.Driver_Id 
    where u.Banned = 'No' and client_banned = 'No'
    and Request_at >= '2013-10-01' and Request_at <='2013-10-03'
) 
select Request_at , round((total_cnt - completed_cnt) / total_cnt , 2) as  cancellation_rate
from(
select  Request_at, 
count(*) as total_cnt ,
count(case when status = 'completed' then 1 else null end ) as completed_cnt
from temp group by Request_at
) t3;

```
- result 
```
+------------+-------------------+
| Request_at | cancellation_rate |
+------------+-------------------+
| 2013-10-01 |              0.33 |
| 2013-10-02 |              0.00 |
| 2013-10-03 |              0.50 |
+------------+-------------------+
```



----
- tips : conbine these two SQLs into one SQL.
```sql
select  Request_at, count(*) as total_cnt from temp group by Request_at;

select Request_at , count(*)  from temp where status  = 'completed' group by Request_at;

```
- conbined 
```sql
select  Request_at, 
count(*) as total_cnt ,
count(case when status = 'completed' then 1 else null end ) valid_cnt
from temp group by Request_at;
```