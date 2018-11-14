use Training_24Oct18_Pune

-- SampleQ1--
Create Table Customers_1
(Customerid Int Unique NOT NULL,
CustomerName varchar(20) NOT NULL,
Address1 varchar(30),
Address2 varchar(30),
ContactNumber varchar(12) NOT NULL,
PostalCode varchar(10));

Select * from Customers_1;

-- SampleQ2 --
CREATE TABLE Employees_1
(EmployeeId int primary key,
Name nvarchar(255) NULL);

Select * from Employees_1;

-- SampleQ3 --
CREATE TABLE Contractors
(ContractorId INT NOT NULL PRIMARY KEY,
Name NVARCHAR(255) NULL);

Select * from Contractors;

-- Sample Q4 --
CREATE TABLE dbo.TestRethrow
(ID INT PRIMARY KEY);

Select * from dbo.TestRethrow;

--Q1. Create a user defined data type called Region, which would store a character string of size 15--
create type region_777 from varchar(20);

--Q2. Create a Default which would store the value ‘NA’ (North America’)
create default North_America as 'NA';

--3. Bind the default to the Alias Data Type of Q1 i.e. region
exec sp_bindefault North_America, region_777;

--4.
alter table Customers_1 add CustomerRegion region_777;

--5.
alter table Customers_1 add Gender char(1);

--6.
alter table Customers_1 add constraint gender_Ck777 check(gender='M'or gender='F' or gender='T');

--7.
create table orders12345
(OrdersID Int constraint order_nn1 NOT NULL IDENTITY(1000,1),
Customerld Int constraint order_nn2 NOT NULL,
OrdersDate Datetime,
OrderState char(1) constraint order_ck7 check(OrderState='P' or OrderState='C'));

--8.
alter table Customers_1 add constraint Customerid_pk primary key(Customerid);
alter table orders12345 add constraint Customerid_fk foreign key(Customerld) references Customers_1(Customerid);
exec sp_help Customers_1;
exec sp_help orders12345;

--9
USE Training;

CREATE SEQUENCE myseq7 AS INT
START WITH 10000
INCREMENT BY 1;

INSERT INTO Employees (Employee_Code, Employee_Name)
VALUES (NEXT VALUE FOR myseq7, 'Shashanknew');
INSERT INTO Contractors (ContractorId, Name)
VALUES (NEXT VALUE FOR myseq7, 'Aditya');
SELECT * FROM Employees;
SELECT * FROM Contractors;
