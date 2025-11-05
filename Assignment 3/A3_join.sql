-- Create Database
CREATE DATABASE IF NOT EXISTS A3;
USE A3;

-- Create Tables

CREATE TABLE IF NOT EXISTS Dept(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Emp(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    ManagerID INT,
    FOREIGN KEY (DeptID) REFERENCES Dept(DeptID),
    FOREIGN KEY (ManagerID) REFERENCES Emp(EmpID)
);

CREATE TABLE IF NOT EXISTS Company(
    CompID INT PRIMARY KEY,
    CompName VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Emp_Comp(
    EmpID INT,
    CompID INT,
    PRIMARY KEY(EmpID, CompID),
    FOREIGN KEY(EmpID) REFERENCES Emp(EmpID),
    FOREIGN KEY(CompID) REFERENCES Company(CompID)
);

CREATE TABLE IF NOT EXISTS Instructor(
    InstrID INT PRIMARY KEY,
    InstrName VARCHAR(50),
    DeptID INT,
    FOREIGN KEY(DeptID) REFERENCES Dept(DeptID)
);

CREATE TABLE IF NOT EXISTS Course(
    CourseID VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(50),
    DeptID INT,
    InstrID INT,
    FOREIGN KEY(DeptID) REFERENCES Dept(DeptID),
    FOREIGN KEY(InstrID) REFERENCES Instructor(InstrID)
);

CREATE TABLE IF NOT EXISTS Student(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    DeptID INT,
    FOREIGN KEY(DeptID) REFERENCES Dept(DeptID)
);

CREATE TABLE IF NOT EXISTS Student_Course(
    StudentID INT,
    CourseID VARCHAR(10),
    PRIMARY KEY(StudentID, CourseID),
    FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY(CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE IF NOT EXISTS Deposit(
    DepositID INT PRIMARY KEY,
    EmpID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY(EmpID) REFERENCES Emp(EmpID)
);

CREATE TABLE IF NOT EXISTS Borrow(
    BorrowID INT PRIMARY KEY,
    EmpID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY(EmpID) REFERENCES Emp(EmpID)
);

-- Insert Data
INSERT INTO Dept VALUES
(1,'Computer Science'),
(2,'Information Technology');

INSERT INTO Emp VALUES
(101,'Ramesh',1,80000,NULL),
(102,'Suresh',2,75000,101);

INSERT INTO Company VALUES
(1,'TCS'),
(2,'Infosys');

INSERT INTO Emp_Comp VALUES
(101,1),
(102,2);

INSERT INTO Instructor VALUES
(201,'Dr. Ramesh',1),
(202,'Dr. Suresh',2);

INSERT INTO Course VALUES
('CS101','DBMS',1,201),
('IT101','Networking',2,202);

INSERT INTO Student VALUES
(301,'Rahul',1),
(302,'Neha',2);

INSERT INTO Student_Course VALUES
(301,'CS101'),
(302,'IT101');

INSERT INTO Deposit VALUES
(601,101,5000);

INSERT INTO Borrow VALUES
(701,102,3000);

-- Views
CREATE OR REPLACE VIEW Deposit_View AS 
SELECT EmpID, Amount FROM Deposit;

CREATE OR REPLACE VIEW Borrow_View AS 
SELECT EmpID, Amount FROM Borrow;

CREATE OR REPLACE VIEW comp_sci_course_info AS 
SELECT c.CourseID, c.Title 
FROM Course c 
JOIN Dept d ON c.DeptID = d.DeptID 
WHERE d.DeptName = 'Computer Science';

-- Join QUERIES 

SELECT e.EmpName, d.DeptName 
FROM Emp e 
JOIN Dept d ON e.DeptID = d.DeptID;

SELECT e.EmpName, m.EmpName AS ManagerName 
FROM Emp e 
LEFT JOIN Emp m ON e.ManagerID = m.EmpID;

SELECT i.InstrName, c.Title 
FROM Instructor i 
LEFT JOIN Course c ON i.InstrID = c.InstrID;

SELECT s.StudentName, c.Title 
FROM Student s 
JOIN Student_Course sc ON s.StudentID = sc.StudentID 
JOIN Course c ON sc.CourseID = c.CourseID;

SELECT e.EmpName, c.CompName 
FROM Emp e 
JOIN Emp_Comp ec ON e.EmpID = ec.EmpID 
JOIN Company c ON ec.CompID = c.CompID;

SELECT i.InstrName, d.DeptName 
FROM Instructor i 
JOIN Dept d ON i.DeptID = d.DeptID;

SELECT s.StudentName, d.DeptName 
FROM Student s 
JOIN Dept d ON s.DeptID = d.DeptID;

SELECT EmpName, Salary 
FROM Emp 
WHERE Salary > 75000;

-- Subquery

SELECT EmpName 
FROM Emp 
WHERE DeptID = (SELECT DeptID FROM Dept WHERE DeptName='Computer Science');

SELECT EmpName 
FROM Emp 
WHERE DeptID <> (SELECT DeptID FROM Dept WHERE DeptName='Computer Science');

SELECT CompName 
FROM Company 
WHERE CompID = (
    SELECT CompID 
    FROM Emp_Comp 
    GROUP BY CompID 
    ORDER BY COUNT(EmpID) DESC 
    LIMIT 1
);

SELECT Title 
FROM Course 
WHERE InstrID IN (SELECT InstrID FROM Instructor WHERE DeptID=1);

SELECT StudentName 
FROM Student 
WHERE StudentID IN (SELECT StudentID FROM Student_Course);

SELECT DeptName 
FROM Dept 
WHERE DeptID IN (SELECT DeptID FROM Student);

SELECT EmpName 
FROM Emp 
WHERE Salary = (SELECT MAX(Salary) FROM Emp);

SELECT StudentName 
FROM Student 
WHERE DeptID = (SELECT DeptID FROM Dept WHERE DeptName='Computer Science');

-- View Queries
SELECT * FROM Deposit_View;

SELECT * FROM Borrow_View;

SELECT * FROM comp_sci_course_info;

SELECT CourseID, Title FROM comp_sci_course_info;
