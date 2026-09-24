CREATE TABLE CUSTOMER1
(
    ORDERID INT PRIMARY KEY,
    CNAME VARCHAR(50),
    PRODUCT VARCHAR(50),
    CATEGORY VARCHAR(50),
    AMOUNT INT,
    ORDERYEAR INT,
    CITY VARCHAR(50)
);

INSERT INTO CUSTOMER1 (ORDERID, CNAME, PRODUCT, CATEGORY, AMOUNT, ORDERYEAR, CITY)
VALUES
(101, 'RAHUL', 'LAPTOP', 'ELECTRONICS', 65000, 2024, 'RAJKOT'),
(102, 'PRIYA', 'MOBILE', 'ELECTRONICS', 25000, 2023, 'SURAT'),
(103, 'AMIT', 'TABLE', 'FURNITURE', 12000, 2022, 'AHMEDABAD'),
(104, 'NEHA', 'CHAIR', 'FURNITURE', 8000, 2024, 'BARODA'),
(105, 'VISHAL', 'TV', 'ELECTRONICS', 45000, 2025, 'MORBI'),
(106, 'RIYA', 'SOFA', 'FURNITURE', 30000, 2023, 'SURAT'),
(107, 'MEHUL', 'AC', 'ELECTRONICS', 40000, 2022, 'RAJKOT'),
(108, 'KUNAL', 'BED', 'FURNITURE', 35000, 2025, 'JAMNAGAR');






--1. Display top 3 highest amount orders.
with Amunt as(select CNAME,AMOUNT,ROW_NUMBER()over (order by Amount desc) as rk from CUSTOMER1 )
select * from Amunt
where rk<=3
--2. Display second highest order amount.
with Amunt as(select CNAME,AMOUNT,ROW_NUMBER()over (order by Amount desc) as rk from CUSTOMER1 )
select * from Amunt
where rk=2
--3. Display customers whose order amount is greater than category average amount.
with AvgAm as(select *,avg(amount) over() as s from CUSTOMER1)
select * from AvgAm
where AMOUNT>s
--4. Display categories having average amount greater than 30000.
with AvgAm as(select *,avg(amount) over() as s from CUSTOMER1)
select * from AvgAm
where 30000<s
--5. Display highest amount order from each category.
with Amunt as(select CNAME,AMOUNT,ROW_NUMBER()over ( partition by CATEGORY order by Amount desc) as rk from CUSTOMER1 )
select * from Amunt
where rk=1
--6. Display lowest amount order from each category.
with Amunt as(select CNAME,AMOUNT,ROW_NUMBER()over ( partition by CATEGORY order by Amount) as rk from CUSTOMER1 )
select * from Amunt
where rk=1
--7. Display categories having more than 3 orders.
with amo as(select *,count(*) over(partition by CATEGORY ) as a from CUSTOMER1)
select  distinct category,a from amo
where a>=3
--8. Display city-wise total order amount
with city as(select *,sum(AMOUNT) over(partition by city) as a from CUSTOMER1)
select  distinct city,a from city

--9. Display category having highest average order amount.
with amo as(select *,avg(AMOUNT) over(partition by CATEGORY ) as a from CUSTOMER1)
select  * from amo
where a=(select max(a) from amo)
--10. Display cumulative order amount in ascending order of amount.
with dtd as (
select *,sum(AMOUNT) over (order by amount rows between unbounded preceding and current row) as w from CUSTOMER1)
select * from dtd
order by AMOUNT
--Part – B:

--11. Display category-wise top 2 highest amount orders.
with Amunt as(select CNAME,AMOUNT,ROW_NUMBER()over (partition by category order by Amount desc) as rk from CUSTOMER1 )
select * from Amunt
where rk<=2
--12. Display customers whose amount is closest to category average amount.
with clos as(select avg(
amount) over (partition by category) as e,rank()over(partition by category order by (amount-avg(
amount))) as a from CUSTOMER1 group by CATEGORY)
select * from clos


--13. Display previous, current and next order amount together.
with Amunt as(select CNAME,AMOUNT,Lag(Amount)over (order by Amount desc) as e ,lead(Amount)over (order by Amount desc) as rk from CUSTOMER1 )
select * from Amunt


--14. Display customers whose amount is greater than previous customer's amount.
with Amunt as(select CNAME,AMOUNT,Lag(Amount)over (order by Amount ) as e ,lead(Amount)over (order by Amount desc) as rk from CUSTOMER1 )
select * from Amunt
where amount>e 
--15. Display customers whose rank and dense rank are different.
with Amunt as(select CNAME,AMOUNT,Rank()over (order by Amount desc) as e ,Dense_rank()over (order by Amount desc) as rk from CUSTOMER1 )
select * from Amunt
where e<>rk
--Part – C:
--16. Display orders whose amount is neither highest nor lowest in their category.
with Amunt 
as(select CNAME,AMOUNT,ROW_NUMBER()over (partition by category  order by Amount desc)
as rk,ROW_NUMBER()over 
(partition by category order by Amount ) as r from CUSTOMER1 )
select * from Amunt
where rk<>1 and r<>1
--17. Display category-wise difference between highest and lowest amount.
with Amunt as(select CNAME,AMOUNT,Abs(ROW_NUMBER()over (partition by category  order by Amount desc) -ROW_NUMBER()over (partition by category order by Amount )) as r from CUSTOMER1 )
select * from Amunt
--18. Display customers whose amount is greater than all FURNITURE category orders.
--19. Display categories where all orders are above 10000.
--20. Display customers whose amount difference from category topper is minimum
