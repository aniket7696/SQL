-- 1. List the empno, name and Department No of the employees who have got
-- experience of more than 18 years.
select *  from staff_master
select s.staff_name,s.staff_code,d.dept_code from staff_master s inner join department_master d on(s.dept_code=d.dept_code) where s.experience>18

/*2. Display the name and salary of the staff. Salary should be represented as X. Each X
represents a 1000 in salary. It is assumed that a staff’s salary to be multiples of 1000
, for example a salary of 5000 is represented as XXXXX*/
select staff_name,replicate('X',(staff_sal/1000)) as salary from staff_master

--3. List out all the book code and library member codes whose return is still pending
select * from book_transaction
select * from library
select book_code ,staff_code,student_code from book_transaction where book_actual_return_date is null

--4. List all the staff’s whose birthday falls on the current months
select * from staff_master where datename(month,staff_dob)=datename(month,getdate())

--5. How many books are stocked in the library?
select count(*) from book_master

--6. How many books are there for topics Physics and Chemistry?
select count(*) from book_master where book_name like 'Physics' or  book_name like 'Chemistry'

--7. How many members are expected to return their books today?
select count(*) from book_transaction where book_expected_return_date=getdate()

/*8. Display the Highest, Lowest, Total & Average salary of all staff. Label the columns
Maximum, Minimum, Total and Average respectively. Round the result to nearest
whole number*/
select max(staff_sal) as maximum,min(staff_sal) as minimum,sum(staff_sal) as total,avg(staff_sal) as average from staff_master
select ceiling(max(staff_sal)),ceiling(min(staff_sal)),ceiling(sum(staff_sal)),ceiling(avg(staff_sal))  from staff_master

--9. How many staffs are managers”?
select count(*) from staff_master where mgr_code is not null

/*10. List out year wise total students passed. The report should be as given below. A
student is considered to be passed only when he scores 60 and above in all 3
subjects individually
Year No of students passed*/
select student_year as passing_year,count(*) as no_of_passing_year from student_marks where (subject1>60 and subject2>60 and subject13>60 ) group by student_year

--11.List out all the departments which is having a headcount of more than 10
select count(*) as num_students from student_master s inner join department_master d on(s.dept_code=d.dept_code) group by d.dept_name having count(s.student_code) >10

--12. List the total cost of library inventory ( sum of prices of all books )
select sum(bookprice) as total_cost from Book_Master
--13. List out category wise count of books costing more than Rs 1000 /-
select count(*) as book from book_master group by bookprice having bookprice >1000

--14. How many students have joined in Physics dept (dept code is 10) last year?
select count (*) from (student_master s inner join student_marks sm on sm.student_coe=s.student_code)
inner join department_master d on s.dept_code=d.dept_code
where sm.student_year = 2012 and d.dept_name = 'Physics'

