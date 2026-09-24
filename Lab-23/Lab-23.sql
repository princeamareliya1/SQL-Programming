--1. INSERT Procedures: Create stored procedures to insert records into STUDENT tables 
--(SP_INSERT_STUDENT) 
create or alter proc PR_INSERT_STUDENT
@roll int,@name varchar(10),@city varchar(10),@spi decimal(4,2),@Bname varchar(30)
as 
begin
	insert into student values(@roll,@name,@city,@spi,@BNAME)
end
EXEC PR_INSERT_STUDENT 115,'PUSHTI','RAJKOT',9.48,'COMPUTER' 
EXEC PR_INSERT_STUDENT 116,'NIKUNJ','SURAT',8.80,'CHEMICAL' 

--STDID SNAME CITY SPI BRANCH 
--115 PUSHTI RAJKOT 9.48 COMPUTER 
--116 NIKUNJ SURAT 8.80 CHEMICAL 
--2. INSERT Procedures: Create stored procedures to insert records into DEPOSIT tables  
--(SP_INSERT_DEPOSIT) 
--ACTNO CNAME BNAME AMOUNT ADATE 
--118 HEMENT BEDI 16000 05-05-2025 
--119 RAVI MAVDI 24000 09-07-2024 
create or alter proc PR_INSERT_DEPOSIT
@ACTNO int,@name varchar(10),@Bname varchar(30),@AMT INT,@DATE DATE
as 
begin
	insert into DEPOSIT values(@ACTNO,@name,@Bname,@AMT,@DATE)
end
EXEC PR_INSERT_DEPOSIT 118,'HEMANT','BEDI',16000,'2025-05-05' 
EXEC PR_INSERT_DEPOSIT 119,'RAVI','MAVDI',24000,'2024-07-09' 
SELECT * FROM DEPOSIT
--3. UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Branch in STUDENT 
--table. (Update using studentID) 
                 create or alter proc PR_UPDATE_STUDENT
@roll int ,@BNAME VARCHAR(30)
AS
begin
	UPDATE STUDENT
	SET BRANCH=@BNAME
	WHERE STDID=@ROLL
end                    
EXEC  PR_UPDATE_STUDENT 115,'ELECTRICAL'
EXEC  PR_UPDATE_STUDENT 116,'MECHANICAL'

--STDID BRANCH 
--115 ELECTRICAL 
--116 MECHANICAL 
 
--4. DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT 
--where Student Name is RAVI. 
                 create or alter proc PR_DELETE_STUDENT
@NAME VARCHAR(30)
AS
begin
	DELETE FROM STUDENT
	WHERE SNAME=@NAME
end                    
EXEC PR_DELETE_STUDENT 'RAVI'
--5. SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key 
--(SP_SELECT_STUDENT_BY_ID) from Student table. (Display All Columns) 
                 create or alter proc PR_SELECT_STUDENT_BY_ID
				 @ID INT
AS
begin
SELECT * FROM STUDENT
WHERE STDID=@ID
end
EXEC PR_SELECT_STUDENT_BY_ID 103
--6. Create a stored procedure that shows details of the first 5 students ordered by SPI (Highest First). 
                  create or alter proc PR_HIGH
AS
begin
WITH CTE AS(
SELECT SNAME,BRANCH,SPI,ROW_NUMBER()OVER(ORDER BY SPI DESC) AS AE  FROM STUDENT)
SELECT * FROM CTE
WHERE AE<=5
end
EXEC PR_HIGH
--From the table EMPLOYEE perform the following queries:  
--Part – B:   
--7. Create a stored procedure which displays all employee details. 
                 create or alter proc PR_SELECT_EMPLOYEE
AS
begin
SELECT * FROM EMPLOYEE
end
EXEC PR_SELECT_EMPLOYEE
--8. Create a stored procedure that takes department name as input and returns all the employee in that 
--department. 
CREATE OR ALTER PROC PR_DEPARTMENT
@DEPARTMENT VARCHAR(30)

AS 
BEGIN 
		SELECT * FROM EMPLOYEE
		WHERE DEPARTMENT=@DEPARTMENT
END
EXEC PR_DEPARTMENT 'IT'
--Part – C:  
--9. Create a stored procedure which displays department-wise maximum, minimum, and average salary of 
--employee. 
CREATE OR ALTER PROC PR_DISP
AS 
BEGIN
SELECT DEPARTMENT,MAX(SALARY) AS HIGHEST_SALARY,MIN(SALARY) AS LOWEST_SALARY,AVG(SALARY) AS AVERAGE_SALARY FROM EMPLOYEE
GROUP BY DEPARTMENT
END
EXEC PR_DISP
--10. Create a stored procedure that accepts department name as parameter and returns total salary of their 
--department.
CREATE OR ALTER PROC PR_DIS

AS 
BEGIN
SELECT DEPARTMENT,SUM(SALARY) AS TOTAL_SALARY FROM EMPLOYEE
GROUP BY DEPARTMENT
END
EXEC PR_DIS 