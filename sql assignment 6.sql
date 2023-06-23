/* Assginment 12 - Chapter 11*/

/* 1. Create a view showing the formal name of employees
(Example: Mr. John P. Smith) and full address. */

CREATE VIEW v_FormalNames1
AS
SELECT CASE Gender
WHEN 'F' THEN 'Ms. '
ELSE 'Mr. '
END + CASE WHEN MIDDLENAME IS NULL THEN FIRSTNAME + ' ' + LASTNAME
	ELSE FIRSTNAME + ' ' + MIDDLENAME + ' ' + LASTNAME
		END 'FullName',
		ADDRESSLINE1,
		ADDRESSLINE2,
		CITY,
		STATE,
		ZIP1,
		ZIP2
FROM EMPLOYEES E
INNER JOIN ADDRESSES A ON E.EMPLOYEEID = A.EMPLOYEEID

SELECT * FROM v_FormalNames1

/* 2. Alter the view in exercise 1 to include the age of the employee. */

ALTER VIEW v_FormalNames1
AS 
SELECT CASE Gender
WHEN 'F' THEN 'Ms. '
else 'Mr. '
END + CASE
WHEN MIDDLENAME IS NULL THEN FIRSTNAME + ' ' + LASTNAME
	ELSE FIRSTNAME + ' ' + MIDDLENAME + ' ' + LASTNAME
	END 'FullName',
	DATEDIFF(YEAR,BIRTHDATE,GETDATE()) AGE,
	ADDRESSLINE1,
	ADDRESSLINE2,
	CITY,
	STATE,
	ZIP1,
	ZIP2
FROM EMPLOYEES E
INNER JOIN ADDRESSES A ON E.EMPLOYEEID = A.EMPLOYEEID

/* 3. Join the view from exercise 2 to the necessary tables to retrieve the 
department name. */

ALTER VIEW v_FormalNames1
AS
SELECT CASE GENDER
WHEN 'F' THEN 'Ms. '
ELSE 'Mr. '
END + CASE
WHEN MIDDLENAME IS NULL THEN FIRSTNAME + ' ' + LASTNAME
ELSE FIRSTNAME + ' ' + MIDDLENAME + ' ' + LASTNAME
	END 'FullName',
	DATEDIFF(YEAR, BIRTHDATE,GETDATE()) AGE,
	ADDRESSLINE1,
	ADDRESSLINE2,
	CITY,
	STATE,
	ZIP1,
	ZIP2,
	DEPARTMENTNAME
FROM EMPLOYEES E
INNER JOIN ADDRESSES A ON E.EMPLOYEEID = A.EMPLOYEEID
INNER JOIN EMPLOYEESDEPARTMENTS H ON E.EMPLOYEEID = H.EMPLOYEEID
INNER JOIN DEPARTMENTS D ON H.DEPARTMENTID = D.DEPARTMENTID

SELECT * FROM v_FormalNames1

SELECT * FROM EMPLOYEES 

/* 4. Create a stored procedure to retrieve the first name, last name,
and department name for each employee. */

CREATE PROCEDURE sp_EmployeesTitleDepartment
AS
SELECT FIRSTNAME,
		LASTNAME,
		TITLE,
		DEPARTMENTNAME
FROM EMPLOYEES E
INNER JOIN ADDRESSES A ON E.EMPLOYEEID = A.EMPLOYEEID
INNER JOIN EMPLOYEESDEPARTMENTS ED ON E.EMPLOYEEID = ED.EMPLOYEEID
INNER JOIN DEPARTMENTS D ON ED.DEPARTMENTID = D.DEPARTMENTID



/* 5. Alter the stored procedure from exercise 4 to allow a parameter to
retrieve employees by Department ID. */

ALTER PROCEDURE sp_EmployeesTitleDepartment (@DEPARTMENTID INT)
AS
SELECT FIRSTNAME,
	LASTNAME,
	TITLE,
	DEPARTMENTNAME
FROM EMPLOYEES E
INNER JOIN ADDRESSES A ON E.EMPLOYEEID = A.EMPLOYEEID
INNER JOIN EMPLOYEESDEPARTMENTS ED ON E.EMPLOYEEID = ED.EMPLOYEEID
INNER JOIN DEPARTMENTS D ON ED.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DEPARTMENTID = @DEPARTMENTID


/* 6. Create a stored procedure to list employee first names, last names,
titles and genders. Allow paramaters for title and gender. */

CREATE PROCEDURE sp_Employees (@Title varchar(50), @Gender char(1))
AS
SELECT FIRSTNAME,
	LASTNAME,
	TITLE,
	GENDER
FROM EMPLOYEES E
WHERE TITLE = @TITLE
AND GENDER = @GENDER
EXEC sp_Employees 'Tool Designer', 'M'


/* 7. Create a stored procedure listing the full address from the 
address table where Zip1 is equal to the parameter entered. */

CREATE PROCEDURE sp_Addresses (@zip char(5))
AS
SELECT * FROM ADDRESSES
WHERE ZIP1 = @ZIP
EXEC sp_Addresses '55802'


/* 8. Create a stored procedure to show the first name, last name, salary,
and a bonus based on salary percentage entered as a parameter. */

CREATE PROCEDURE sp_ShowBonus (@Percent decimal(3,2))
AS
SELECT FIRSTNAME,
	LASTNAME,
	SALARY, CONVERT(DECIMAL(10,2),
	SALARY * @PERCENT) BONUS
FROM EMPLOYEES
EXEC sp_ShowBonus .05



/* 9. Create a stored procedure to list the count of employees in a 
state entered as a parameter. */

CREATE PROCEDURE sp_StateCourt (@State char(2))
AS
SELECT COUNT(*) 'Number of employees in state'
FROM [Addresses]
WHERE @State = [State]
EXEC sp_StateCourt WA


/* 10. Create a stored procedure that displays employees with salaries
between two integer parameters. Order by salary. */

CREATE PROCEDURE sp_SalaryBetween (@GreaterThan int, @Lessthan int)
AS
SELECT FIRSTNAME,
	LASTNAME,
	TITLE,
	SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN @GreaterThan AND @LessThan
ORDER BY SALARY
EXEC sp_SalaryBetween 20000, 30000

