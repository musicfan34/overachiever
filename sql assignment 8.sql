Assignment 10 - Chapter 9 */

/*1. Write a subquery to determine the employee or employees with the maximum number
of sick leave hours. */
SELECT FIRSTNAME, LASTNAME, TITLE, VACATIONHOURS
FROM EMPLOYEES
WHERE VACATIONHOURS = 
		(SELECT MAX(SickLeaveHours) FROM EMPLOYEES)

/* 2. Write a subquery to list the employees who have an amount of vacation hours
that are sick leave hours are less than the average number of sick leave hours. */
SELECT FIRSTNAME, LASTNAME, TITLE, VACATIONHOURS
FROM EMPLOYEES
WHERE SickLeaveHours <
		(SELECT AVG(SickLeaveHours) FROM EMPLOYEES)

/* 3. Use the IN operator to list employees' names who live in the state of 
Massachusetts. Hint: You need to use the addresses table in your inner query. */
SELECT EMPLOYEEID, FIRSTNAME, LASTNAME, TITLE, SALARY
FROM EMPLOYEES
WHERE EMPLOYEEID IN
		(SELECT EMPLOYEEID
		FROM ADDRESSES
		WHERE STATE = 'MA')

/* 4. Use the inner join to obtain the same results as the exercise in number 3. */
SELECT E.EMPLOYEEID, FIRSTNAME, LASTNAME, TITLE, SALARY
FROM EMPLOYEES E
INNER JOIN ADDRESSES A ON E.EMPLOYEEID = A.EMPLOYEEID
WHERE A.STATE = 'MA'

/* 5. Use the NOT IN operator to list employees' names who DO NOT live in the
state of Washington. */
SELECT EMPLOYEEID, FIRSTNAME, LASTNAME, TITLE, SALARY
FROM EMPLOYEES
WHERE EMPLOYEEID NOT IN
		(SELECT EMPLOYEEID
		FROM ADDRESSES
		WHERE STATE = 'WA')

/* 6. Use the ALL operator to list employees' names and their salaries for those
who have salaries taht are greater than all the salaries of employees that have ManagerID = 41 */
SELECT FIRSTNAME, LASTNAME, TITLE, SALARY
FROM EMPLOYEES
WHERE SALARY > ALL
		(SELECT SALARY
		FROM EMPLOYEES
		WHERE MANAGERID = 41)
ORDER BY SALARY

/* 7. Use the ANY operator to list employees' names and their salaries for those who have
salaries that are less than any of the salaries of employees that have ManagerID = 41. */
SELECT FIRSTNAME, LASTNAME, TITLE, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY
		(SELECT SALARY
		FROM EMPLOYEES
		WHERE MANAGERID = 41)
ORDER BY SALARY

/* 8. Use a correlated subquery to list employees' names titles, and salaries for those
who have the highest salaries for each manager. */
SELECT FIRSTNAME, LASTNAME, TITLE, SALARY
FROM EMPLOYEES E1
WHERE SALARY = 
		(SELECT MAX(SALARY)
		FROM EMPLOYEES E2
		WHERE E2.MANAGERID = E1.MANAGERID)
ORDER BY SALARY

/* 9. Use the EXISTS operator to find employees who live in the state of California. */
SELECT EMPLOYEEID, FIRSTNAME, LASTNAME
FROM EMPLOYEES E
WHERE EXISTS	
		(SELECT *
		FROM ADDRESSES A
		WHERE E.EMPLOYEEID = A.EMPLOYEEID
		AND STATE = 'CA')

/* 10. Use a correlated subquery to select the lowest paid employees under each manager. */
SELECT FIRSTNAME, LASTNAME, TITLE, SALARY, MANAGERID
FROM EMPLOYEES E1
WHERE SALARY =	
		(SELECT MIN(SALARY)
		FROM EMPLOYEES E2
		WHERE E2.MANAGERID = E1.MANAGERID)
ORDER BY MANAGERID