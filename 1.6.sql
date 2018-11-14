--1.6
--1.Create a Unique index on Department Name for Department master Table.
CREATE UNIQUE INDEX dept_ind
ON department (department_name);
select * from department

--2.Try inserting the following values
insert into department values (100 , 'Home Science'),
(200, 'Home Science'),
(300, NULL),
(400, NULL)

/*3. Create a non-clustered index for Book_Trans table on the following columns
Boo_code, Staff_name, student name, date of issue. Try adding some values.
Do you experience any difficulties?*/
select * from book_transaction where book_code=10
create index book_trans_ind on book_transaction (book_code,staff_code,book_issue_date);
insert into book_transaction values (10,32,12,getdate(),getdate(),null,0)
--4. List the indexes created in the previous questions, from the sysindexes table.
select * from sysindexes 
where id  in (select object_id from sys.objects where name ='department')

--5. 5. Create a View with the name StaffDetails_view with the following column name
--Staff Code, Staff Name, Department Name, Desig Name salary
select * from staff
select * from department
select * from employee
create view StaffDetails_view_3002 as (select st.Staff_Code, st.Staff_Name, d.Department_Name,salary from staff_master st inner join department_master d on (st.dept_code=d.dept_code))
 
 --6. Try inserting some records in the view; Are you modification affects multiple base tables

 --7. Working with Filtered Index 
 USE Adventure_Works;
 CREATE NONCLUSTERED INDEX FIBillOfMaterialsWithEndDate
ON Production.BillOfMaterials (ComponentID, StartDate)
WHERE EndDate IS NOT NULL;

--8. View the definition of the view using the following syntax.
exec sp_helptext StaffDetails_view_302


--9. Using the view , List out all the staffs who have joined in the month of June
select * from staff_view3021
create view staff_view3021 as select * from staff where datename(month,dateofjoining)='march'
select * from employee
--10.Create a non-clustered column store index on EmployeeID of Employees table
create nonclustered columnstore index employee_index302 on Employee (Employee_number)

select * from sys.indexes where name = 'book_trans_ind'

