use Training;

--1.
select Student_Code, Student_Name, Department_Code from university.student;

--2.
select Staff_Code, Staff_Name, Department_Code from university.staff;

--3.
select Employee_Name, Salary, Department_Code from university.employees where department_code in(20,30,40);

--4.
select Student_Code, Subject1, Subject2, Subject3, Subject1+Subject2+Subject3 as Total_Marks from student_marks
order by Total_Marks desc;

--5.
select * from books where Bookname like 'An%';

--6.
select * from student

--7.
declare @d datetime='10/01/2011';
select student_name , student_dob as format (@d, 'D', 'en-US') from student
where (datename(dw,student_dob)='Saturday' or datename(dw,student_dob)='Sunday');

--8
select staff_code StaffCode, staff_name StaffName, department_code as 'Dept Code', DateofJoining as 'Date Of Joining',
NoOfYearinCompany as 'No of years in Company' from staff;

--9
select * from staff where DateofJoining < '2000-01-01';

--10
select student_name, department_code, student_dob from student
where student_dob between '1981-01-01' and '1983-03-31';

--11.
select * from student_marks where subject2 is NULL;

--merge statement case study
CREATE TABLE Products7
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Rate MONEY
)
--Insert records into target table
INSERT INTO Products7
VALUES
(1,'Tea', 10.00),
(2, 'Coffee', 20.00),
(3, 'Muffin', 30.00),
(4, 'Biscuit', 40.00)

CREATE TABLE UpdatedProducts7
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Rate MONEY
)
--Insert records into source table
INSERT INTO UpdatedProducts7
VALUES
(1, 'Tea', 10.00),
(2, 'Coffee', 25.00),
(3, 'Muffin', 35.00),
(5, 'Pizza', 60.00)


MERGE Products7 AS TARGET
USING UpdatedProducts7 AS SOURCE
ON (TARGET.ProductID = SOURCE.ProductID)
WHEN MATCHED AND TARGET.ProductName <> SOURCE.ProductName
OR TARGET.Rate <> SOURCE.Rate THEN
UPDATE SET TARGET.ProductName = SOURCE.ProductName,
TARGET.Rate = SOURCE.Rate
WHEN NOT MATCHED BY TARGET THEN
INSERT (ProductID, ProductName, Rate)
VALUES (SOURCE.ProductID, SOURCE.ProductName, SOURCE.Rate)
WHEN NOT MATCHED BY SOURCE THEN DELETE
OUTPUT $action,
DELETED.ProductID AS TargetProductID,
DELETED.ProductName AS TargetProductName,
DELETED.Rate AS TargetRate,
INSERTED.ProductID AS SourceProductID,
INSERTED.ProductName AS SourceProductName,
INSERTED.Rate AS SourceRate;
SELECT @@ROWCOUNT;
GO