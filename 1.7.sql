/* 1. Write a procedure that accept Staff_Code and updates the salary and store the old
salary details in Staff_Master_Back (Staff_Master_Back has the same structure
without any constraint) table. The procedure should return the updated salary as the
return value
Exp< 2 then no Update
Exp>= 2 and <= 5 then 20% of salary
Exp> 5 then 25% of salary */

 
select * from staff_master_back
create proc usp_UpdateStaff (
@stdcde int,
@salaryy int
)
as
begin
 if exists ( select staff_code from staff_master_back where staff_code=@stdcde)
   begin
        begin
	     select staff_sal from staff_master_back where experience < 2 
		 print 'No update'
         end  
	    begin
		select @salaryy =  staff_sal from staff_master_back  where experience >= 2 and experience<=5
		select @salaryy = @salaryy*0.2
		end
		 begin
		select @salaryy= staff_sal from staff_master_back where experience >= 2 and experience<=5
		select @salaryy= @salaryy*0.2	
		 end
	end
		return @salaryy
end

exec usp_UpdateStaff 101,100
		  
/*2. Write a procedure to insert details into Book_Transaction table. Procedure should
accept the book code and staff/student code. Date of issue is current date and the
expected return date should be 10 days from the current date. If the expected return
date falls on Saturday or Sunday, then it should be the next working day. Suitable
exceptions should be handled.*/
select * from Book_Transaction 
create proc usp_booktransssss (
@bkcode int,
@stdntcode int
)
as
begin
  if(@stdntcode is null)
  begin
    Raiserror('student code not available',1,1) 
  end
  else
     if exists (select book_code from Book_Transaction where book_code<>@bkcode)
	   begin
	      Raiserror('book code not available',1,1) 
	   end
	   else
	   
	   begin try
	   begin
	        insert into Book_Transaction
			(book_issue_date,book_expected_return_date) values (getdate(),(datename(d,getdate()))+10)
	   end
	     begin
	     update Book_Transaction set  book_expected_return_date = (datename(dd,getdate())+12) where datename(dw,book_expected_return_date) = 'saturday'
		 
	     
	     update Book_Transaction set  book_expected_return_date = (datename(dd,getdate())+11) where datename(dw,book_expected_return_date) = 'sunday'
		 end
	  end try
	  begin catch
	  throw
	  end catch
 end 
exec usp_booktransssss 104 ,131

--3. Modify question 1 and display the results by specifying With result sets
create proc usp_UpdateStaff (
@stdcde int,
@salaryy int
)
as
begin
 if exists ( select staff_code from staff_master_back where staff_code=@stdcde)
   begin
        begin
	     select staff_sal from staff_master_back where experience < 2 
		 print 'No update'
         end  
	    begin
		select @salaryy =  staff_sal from staff_master_back  where experience >= 2 and experience<=5
		select @salaryy = @salaryy*0.2
		end
		 begin
		select @salaryy= staff_sal from staff_master_back where experience >= 2 and experience<=5
		select @salaryy= @salaryy*0.2	
		 end
	end
		return @salaryy
end
exec usp_UpdateStaff staff_master_back with result sets (staff_coe int,staff_name varchar(30),design_code int,staff_sal money,hire_date date,mgr_code int,mgr_name varchar(30),staff_dob date)



/*4. Create a procedure that accepts the book code as parameter from the user. Display
the details of the students/staff that have borrowed that book and has not returned
the same. The following details should be displayed
Student/StaffCode Student/StaffName IssueDate Designation ExpectedRet_Date*/
select * from book_transaction
select * from staff_master
create proc usp_book_detailss (
@bukcdee int
) 
as begin
select * from staff_master sm full join book_transaction bt on(sm.staff_code=bt.staff_code)
where bt.book_actual_return_date is null and bt.book_code=@bukcdee;
end
exec usp_book_detailss 101


/*5. Write a procedure to update the marks details in the Student_marks table. The
following is the logic.
• The procedure should accept student code , and marks as input parameter
• Year should be the current year.
• Student code cannot be null, but marks can be null.
• Student code should exist in the student master.
• The entering record should be unique ,i.e. no previous record should exist
• Suitable exceptions should be raised and procedure should return -1.
• IF the data is correct, it should be added in the Student marks table and a
success value of 0 should be returned.*/
select * from Student_marks
alter table Student_marks drop column Marks
create proc usp_newUpdateeez (
@stcde int , @mrks int
)
as 
begin
if(@stcde is null or @stcde <0)
  begin
    Raiserror('student code not available',1,1) 
	return -1
  end
  else
  begin
  if exists (select student_code from student_marks where student_code=@stcde )
  begin try
  begin
  alter table student_marks add constraint marks_unique unique(toatl_marks)
  end
  begin
  update student_marks set toatl_marks=@mrks where Student_Year=datename(YYYY,getdate()) 
  return 0
  end
  end try
  begin catch
  return -1
  end catch
  end
end
exec usp_newUpdateeez 1001,5000
	   		