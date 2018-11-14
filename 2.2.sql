/*Data Retrieval - Joins, Subqueries, SET Operators and DML
1. Write a query that displays Staff Name, Salary, and Grade of all staff. Grade depends
on the following table.
Salary Grade
Salary >=50000 A
Salary >= 25000 < 50000 B
Salary>=10000 < 25000 C */
select staff_name,staff_sal,
case
when staff_sal >=50000 THEN 'A'
when staff_sal >=25000 and staff_sal <50000 THEN 'B'
when staff_sal >=10000 and staff_sal <25000 THEN 'C'
ELSE 'D'
end
as grade
from staff_master

/*2. Generate a report which contains the following information.
Staff Code, Staff Name, Designation, Department, Book Code, Book Name,
Author, Fine
For the staff who have not return the book. Fine will be calculated as Rs. 5 per
day.
Fine = 5 * (No. of days = Current Date – Expected return date), for others it
should be displayed as –*/
select staff_master.staff_code,staff_master.staff_name,desig_master.desig_name,staff_master.dept_code,book_master.book_code,book_master.book_name,
book_pub_year,datediff(day,book_transaction.book_expected_return_date,getdate())*5 as fine from (book_transaction full outer join staff_master on(book_transaction.staff_code=staff_master.staff_code))
full outer join
book_master on(book_transaction.book_code=book_master.book_code)
full outer join
desig_master on(staff_master.desig_code=desig_master.desig_code);


/*3. List out all the staffs who are reporting to the same manager to whom staff 100060
reports to.*/
select * from staff_master where mgr_code = (select mgr_code from staff_master where staff_code=10000)

/*4. List out all the students along with the department who reads the same books which
the professors read
*/
select bt.student_code,sm.student_name,sm.dept_code from book_transaction bt inner join student_master sm on (bt.student_code=sm.student_code) where bt.student_code is not null and bt.staff_code is not null

/*5. List out all the authors who have written books on same category as written by
Author David Gladstone.
*/
select book_pub_author from book_master
where book_category=(select book_category from book_master where book_pub_author='Author David Gladstone')

/*
6. Display the Student report Card for this year. The report Card should contain the
following information.
Student Code Student Name Department Name Total Marks Grade
Grade is calculated as follows. If a student has scored < 60 or has not attempted
an exam he is considered to an F
>80 - E
70-80 - A
60- 69 - B
*/
select sms.student_code,dm.dept_name,(sm.subject1+sm.subject2+sm.subject3) as total,
case when
((sm.subject1+sm.subject2+sm.subject3)/3)<60 then 'F' 
when
((sm.subject1+sm.subject2+sm.subject3)/3)>80 then 'E'
when
((sm.subject1+sm.subject2+sm.subject3)/3) between 70 and 80 then 'A'
when
((sm.subject1+sm.subject2+sm.subject3)/3) between 60 and 69 then 'B'
End
as grade
from department_master dm inner join (student_master sms inner join student_marks sm on (sm.student_code=sm.student_code)) on (sms.dept_code=dm.dept_code)
