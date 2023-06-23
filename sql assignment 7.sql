/* Assignment 11 - Chapter 10 */

/* 1. Retrieve the employees' last name, the first three characters of the employees' last names,
and the length of the employees' last names. */

SELECT LASTNAME, LEFT(LASTNAME,3), LEN(LASTNAME)
FROM EMPLOYEES



/* 2. Concatenate address1, address2 , city, state, zip 1 and zip 2 from the addressess table. 
Use the INSULL() function to replace NULL values with a blank space for addressline2 and zip2. 
Make sure there is a space in between each field*/

SELECT AddressLine1 + ' ' + ISNULL(AddressLine2, '') + ' ' + City + ' ' + State + ' ' +  ISNULL(AddressLine2, '')
FROM ADDRESSES

/* 3.  Retrieve all uppercase characters for the first names of the employees and all lowercase
for the last names of employees using the UPPER and LOWER functions. */

SELECT UPPER(FIRSTNAME) FIRSTNAME, LOWER(LASTNAME) LASTNAME
FROM EMPLOYEES


/* 4. Using the CHAIRINDEX() function, list all the address rows where
address1 contains the characters "er." */

SELECT *
FROM ADDRESSES
WHERE CHARINDEX('ER', AddressLine1) > 0


/* 5. Retrieve AddressLine1 from the from the Addresses table and replace "Dr." and "Dr"
with "Drive". (Hint: Use the CHAIRINDEX function). */

SELECT ADDRESSLINE1,
CASE
WHEN CHARINDEX('Drive', ADDRESSLINE1) > 0 THEN ADDRESSLINE1
WHEN CHARINDEX('Dr.', ADDRESSLINE1) > 0 THEN REPLACE (ADDRESSLINE1, 'Dr.', 'Drive')
WHEN CHARINDEX('Dr', ADDRESSLINE1) > 0 THEN REPLACE (ADDRESSLINE1, 'Dr', 'Drive')
END
FROM ADDRESSES
WHERE CHARINDEX('Dr', ADDRESSLINE1) > 0

/* 6. Retrieve 4 characters from AddressLine1 of the ADDRESSES table, starting with the
sixth character. */

SELECT AddressLine1, SUBSTRING(ADDRESSLINE1,6,4)
FROM ADDRESSES

/* 7. For each employee, retrieve the first name, last name, and salary amount
and show a bonus of 25% with two decimal points. */

SELECT FIRSTNAME, LASTNAME, SALARY, SALARY * .15 'No Conversion',
		CONVERT(DECIMAL(10,2), SALARY * .25) BONUS
FROM EMPLOYEES

/* 8. Retreive the first name, last name, and birth date of all employees. Show
the birth date in MM/DD/YYYY format. */

SELECT FIRSTNAME, LASTNAME,
		CONVERT(VARCHAR,BIRTHDATE,101) BIRTHDATE
FROM EMPLOYEES

/* 9. Retrieve the first name, last name, hire date, and in individual columns,
the month, day, and year of hire date for each employee. */

SELECT FIRSTNAME, LASTNAME, HIREDATE,
	DATEPART(MONTH,HIREDATE) MONTH,
	DATEPART(DAY,HIREDATE) DAY,
	DATEPART(YEAR,HIREDATE) YEAR
FROM EMPLOYEES



/* 10. Use the COVERT() function along with the GETDATE() function to convert the
current date to varchar and use the MM/DD/YYYY format. */

SELECT CONVERT(VARCHAR(10), GETDATE(),101) 'Current Date'
