--Add column state varchar(20)
select * from DEPOSIT_DETAIL
alter table DEPOSIT
ADD STATE VARCHAR(20);
--Add two more columns city varchar(20) and pincode int.
alter table DEPOSIT
ADD CITY VARCHAR(20),PINCODE INT;
--3. Change the size of cname column from varchar(50) to varchar(35).
ALTER TABLE DEPOSIT
ALTER COLUMN CNAME VARCHAR(35)
--4. Change the data type of amount from decimal to int
ALTER TABLE DEPOSIT
ALTER COLUMN AMOUNT INT
--5. Delete column city from the DEPOSIT table.
ALTER TABLE DEPOSIT
DROP COLUMN CITY
--6. Rename column actno to ano.
EXEC sp_rename 'DEPOSIT.ACTNO','ANO'
--7. Rename column bname to branch_name.
EXEC sp_rename 'DEPOSIT.BNAME','BRANCH_NAME'
--8. Rename table DEPOSIT to DEPOSIT_DETAIL.
EXEC sp_rename 'DEPOSIT','DEPOSIT_DETAIL'
--9. Add column ifsc_code varchar(15).
alter table DEPOSIT_DETAIL
ADD IFSC_CODE VARCHAR(15);
--10. Change the size of bname column from varchar(50) to varchar(30).
alter table DEPOSIT_DETAIL
ALTER COLUMN BRANCH_NAME VARCHAR(30)
--Part – B:
--11. Rename column adate to aopendate.
EXEC SP_RENAME 'DEPOSIT_DETAIL.ADATE','AOPENDATA'
--12. Delete column aopendate from DEPOSIT_DETAIL table.
ALTER TABLE DEPOSIT_DETAIL 
DROP COLUMN AOPENDATA
--13. Rename column cname to customer_name.
EXEC SP_RENAME 'DEPOSIT_DETAIL.CNAME','CUSTOMER_NAME'
--14. Add column country varchar(20).
alter table DEPOSIT_DETAIL
ADD COUNTY VARCHAR(20);
--15. Add column account_type varchar(15).
alter table DEPOSIT_DETAIL
ADD ACCOUNT_TYPE VARCHAR(15);
--16. Change data type of pincode from int to bigint.
ALTER TABLE DEPOSIT_DETAIL
ALTER COLUMN PINCODE BIGINT
--17. Delete column account_type.
ALTER TABLE DEPOSIT_DETAIL
DROP COLUMN ACCOUNT_TYPE
--18. Rename column amount to balance.
EXEC SP_RENAME 'DEPOSIT_DETAIL.AMOUNT','BALANCE'
--19. Add column status varchar(10).
alter table DEPOSIT_DETAIL
ADD STATUS VARCHAR(10);
--20. Change table name deposit_detail to bank_deposit.
EXEC SP_RENAME 'deposit_detail' ,'bank_deposit'
--From the table DEPOSIT perform the following queries:
--Part – A:
--1. Delete all the records having amount less than or equal to 3000.
SELECT *FROM bank_deposit
DELETE FROM bank_deposit
WHERE BALANCE<=3000
--2. Delete all the accounts of ‘BEDI’ branch customer.
DELETE FROM bank_deposit
WHERE BRANCH_NAME='BEDI'
--3. Delete all the accounts having account number greater than 102 and less than 109.
DELETE FROM bank_deposit
WHERE ANO<109 AND ANO>102
--4. Delete all the accounts whose branch is ‘BEDI’ or ‘MADHAPAR’.
DELETE FROM bank_deposit
WHERE BRANCH_NAME IN('BEDI','MADHAPAR')
--5. Delete all the accounts details where amount is 8000 and account open after 1-1-2025;
DELETE FROM bank_deposit
WHERE BALANCE=8000 
--6. Delete all the accounts whose account branch is NULL.
DELETE FROM bank_deposit
WHERE BRANCH_NAME IS NULL
--7. Delete all the accounts details where amount is 7000 and name is CHARMI and branch is SHITAL PARK.
DELETE FROM bank_deposit
WHERE BRANCH_NAME='SHITAL PARK' AND BALANCE=7000 AND CUSTOMER_NAME='CHARMI'
--8. Delete all the remaining records using DELETE command.
DELETE FROM bank_deposit

--9. Delete all the records of DEPOSIT table. (Use TRUNCATE)
TRUNCATE TABLE bank_deposit
--10. Remove DEPOSIT table. (Use DROP)
DROP TABLE bank_deposit
--From the table STUDENT perform the following queries:
--Part – B:
--11. Delete all the students whose stdid is greater than 105.
DELETE FROM STUDENT
WHERE STDID>=105
--12. Delete the records whose branch is NULL and sname is not NULL.
SELECT * FROM STUDENT
DELETE FROM STUDENT
WHERE BRANCH IS NULL AND SNAME IS NULL
--13. Delete the records whose SPI is less than 9 and city is RAJKOT.
DELETE FROM STUDENT
WHERE SPI<9 AND CITY='RAJKOT'
--14. Delete the records whose branch name is not empty.
DELETE FROM STUDENT
WHERE BRANCH IS NOT NULL
--15. Delete all the records of STUDENT table. (Use TRUNCATE)
TRUNCATE TABLE STUDENT