# Select Database
use interview_db;  

drop table if exists Transactions;
drop table if exists Customer;
drop table if exists Merchants;


# Create Customer
CREATE TABLE Customer (
    CustomerID VARCHAR(3) primary key,
    CustomerSegment VARCHAR(10),
    CustomerCity VARCHAR(20)
);

# Create Merchants
CREATE TABLE Merchants (
    MerchantID VARCHAR(2) primary key,
    MerchantName VARCHAR(20)
);

# Create Transactions
CREATE TABLE Transactions (
    TransactionID INT,
    OrderDate DATE,
    CustomerID VARCHAR(3),
    MerchantID VARCHAR(2),
    TransactionAmount INT,
    TransactionStatus VARCHAR(10),
    foreign key(CustomerID) references Customer(CustomerID),
    foreign key(MerchantID) references Merchants(MerchantID)    
);

-- Insert data into Customer
INSERT INTO Customer VALUES
('C1', 'New', 'Delhi'),
('C2', 'New', 'Kolkata'),
('C3', 'Repeat', 'Mumbai');

-- Insert data into Merchants
INSERT INTO Merchants VALUES
('M1', 'Airtel'),
('M2', 'Jio');

-- Insert data into Transactions
INSERT INTO Transactions VALUES
(1234, '2021-06-02','C1' , 'M1', 450, 'Success'),
(2134, '2021-06-07','C2' , 'M1', 450, 'Success'),
(1234, '2021-06-014','C1' , 'M2', 320, 'Fail');

select * from Customer;
select * from Merchants;
select * from Transactions;

# Question:- Write a SQL code to get the total number of “New” 
-- customers who did a successful transaction in the month of June 2021?

-- columns:-
# Customer - CustomerSegment, CustomerID 
# Transactions - TransactionStatus, OrderDate

# Steps:-
# 1. join tables
# 2. filter tables
# 3. count customers

select count(distinct customerid) as new_customer
from Transactions t
left join Customer c using(CustomerID)
where CustomerSegment='New' and
    TransactionStatus='Success' and 
    month(orderdate)=6 and
    year(orderdate)=2021;





















