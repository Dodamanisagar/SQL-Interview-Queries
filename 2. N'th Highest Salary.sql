# select Database
use interview_db;

# drop table if exists
DROP TABLE IF EXISTS Employee;

# CREATE table Employees:-
Create table Employee
(
 ID int auto_increment primary key ,
 FirstName varchar(50),
 LastName varchar(50),
 Gender varchar(50),
 Salary int
);

# Insert records into Employee table
INSERT INTO Employee (FirstName, LastName, Gender, Salary)
VALUES
('Bob', 'Brown', 'Male', 27000),
('Charlie', 'Johnson', 'Male', 27000),
('Diana', 'Lee', 'Female', 26000),
('Frank', 'Black', 'Male', 24000),
('Grace', 'Green', 'Female', 24000),
('Hannah', 'Taylor', 'Female', 22000),
('Ivy', 'Wilson', 'Female', 21000),
('Larry', 'Moore', 'Male', 18000),
('Mona', 'Martin', 'Female', 16000),
('Nathan', 'Jackson', 'Male', 16000),
('Olivia', 'Lee', 'Female', 15000),
('Rita', 'Lewis', 'Female', 12000),
('Sam', 'Walker', 'Male', 10000);

# select all the records from Employee table
select * from employee;

# Nth highest Salary Using LIMIT

#Steps:-
# 1. Select distinct records from employee table.
# 2. Order them in Descending order.
# 3. Use Limit and offset to select the particular record.

SELECT DISTINCT Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 2 ;-- OFFSET (N-1) , 3rd highest salary

-- ------------------------------------------
# Nth Lowest Salary Using LIMIT

#Steps:-
# 1. Select distinct records from employee table.
# 2. Order them in Ascending order.
# 3. Use Limit and offset to select the particular record.

SELECT DISTINCT Salary
FROM Employee
ORDER BY Salary ASC
LIMIT 1 OFFSET 2 ;-- OFFSET (N-1), 3rd Lowest salary

-- ***********************************************************

# 2. Nth highest Salary Using Subquery

# Steps:-
# 1. Select distinct salaries:
# 2. Order the distinct salaries in descending order:
# 3. Limit the records to the Nth position:
# 4. Convert the limited result into a derived table: 
# 5. Order the derived table results in ascending order:
# 6. Limit the final result to 1 record:

select salary
from  (select distinct salary
		from employee
		order by salary desc
		limit 3) result  -- here 3 is acting as 'N'
order by salary
limit 1;

-- -------------------------------------------------------
#  Nth Lowest Salary Using Subquery

# Steps:-
# 1. Select distinct salaries:
# 2. Order the distinct salaries in Ascending order:
# 3. Limit the records to the Nth position:
# 4. Convert the limited result into a derived table: 
# 5. Order the derived table results in Descending order:
# 6. Limit the final result to 1 record:

select salary
from  (select distinct salary
		from employee
		order by salary ASC
		limit 3) result  -- here 3 is acting as 'N'
order by salary DESC
limit 1;

-- *******************************************************

# 3. Nth highest Salary Using Self-Join

# Steps:-
# 1. Join the Employee table with itself (SELF JOIN): 
# 2. Apply the condition (Left Table salary < Right Table salary):
# 3. Select the maximum salary of the left table:
# 4. Group the records by the left table's salary column:
# 5. Filter groups to find the Nth highest salary:

SELECT MAX(e1.Salary) AS NthHighestSalary
FROM Employee e1
LEFT JOIN Employee e2 ON e1.Salary < e2.salary
GROUP BY e1.Salary
HAVING COUNT(DISTINCT e2.Salary) = 1 ;-- (N-1)

-- --------------------------------------------------------
# Nth Lowest Salary Using Self-Join

# Steps:-
# 1. Join the Employee table with itself (SELF JOIN): 
# 2. Apply the condition (Left Table salary > Right Table salary):
# 3. Select the maximum salary of the left table:
# 4. Group the records by the left table's salary column:
# 5. Filter groups to find the Nth highest salary:

SELECT MAX(e1.Salary) AS NthLowestSalary
FROM Employee e1
LEFT JOIN Employee e2 ON e1.Salary < e2.salary
GROUP BY e1.Salary
HAVING COUNT(DISTINCT e2.Salary) = 1 ;-- (N-1)

-- ***************************************************

# 4. Nth highest Salary Using DENSE_RANK() Window Function

# STep:-
# 1. Rank the salaries using DENSE_RANK() in descending order of salary:
# 2. Create a Common Table Expression (CTE) to hold the ranked salaries:
# 3. Select the Nth highest salary:
WITH SalaryRanks AS (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rn
    FROM Employee
)
SELECT Salary 
FROM SalaryRanks
WHERE rn = 2; -- N

-- --------------------------------------------------------
# Nth Lowest Salary Using DENSE_RANK() Window Function

# STep:-
# 1. Rank the salaries using DENSE_RANK() in ascending order of salary:
# 2. Create a Common Table Expression (CTE) to hold the ranked salaries:
# 3. Select the Nth highest salary:
WITH SalaryRanks AS (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary ASC) AS rn
    FROM Employee
)
SELECT Salary 
FROM SalaryRanks
WHERE rn = 2; -- N



