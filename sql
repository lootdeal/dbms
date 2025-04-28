 --CREATE DATABASE databasename;

--BACKUP DATABASE databasename
TO DISK = 'filepath';

--DROP TABLE table_name;

--ALTER TABLE table_name
ADD column_name datatype;

--CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

--INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

--UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;




//Trigger

mysql> create table t1(phone varchar(10),id int AUTO_INCREMENT primary key);
mysql> create table del(phone varchar(10),delete_at TIMESTAMP default current_timestamp);
mysql> delimiter //
mysql> create trigger t2
    -> before delete on t1 for each row
    -> begin
    -> insert into del(phone,delete_at) values(old.phone,now());
    -> end; //
mysql> insert into t1 values('1234567890',1); //
mysql> insert into t1 values('12345670',2); //
mysql> select * from t1;//
mysql> delete from t1 where id=1; //
mysql> select * from del;//


mysql> create view v1 as
    -> select u.phone,u.id,v.delete_at
    -> from t1 u,del v;//
mysql> select * from v1;//

mysql> CREATE PROCEDURE add_numbers(IN a INT, IN b INT, OUT c INT)
    -> BEGIN
    ->     SET c = a + b;
    -> END//
mysql> CALL add_numbers(10, 15, @S);//
mysql> select @s as sum;//


mysql> update t1
    -> set phone='surr'
    -> where id=2;//



//Procedure
mysql> CREATE PROCEDURE ADDNO( IN A INT,IN B INT,OUT C INT)
    -> BEGIN
    -> SET C=A+B;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql> CALL ADDNO(10,15,@S);
    -> SELECT @S AS SUM;
    -> //
Query OK, 0 rows affected (0.00 sec)

+------+
| SUM  |
+------+
|   25 |
+------+

mysql> CALL ADDNO (25,57,@C); SELECT @C AS SUM;//
Query OK, 0 rows affected (0.00 sec)

+------+
| SUM  |
+------+
|   82 |
+------+
1 row in set (0.00 sec)





//3 Entity reln
CREATE TABLE BOOK (
    BOOKID INT PRIMARY KEY,
    TITLE VARCHAR(255) NOT NULL,
    AUTHOR VARCHAR(255) NOT NULL,
    PUBLISHER VARCHAR(255),
    YEARPUBLISHED INT
);

CREATE TABLE MEMBER (
    MEMBERID INT PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    ADDRESS VARCHAR(255),
    PHONENUMBER VARCHAR(15),
    EMAIL VARCHAR(255)
);

CREATE TABLE LOAN (
    LOANID INT PRIMARY KEY,
    BOOKID INT,
    MEMBERID INT,
    LOANDATE DATE,
    RETURNDATE DATE,
    FOREIGN KEY (BOOKID) REFERENCES BOOK(BOOKID),
    FOREIGN KEY (MEMBERID) REFERENCES MEMBER(MEMBERID)
);

INSERT INTO BOOK (BOOKID, TITLE, AUTHOR, PUBLISHER, YEARPUBLISHED) VALUES
(1, 'WINGS OF FIRE', 'APJ ABDUL KALAM', 'UNIVERSITIES PRESS', 1999),
(2, 'THE ALCHEMIST', 'PAULO COELHO', 'HARPERONE', 1988),
(3, 'IKIGAI', 'FRANCES MIRALLES', 'PENGUIN', 2016);

INSERT INTO MEMBER (MEMBERID, NAME, ADDRESS, PHONENUMBER, EMAIL) VALUES
(1, 'SURAJ', 'DELHI', '9123456780', 'SURAJ@EMAIL.COM'),
(2, 'SOHAM', 'PUNE', '9871234560', 'SOHAM@EMAIL.COM'),
(3, 'AKSHAY', 'BANGALORE', '9786543210', 'AKSHAY@EMAIL.COM');

INSERT INTO LOAN (LOANID, BOOKID, MEMBERID, LOANDATE, RETURNDATE) VALUES
(1, 1, 2, '2025-04-25', '2025-05-25'),
(2, 2, 1, '2025-05-10', '2025-06-10'),
(3, 3, 3, '2025-06-15', '2025-07-15');


