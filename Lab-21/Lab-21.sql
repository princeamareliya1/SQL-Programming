--1. Display all students whose SPI is greater than 8.
with s as(select * from student where spi>8)
select * from s
--2. Display average SPI of all students.
with sa as(select avg(spi) as a from student )
select a from sa
--3. Display total number of students in each branch.
with [Total] as (select Branch,count(stdid) as count_student from student  group by branch)
select Branch,count_student from[total] 
--4. Display students who belong to RAJKOT city.
with city_r as (select sname,city  from student  where city='Rajkot')
select sname,City from city_r 
--5. Find branch names that appear more than once.
with More_Branch as (select Branch,count(*) as count from student  group by Branch Having COUNT(*)>1)
select Branch,count from More_Branch 
--6. Display row number for each student.
with Row_no as(
select sname,
ROW_NUMBER() over (order By spi) as rn
from student)
select * from Row_no
--7. Display top 3 students based on SPI.
with top3 as
(
select sname,Row_number() over(order By spi desc) as rn from student)
select * from top3 
where rn<=3
--8. Display students having maximum SPI.
with top3 as
(
select sname,Row_number() over(order By spi desc) as rn from student)
select * from top3 
where rn=1
--9. Display students having minimum SPI.
with top3 as
(
select sname,Row_number() over(order By spi ) as rn from student)
select * from top3 
where rn=1
--10. Display branch -wise rank of students.
with branch as
(
select sname,spi,Branch,Row_number() over(partition by Branch order By spi desc) as rn from student)
select * from branch 

--Part – B:
--11. Display students SPI average belonging to Computer branch.
with avg_branch as
(
select avg(spi) as a from student where branch='computer')
select * from avg_branch 
--12. Display students whose SPI is greater than average SPI of his/her branch.
with branch as
(
select *,AVG(SPI) OVER (PARTITION BY BRANCH) AS AV from student
)
SELECT * FROM BRANCH
where spi>AV
--13. Display branch  having more than 2 students.
with count_stud as (select Branch,count(*) as a from student group by Branch having count(*)>2)
select * from count_stud
--14. Display branches having average SPI between 7 and 9
with BETWEE as (select Branch,AVG(SPI) as a from student group by Branch having AVG(SPI) BETWEEN 7 AND 9 )
select * from BETWEE
--15. Display students whose SPI is lower than overall average SPI.
with branch as
(
select *,AVG(SPI) OVER (PARTITION BY BRANCH) AS AV from student
)
SELECT * FROM BRANCH
where spi<AV
--Part – C:
--16. Display branches having exactly one student.
with count_stud as (select Branch,count(*) as a from student group by Branch having count(*)=1)
select * from count_stud
--17. Display branch having highest average SPI.
WITH  HIGH_AVG AS(
SELECT *,
AVG(SPI) OVER (PARTITION BY BRANCH)As A
FROM STUDENT 
)
SELECT * FROM HIGH_AVG
WHERE A=(SELECT mAX(A) FROM HIGH_AVG)


--18. Display branch having lowest average SPI.
WITH  HIGH_AVG AS(
SELECT *,
AVG(SPI) OVER (PARTITION BY BRANCH)As A
FROM STUDENT 
)
SELECT * FROM HIGH_AVG
WHERE A=(SELECT MIN(A) FROM HIGH_AVG)
--19. Display students whose SPI is lower than branch average SPI.
WITH  HIGH_AVG AS(
SELECT *,
AVG(SPI) OVER (PARTITION BY BRANCH)As A
FROM STUDENT 
)
SELECT * FROM HIGH_AVG
WHERE SPI<A
--20. Display branches having maximum number of students.
with count_stud as (select Branch,count(*) as a from student group by Branch )
select * from count_stud
WHERE A=(SELECT MAX(A)FROM count_stud)
