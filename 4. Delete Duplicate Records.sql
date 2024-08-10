-- Step 1: select Database
use interview_db;

-- Step 2: Drop Table if exists
Drop table if exists SampleTable;

-- Step 3: Create the table and insert sample data
CREATE TABLE SampleTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    value INT
);

INSERT INTO SampleTable (name, value) VALUES
('Alice', 10),
('Bob', 20),
('Alice', 10),
('Charlie', 30),
('Alice', 10),
('Bob', 20),
('David', 40);

-- Method 1: Using a Temporary Table
CREATE TEMPORARY TABLE temp_table AS
SELECT MIN(id) as id
FROM SampleTable
GROUP BY name, value;

select * from temp_table;

DELETE FROM SampleTable
WHERE id NOT IN (SELECT id FROM temp_table);

DROP TEMPORARY TABLE temp_table;

-- Verify the result
SELECT * FROM SampleTable;

-- Re-insert the sample data for the next method
TRUNCATE TABLE SampleTable;

INSERT INTO SampleTable (name, value) VALUES
('Alice', 10),
('Bob', 20),
('Alice', 10),
('Charlie', 30),
('Alice', 10),
('Bob', 20),
('David', 40);

-- Method 2: Using CTE
WITH CTE AS (
    SELECT 
        id,
        ROW_NUMBER() OVER (PARTITION BY name, value ORDER BY id) AS row_num
    FROM SampleTable
)
DELETE FROM SampleTable
WHERE id IN (
    SELECT id FROM CTE WHERE row_num > 1
);

-- Verify the result
SELECT * FROM SampleTable;

-- Re-insert the sample data for the next method
TRUNCATE TABLE SampleTable;

INSERT INTO SampleTable (name, value) VALUES
('Alice', 10),
('Bob', 20),
('Alice', 10),
('Charlie', 30),
('Alice', 10),
('Bob', 20),
('David', 40);

-- Method 3: Using a Self-Join
DELETE t1 FROM SampleTable t1
INNER JOIN SampleTable t2 
WHERE 
    t1.id > t2.id AND 
    t1.name = t2.name AND 
    t1.value = t2.value;

-- Verify the result
SELECT * FROM SampleTable;
