---- Create a stored procedure to generate department-wise salary statistics like total salary, average 
----salary, minimum salary, and maximum salary. (User enter only department name) 
create or alter proc Pr_Depart
@DEPARTMENT VARCHAR(30)
AS
BEGIN
	select DEPARTMENT,Sum(salary),avg(salary),min(salary),max(salary)  from EMPLOYEE
	where  DEPARTMENT=@DEPARTMENT
	group by DEPARTMENT 

end
exec Pr_Depart 'it'
----2. Create a stored procedure that accepts a joining year and displays employees who joined that year.
 select * from EMPLOYEE

 create or alter proc pr_join
 @joining_year datetime

 as
 begin 
 select * from EMPLOYEE
 where JOININGYEAR=@joining_year
 end
 exec pr_join 2024
--Page 23 of 26 
--3. Create a stored procedure for dynamic employee search using parameters (User may enter partial city 
--name). 
create  or alter proc pr_dynamic
@city varchar(30)
as 
begin
	SELECT * FROM EMPLOYEE
	WHERE CITY=@city
end
EXEC pr_dynamic 'SURAT'
--4. Create a stored procedure that accepts a salary amount and displays employees earning more than the 
--entered salary. 
create  or alter proc pr_SALARY
@SALARY INT
as 
begin
	SELECT * FROM EMPLOYEE
	WHERE SALARY>@SALARY
end
EXEC pr_SALARY 10000
--5. Create a stored procedure to display top N highest paid employees from each department (Value of N 
--is entered by user). 
create  or alter proc pr_Nth
@N INT
as 
begin
WITH CTE  AS(
	SELECT *,ROW_NUMBER() OVER(
	PARTITION BY DEPARTMENT
	ORDER BY SALARY DESC) AS RK FROM EMPLOYEE)
	SELECT * FROM CTE
	WHERE RK=@N
end
EXEC pr_Nth 3
--6. Create a stored procedure to increase salary department-wise by a given percentage. (User Enter 
--Department Name and %, e.g. Computer 10). 
CREATE OR ALTER PROC PR_PERCE
@DEPARTMENT VARCHAR(30),@PERCENTAGE DECIMAL(5,2)
AS 
BEGIN 
	UPDATE EMPLOYEE
	SET SALARY=SALARY+SALARY*(@PERCENTAGE/100)
	WHERE DEPARTMENT=@DEPARTMENT
	END

	EXEC PR_PERCE 'IT',100
	SELECT * FROM EMPLOYEE
	--7. Create a stored procedure to display employees having experience greater than or equal to the entered 
--years. 
create  or alter proc pr_EXE
@YEAR INT
as 
begin

	SELECT * FROM EMPLOYEE
	WHERE YEAR(GETDATE())-JOININGYEAR>=@YEAR
end
EXEC pr_EXE 2
--8. Create a stored procedure that accepts a number as input and displays details of the last N employees 
--who joined the organization. 
 create  or alter proc pr_year
@N INT
as 
begin
WITH CTE  AS(
	SELECT *,ROW_NUMBER() OVER(
	
	ORDER BY joiningYear desc) AS RK FROM EMPLOYEE)
	SELECT * FROM CTE
	WHERE RK<=@N
end
EXEC pr_year 3
--From the table AUTHOR, PUBLISHER and BOOK perform the following queries:  
--Part – B:  
--9. Create a stored procedure that accepts an author name and displays all books written by that author. 
CREATE OR ALTER PROC PR_DISP
@AUTHER VARCHAR(40)
 AS
 BEGIN
 SELECT AUTHORNAME,TITLE FROM BOOK B
 JOIN AUTHOR A
 ON A.AUTHORID=B.AUTHORID
 WHERE AUTHORNAME=@AUTHER
 END
 EXEC PR_DISP 'CHETAN BHAGAT'
--10. Create a stored procedure that accepts a publication year and displays books published after that year. 
CREATE OR ALTER PROC  PR_BOOK
@YEAR  INT
as
begin
		select * from book 
		where publicationYear>@year
end

exec pr_book 1978
--11. Create a stored procedure that accepts a country name and displays all authors from that country with 
--their books. 
create or alter proc pr_country
@country varchar(40)
as
begin
	select B.title,A.authorName from Author a join book b
	on a.authorid=b.authorid
	where Country=@country
end

exec pr_country 'india'
--12. Create a stored procedure that accepts a number as input and displays the top N most expensive books 
--with author and publisher details. 
  create  or alter proc pr_ye
@N INT
as 
begin
WITH CTE  AS(
	SELECT *,ROW_NUMBER() OVER(
	
	ORDER BY Price desc) AS RK FROM book b join author a on a.authorid=b.authorid join publisher p on p.PUBLISHERID=b.PUBLISHERID )
	SELECT * FROM CTE
	WHERE RK<=@N
end
--Part – C:  
--13. Create a stored procedure that accepts a publisher name and displays the total number of books 
--published by that publisher. 
--14. Create a stored procedure that accepts a price range (Min Price Max Price) and displays books whose 
--prices fall within that range. 

--15. Create a stored procedure that accepts an author ID and deletes all books written by that author.