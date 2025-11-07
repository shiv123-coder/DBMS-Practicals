# 🧮 DBMS Practical Assignments

This repository contains **Database Management System (DBMS) Practical Assignments** completed as part of the academic curriculum.  
Each practical demonstrates implementation of **SQL**, **PL/SQL**, and **NoSQL (MongoDB)** concepts — including queries, triggers, cursors, procedures, and database connectivity.

---

## 🏫 **Information**

**Subject:** Database Management System (DBMS)  
**Student Name:** _Shivshankar Dhareppa Mali_  
**Course:** B.E. / B.Tech – Computer Engineering  
**Tool Stack:** MySQL, Oracle SQL, PL/SQL, MongoDB

---

## 📚 **Contents**

| Sr. No. | Experiment Performed | Page No. |
| :------: | :------------------ | :-------: |

### **GROUP A : SQL and PL/SQL**

| 1 | **Case Study & Conceptual Design**  
Decide a real-time application case study and formulate a problem statement. Propose a conceptual design using ER tools (ERD Plus / ER Win).  
Identify entities, relationships, attributes, keys, and normalize the relational model. | 1–5 |
| 2 | **SQL Queries – DDL and DML**  
a) Create SQL DDL objects (Table, View, Index, Sequence, Synonym, Constraints).  
b) Execute at least 10 SQL DML queries on the application database. | 6–15 |
| 3 | **SQL Queries – Joins, Subqueries, and Views**  
Execute at least 10 SQL DML queries demonstrating various Joins, Subqueries, and Views. | 16–20 |
| 4 | **Unnamed PL/SQL Block – Control Structures & Exception Handling**  
Design a PL/SQL block for Library fine calculation.  
Use Borrower and Fine tables; handle exceptions and update status after return. | 21–26 |
| 5 | **PL/SQL Block – Area of Circle**  
Write a PL/SQL block to calculate area of circle for radius values 5 to 9.  
Store results in a table named `areas(radius, area)`. | 27–33 |
| 6 | **Named PL/SQL Block – Stored Procedure and Function**  
Create a stored procedure `proc_Grade` to categorize students based on marks.  
Use tables `Stud_Marks(name, total_marks)` and `Result(roll, name, class)`. | 27–33 |
| 7 | **Cursors – Implicit, Explicit, FOR Loop, Parameterized**  
Write a parameterized cursor program that merges records from `N_RollCall` into `O_RollCall`, skipping duplicates. | 34–39 |
| 8 | **Database Trigger – Row/Statement Level, Before/After**  
Create triggers on `Library` table to track updates/deletions.  
Log old records into `Library_Audit` table. | 40–44 |
| 9 | **Database Connectivity – SQL**  
Develop a front-end program (Java/Python/etc.) to connect to MySQL/Oracle database and perform add, delete, and edit operations. | 45–46 |

---

### **GROUP B : NoSQL (MongoDB)**

| 10 | **MongoDB CRUD Operations**  
Design and execute MongoDB queries using CRUD operations and logical operators. | 47–48 |
| 11 | **MongoDB Aggregation & Indexing**  
Implement MongoDB aggregation and indexing operations with suitable examples. | 49–52 |
| 12 | **MongoDB MapReduce Operations**  
Execute MapReduce operations in MongoDB with example datasets. | 53–54 |
| 13 | **Database Connectivity – MongoDB**  
Develop a front-end program to connect MongoDB with a UI, implementing add, delete, and edit operations. | 55–56 |

---

---

## 📂 **Repository Structure**
DBMS-Practicals/
│
├── GroupA_SQL-PLSQL/
│ ├── Assignment1_ER_Model.pdf
│ ├── Assignment2_SQL_DDL_DML.sql
│ ├── Assignment3_Joins_Subqueries.sql
│ ├── Assignment4_PL_SQL_BookFine.sql
│ ├── Assignment5_Area_Of_Circle.sql
│ ├── Assignment6_Procedure_Function.sql
│ ├── Assignment7_Cursor.sql
│ ├── Assignment8_Triggers.sql
│ ├── Assignment9_DBConnectivity.java
│
├── GroupB_MongoDB/
│ ├── Assignment10_CRUD.js
│ ├── Assignment11_Aggregation_Indexing.js
│ ├── Assignment12_MapReduce.js
│ ├── Assignment13_MongoConnectivity.js
│
└── README.md


🏁 Acknowledgement

These practicals were performed under the guidance of respected faculty and as part of the Database Management System Laboratory coursework.

✍️ Author

Name: Shivshankar Dhareppa Mali
GitHub: @shiv123-coder

Repository: DBMS-Practicals
