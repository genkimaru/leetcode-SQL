```
-- Create Student table
CREATE TABLE Student (
    student_id INT,
    student_name VARCHAR(50),
    PRIMARY KEY (student_id)
);

-- Insert data into Student table
INSERT INTO Student (student_id, student_name) VALUES
(1, 'Daniel'),
(2, 'Jade'),
(3, 'Stella'),
(4, 'Jonathan'),
(5, 'Will');

-- Create Exam table
CREATE TABLE Exam (
    exam_id INT,
    student_id INT,
    score INT,
    PRIMARY KEY (exam_id, student_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

-- Insert data into Exam table
INSERT INTO Exam (exam_id, student_id, score) VALUES
(10, 1, 70),
(10, 2, 80),
(10, 3, 90),
(20, 1, 80),
(30, 1, 70),
(30, 3, 80),
(30, 4, 90),
(40, 1, 60),
(40, 2, 70),
(40, 4, 80);
```

``` sql
WITH t1 AS
  (SELECT s.student_id,
          s.student_name,
          e.exam_id,
          e.score,
          max(e.score) over(PARTITION BY e.exam_id) AS maxscore,
          min(e.score) over(PARTITION BY e.exam_id) AS minscore
   FROM Student s
   JOIN Exam e ON s.student_id = e.student_id)
SELECT DISTINCT student_id,
                student_name
FROM t1
WHERE score != maxscore
  AND score != minscore
  AND student_id not in
    (SELECT DISTINCT student_id
     FROM t1
     WHERE score = maxscore
       OR score = minscore)
ORDER BY student_id;
```