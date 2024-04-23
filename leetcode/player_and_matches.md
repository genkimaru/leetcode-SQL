```
-- Create Players table
CREATE TABLE Players (
    player_id INT,
    group_id INT,
    PRIMARY KEY (player_id)
);

-- Insert data into Players table
INSERT INTO Players (player_id, group_id) VALUES
(15, 1),
(25, 1),
(30, 1),
(45, 1),
(10, 2),
(35, 2),
(50, 2),
(20, 3),
(40, 3);

-- Create Matches table
CREATE TABLE Matches (
    match_id INT,
    first_player INT,
    second_player INT,
    first_score INT,
    second_score INT,
    PRIMARY KEY (match_id)
);

-- Insert data into Matches table
INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES
(1, 15, 45, 3, 0),
(2, 30, 25, 1, 2),
(3, 30, 15, 2, 0),
(4, 40, 20, 5, 2),
(5, 35, 50, 1, 1);

```
- QUERY SQL
```
WITH t AS
  (SELECT m.*,
          p.group_id
   FROM
     (SELECT match_id,
             first_player AS player_id,
             first_score AS score
      FROM Matches
      UNION ALL SELECT match_id,
                       second_player,
                       second_score
      FROM Matches) m
   JOIN Players p ON m.player_id = p.player_id)


SELECT 
       group_id ,min(player_id)
FROM
  (SELECT t2.*,
          rank() over(PARTITION BY group_id
                      ORDER BY score) AS rk
   FROM
     (SELECT player_id,
             group_id,
             max(score) score
      FROM t
      GROUP BY group_id,
               player_id
      ORDER BY group_id,
               player_id) t2) t3
WHERE rk = 1
GROUP BY group_id
```