SELECT * FROM BOOK;
SELECT * FROM MEMBER;
SELECT * FROM LOAN;







//DDL CREATE ALTER DROP RENAME MODIFY

CREATE TABLE Department(
    DeptID INT PRIMARY KEY,
    Deptname VARCHAR(100)
);

//Create Employee table with foreign key reference
CREATE TABLE Employee(
    EmpID INT PRIMARY KEY,
    Empname VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

//Add a new column 'Email' to Employee table
ALTER TABLE Employee ADD Email VARCHAR(100);

//Insert records into Department
INSERT INTO Department VALUES(1, 'IT');
INSERT INTO Department VALUES(2, 'CS');
INSERT INTO Department VALUES(3, 'CE');
INSERT INTO Department VALUES(4, 'ME');

//Display Department table
SELECT * FROM Department;

//Insert records into Employee
INSERT INTO Employee VALUES(1101, 'SURAJ', 1, 'abc@gmail.com');
INSERT INTO Employee VALUES(1102, 'SOHAM', 2, 'soham@gmail.com');
INSERT INTO Employee VALUES(1103, 'AKSHAY', 3, 'akshay@gmail.com');
INSERT INTO Employee VALUES(4444, 'AKASH', 4, 'akash@gmail.com');

//Display Employee table
SELECT * FROM Employee;

//Modify Empname column size
ALTER TABLE Employee MODIFY Empname VARCHAR(150);

//View updated structure of Employee
DESC Employee;

//NEW: Rename the Employee table to Staff
RENAME TABLE Employee TO Staff;

//NEW: Rename 'Empname' column to 'EmployeeName' in Staff table
ALTER TABLE Staff CHANGE Empname EmployeeName VARCHAR(150);

//Display the updated Staff table
SELECT * FROM Staff;

TRUNCATE TABLE Department;

//Drop tables (optional)
DROP TABLE Staff;
DROP TABLE Department;



//Views

--- SQLite Queries ---

CREATE TABLE STUDENT1(
    ID INT,
    NAME VARCHAR(50),
    AGE INT,
    MARKS INT
);

-- Show tables
.show tables
-- Output:
-- STUDENT1

-- Insert records into STUDENT1
INSERT INTO STUDENT1 VALUES
    (1, 'om', 20, 18),
    (2, 'karthik', 34, 23),
    (3, 'ABC', 23, 21),
    (4, 'XYZ', 18, 28);

-- View all records
SELECT * FROM STUDENT1;

-- Output:
-- 1 | om      | 20 | 18
-- 2 | karthik | 34 | 23
-- 3 | ABC     | 23 | 21
-- 4 | XYZ     | 18 | 28

-- Alter table to add new column GRADE
ALTER TABLE STUDENT1 ADD GRADE VARCHAR(50);

-- View updated table structure
SELECT * FROM STUDENT1;

-- Update marks for ID=3
UPDATE STUDENT1 SET MARKS = 30 WHERE ID = 3;

-- View after update
SELECT * FROM STUDENT1;

-- Output:
-- 1 | om      | 20 | 18
-- 2 | karthik | 34 | 23
-- 3 | ABC     | 23 | 30
-- 4 | XYZ     | 18 | 28

-- Drop the table STUDENT1
DROP TABLE STUDENT1;

-- Try selecting from dropped table (Error will occur)
SELECT * FROM STUDENT1;
-- Error: no such table: STUDENT1


--- MySQL Queries ---

-- Create a new database
CREATE DATABASE Emp;

-- Use the created database
USE Emp;

-- Create table DEPARTMENT
CREATE TABLE DEPARTMENT (
    DEPTID INT PRIMARY KEY,
    DEPTNAME VARCHAR(50)
);

-- Create table EMPLOYEES
CREATE TABLE EMPLOYEES (
    EMPID INT PRIMARY KEY,
    NAME VARCHAR(50),
    DEPTID INT,
    SALARY DECIMAL(10,2)
);

-- Insert values into DEPARTMENT
INSERT INTO DEPARTMENT VALUES (101, 'HR');
INSERT INTO DEPARTMENT VALUES (102, 'IT');
INSERT INTO DEPARTMENT VALUES (103, 'FINANCE');

-- Insert values into EMPLOYEES
INSERT INTO EMPLOYEES VALUES (1, 'ALICE', 101, 50000.00);
INSERT INTO EMPLOYEES VALUES (2, 'BOB', 102, 60000.00);
INSERT INTO EMPLOYEES VALUES (3, 'CHARLIE', 103, 55000.00);

-- Display EMPLOYEE details
SELECT * FROM EMPLOYEES;

-- Display DEPARTMENT details
SELECT * FROM DEPARTMENT;

-- Create a view EMPDETAIL
CREATE VIEW EMPDETAIL AS
SELECT EMPLOYEES.NAME, SALARY, DEPTNAME
FROM EMPLOYEES
JOIN DEPARTMENT ON DEPARTMENT.DEPTID = EMPLOYEES.DEPTID;

-- Display data from EMPDETAIL
SELECT * FROM EMPDETAIL;







-- oprators
-- ===========================================================
-- 1. Create Database and Use it
-- ===========================================================

-- Create a database named 'sq'
CREATE DATABASE sq;

-- Use the created database
USE sq;

-- ===========================================================
-- 2. Create Employee Table
-- ===========================================================

-- Create 'Employee' table with relevant columns
CREATE TABLE Employee (
  EmpID INT,
  Name VARCHAR(50),
  Salary INT,
  Department VARCHAR(50)
);

-- ===========================================================
-- 3. Insert Sample Data into Employee Table
-- ===========================================================

-- Insert sample employee data into the Employee table
INSERT INTO Employee VALUES (1, 'SURAJ', 75000, 'IT');
INSERT INTO Employee VALUES (2, 'SOHAM', 45000, 'IT');
INSERT INTO Employee VALUES (3, 'AKSHAY', 165000, 'IT');
INSERT INTO Employee VALUES (4, 'PRIYA', 80000, 'HR');
INSERT INTO Employee VALUES (5, 'RAVI', 55000, 'Finance');
INSERT INTO Employee VALUES (6, 'ANITA', 67000, 'HR');
INSERT INTO Employee VALUES (7, 'MANISH', 98000, 'IT');
INSERT INTO Employee VALUES (8, 'NISHA', 35000, 'Finance');

-- ===========================================================
-- 4. SQL Queries (Grouped by Categories)
-- ===========================================================

-- ===========================================================
-- 4.1. Arithmetic Operators
-- ===========================================================

-- Increase all employees' salaries by 10%
SELECT EmpID, Name, Salary, Salary * 1.10 AS NewSalary 
FROM Employee;

-- Find the difference between highest and lowest salary
SELECT MAX(Salary) - MIN(Salary) AS SalaryDifference 
FROM Employee;


-- ===========================================================
-- 4.2. Comparison Operators
-- ===========================================================

-- Employees with salary equal to 60,000
SELECT * FROM Employee WHERE Salary = 60000;

-- Employees with salary NOT equal to 60,000
SELECT * FROM Employee WHERE Salary <> 60000;

-- Employees with salary greater than 55,000
SELECT * FROM Employee WHERE Salary > 55000;

-- Employees with salary less than or equal to 65,000
SELECT * FROM Employee WHERE Salary <= 65000;


-- ===========================================================
-- 4.3. Logical Operators
-- ===========================================================

-- Employees in the IT department earning more than 60,000
SELECT * FROM Employee WHERE Department = 'IT' AND Salary > 60000;

-- Employees in HR or Finance department
SELECT * FROM Employee WHERE Department = 'HR' OR Department = 'Finance';

-- Employees NOT in the IT department
SELECT * FROM Employee WHERE NOT Department = 'IT';


-- ===========================================================
-- 4.4. Bitwise Operators
-- ===========================================================

-- Bitwise AND on salaries (for demonstration)
SELECT Salary & 50000 
FROM Employee;

-- Bitwise OR on salaries
SELECT Salary | 50000 
FROM Employee;


-- ===========================================================
-- 4.5. Pattern Matching
-- ===========================================================

-- Employees whose name starts with 'A'
SELECT * FROM Employee WHERE Name LIKE 'A%';

-- Employees whose name ends with 'a'
SELECT * FROM Employee WHERE Name LIKE '%a';

-- Employees whose name contains 'o'
SELECT * FROM Employee WHERE Name LIKE '%o%';


-- ===========================================================
-- 4.6. IN and BETWEEN Operators
-- ===========================================================

-- Employees in IT or HR department
SELECT * FROM Employee WHERE Department IN ('IT', 'HR');

-- Employees with salary between 55,000 and 70,000
SELECT * FROM Employee WHERE Salary BETWEEN 55000 AND 70000;


-- ===========================================================
-- 4.7. Built-In Functions
-- ===========================================================

-- 7.1 String Functions
SELECT
  UPPER(Name) AS uppercase_name,          -- Convert name to uppercase
  LOWER(Name) AS lowercase_name,          -- Convert name to lowercase
  LENGTH(Name) AS name_length,            -- Get the length of the name
  SUBSTRING(Name, 1, 5) AS partial_name,  -- Get first 5 characters of name
  REPLACE(Name, 'a', 'e') AS replaced_name -- Replace 'a' with 'e' in the name
FROM Employee;


-- 7.2 Mathematical Functions
SELECT
  Salary,
  ROUND(Salary, 2) AS rounded_salary,     -- Round salary to 2 decimal places
  CEIL(Salary) AS ceiling_salary,         -- Get the ceiling value of salary
  FLOOR(Salary) AS floor_salary,          -- Get the floor value of salary
  POWER(Salary, 2) AS squared_salary,     -- Square the salary
  MOD(Salary, 10000) AS salary_remainder, -- Get remainder when salary is divided by 10,000
  SQRT(Salary) AS salary_sqrt             -- Get square root of salary
FROM Employee;


-- 7.3 Aggregate Functions
SELECT
  COUNT(*) AS total_employees,            -- Total number of employees
  SUM(Salary) AS total_salary,            -- Sum of all employee salaries
  AVG(Salary) AS average_salary,          -- Average salary of employees
  MAX(Salary) AS highest_salary,          -- Highest salary
  MIN(Salary) AS lowest_salary            -- Lowest salary
FROM Employee;

-- Aggregate by Department
SELECT
  Department,
  COUNT(*) AS employees_in_department,    -- Count of employees in each department
  AVG(Salary) AS avg_salary_in_department -- Average salary in each department
FROM Employee
GROUP BY Department;



//Cursore

Title-cursor

avcoe@avcoe-HP-ProDesk-400-G1-SFF:~$ sudo mysql -u root;
[sudo] password for avcoe: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.41-0ubuntu0.20.04.1 (Ubuntu)

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use shravani;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed

mysql>    DELIMITER //
mysql> 
mysql> CREATE PROCEDURE example_proc()
    -> BEGIN
    ->     -- Variable declaration
    ->     DECLARE emp_name VARCHAR(50);
    -> 
    ->     -- Example usage (assigning a value)
    ->     SET emp_name = 'John Doe';
    -> 
    ->     -- You can use SELECT to show the variable
    ->     SELECT emp_name;
    -> END //
Query OK, 0 rows affected (0.17 sec)

mysql> 
mysql> DELIMITER ;
mysql> SET @emp_name = 'John Doe';
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT @emp_name;
+-----------+
| @emp_name |
+-----------+
| John Doe  |
+-----------+
1 row in set (0.01 sec)


mysql> CREATE PROCEDURE fetch_employees()
    -> BEGIN
    ->     -- Declare necessary variables first
    ->     DECLARE v_employee_id INT;
    ->     DECLARE v_first_name VARCHAR(50);
    ->     DECLARE v_last_name VARCHAR(50);
    ->     DECLARE done INT DEFAULT FALSE;
    -> 
    ->     -- Declare the cursor
    ->     DECLARE emp_cursor CURSOR FOR
    ->         SELECT employee_id, first_name, last_name FROM employees;
    -> 
    ->     -- Declare the continue handler to manage the cursor's end
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -> 
    ->     -- Open the cursor
    ->     OPEN emp_cursor;
    -> 
    ->     -- Loop through the cursor's results
    ->     read_loop: LOOP
    ->         FETCH emp_cursor INTO v_employee_id, v_first_name, v_last_name;
    -> 
    ->         -- Exit the loop when all rows have been fetched
    ->         IF done THEN
    ->             LEAVE read_loop;
    ->         END IF;
    -> 
    ->         -- Do something with the fetched data (e.g., display the results) 
    ->         SELECT v_employee_id, v_first_name, v_last_name;
    ->     END LOOP;
    -> 
    ->     -- Close the cursor when done
    ->     CLOSE emp_cursor;
    -> END //
Query OK, 0 rows affected (0.15 sec)

mysql> 
mysql> DELIMITER ;
mysql> DELIMITER //
mysql> 
mysql> CREATE PROCEDURE fetch_employees_with_cursors()
    -> BEGIN
    ->     -- Declare necessary variables
    ->     DECLARE v_employee_id INT;
    ->     DECLARE v_first_name VARCHAR(50);
    ->     DECLARE v_last_name VARCHAR(50);
    ->     DECLARE v_dept_emp_id INT;
    ->     DECLARE v_dept_first_name VARCHAR(50);
    ->     DECLARE done INT DEFAULT FALSE;
    ->     
    ->     -- Declare cursor for all employees
    ->     DECLARE emp_cursor CURSOR FOR
    ->         SELECT employee_id, first_name, last_name FROM employees;
    ->     
    ->     -- Declare cursor with parameters (for department-specific employees) 
    ->     DECLARE dept_cursor CURSOR FOR
    ->         SELECT employee_id, first_name 
    ->         FROM employees WHERE department_id = @dept_id;
    -> 
    ->     -- Declare CONTINUE HANDLER for when no rows are found
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -> 
    ->     -- -- Example of implicit cursor-like SELECT (using a session variable)
    ->     SET @emp_name = (SELECT first_name FROM employees WHERE employee_id = 101);
    ->     SELECT CONCAT('Implicit Cursor Example - Employee Name: ', @emp_name) AS result;
    -> 
    ->     -- Open and process the emp_cursor (Explicit Cursor)
    ->     OPEN emp_cursor;
    ->     read_loop: LOOP
    ->         FETCH emp_cursor INTO v_employee_id, v_first_name, v_last_name;
    ->         IF done THEN
    ->             LEAVE read_loop;
    ->         END IF;
    -> 
    ->         -- Process the data (similar to DBMS_OUTPUT.PUT_LINE in Oracle)
    ->         SELECT CONCAT('Explicit Cursor - ID: ', v_employee_id, ', Name: ', v_first_name, ' ', v_last_name) AS result;
    ->     END LOOP;
    ->     CLOSE emp_cursor;
    -> 
    ->     -- Process the dept_cursor with parameter (Cursor with Parameters)
    ->     SET @dept_id = 10;  -- Example department ID
    ->     OPEN dept_cursor;
    ->     dept_loop: LOOP
    ->         FETCH dept_cursor INTO v_dept_emp_id, v_dept_first_name;
    ->         IF done THEN
    ->             LEAVE dept_loop;
    ->         END IF;
    -> 
    ->         -- Process the data (similar to DBMS_OUTPUT.PUT_LINE in Oracle)
    ->         SELECT CONCAT('Cursor with Parameters - ID: ', v_dept_emp_id, ', Name: ', v_dept_first_name) AS result;
    ->     END LOOP;
    ->     CLOSE dept_cursor;
    -> END //
Query OK, 0 rows affected (0.11 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL fetch_employees_with_cursors();
ERROR 1146 (42S02): Table 'shravani.employees' doesn't exist
