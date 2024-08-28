--  12.SQL query to find employees hired in last n months/day/year

Create table NEmployees
(
     ID int primary key auto_increment,
     FirstName varchar(50),
     LastName varchar(50),
     Gender varchar(50),
     Salary int,
     HireDate Date
);


INSERT INTO NEmployees (FirstName, LastName, Gender, Salary, HireDate) 
VALUES
('Mark', 'Hastings', 'Male', 60000, '2023-10-05'),
('Steve', 'Pound', 'Male', 45000, '2023-04-20'),
('Ben', 'Hoskins', 'Male', 70000, '2023-04-05'),
('Philip', 'Hastings', 'Male', 45000, '2023-03-11'),
('Mary', 'Lambeth', 'Female', 30000, '2023-03-10'),
('Valarie', 'Vikings', 'Female', 35000, '2023-02-09'),
('John', 'Stanmore', 'Male', 80000, '2023-02-22'),
('Able', 'Edward', 'Male', 5000, '2023-01-22'),
('Emma', 'Nan', 'Female', 5000, '2023-01-14'),
('Jd', 'Nosin', 'Male', 6000, '2023-01-10'),
('Todd', 'Heir', 'Male', 7000, '2023-02-14'),
('San', 'Hughes', 'Male', 7000, '2023-03-15'),
('Nico', 'Night', 'Male', 6500, '2023-04-19'),
('Martin', 'Jany', 'Male', 5500, '2023-05-23'),
('Mathew', 'Mann', 'Male', 4500, '2023-06-23'),
('Baker', 'Barn', 'Male', 3500, '2023-07-23'),
('Mosin', 'Barn', 'Male', 8500, '2023-08-21'),
('Rachel', 'Aril', 'Female', 6500, '2023-09-14'),
('Pameela', 'Son', 'Female', 4500, '2023-10-14'),
('Thomas', 'Cook', 'Male', 3500, '2023-11-14'),
('Malik', 'Md', 'Male', 6500, '2023-12-14'),
('Josh', 'Anderson', 'Male', 4900, '2024-01-05'),
('Geek', 'Ging', 'Male', 2600, '2024-01-04'),
('Sony', 'Sony', 'Male', 2900, '2024-04-30'),
('Aziz', 'Sk', 'Male', 3800, '2024-03-01'),
('Amit', 'Naru', 'Male', 3100, '2024-03-31');

select * from nemployees
order by hiredate desc;


SELECT *, TIMESTAMPDIFF(MONTH, HireDate, CURDATE()) AS diff
FROM NEmployees
WHERE HireDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH) -- Filter employees hired in the last 3 months
AND HireDate <= CURDATE() -- Ensure HireDate is not greater than the current date
ORDER BY HireDate DESC;