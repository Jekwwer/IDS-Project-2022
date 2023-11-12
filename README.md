# IDS-Project-2022: Video Rental Database

> 🎓 **University**: [VUT FIT](https://www.fit.vut.cz/)
>
> 📚 **Course**: [Database Systems (IDS)](https://www.fit.vut.cz/study/course/268224/)
>
> 📅 **Academic Year**: 2021/22

## 📌 Table of Contents

- [📢 Project Overview](#-project-overview)
- [🔍 Task 1: Data Modeling and Use Case Diagrams](#-task-1-data-modeling-and-use-case-diagrams)
  - [✅ Evaluation of Task 1 Solution](#-evaluation-of-task-1-solution)
- [📜 Task 2: SQL Script Creation for Database Schema](#-task-2-sql-script-creation-for-database-schema)
  - [✅ Evaluation of Task 2 Solution](#-evaluation-of-task-2-solution)
- [📜 Task 3: Advanced SQL Script Creation](#-task-3-advanced-sql-script-creation)
  - [✅ Evaluation of Task 3 Solution](#-evaluation-of-task-3-solution)
- [📝 Task 4: Advanced SQL Script Creation & Documentation](#-task-4-advanced-sql-script-creation--documentation)
  - [✅ Evaluation of Task 4 Solution](#-evaluation-of-task-4-solution)

## 📢 Project Overview

### 🎯 Task:

Design the Information System (IS) for a video rental service that caters to renting tapes to registered customers. The system will serve the dual purpose of assisting the video rental staff and providing an interface for the customers. Key functionalities include:

- 🖥 **Customer Interface:** Allows customers to browse and select desired titles based on criteria and check their availability.
- 🧑‍💼 **Staff Interface:** Enables staff to process the borrowing and return of titles.
- 💵 **Accounting and Pricing:** The system should generate invoices for each borrowing. The rental price is contingent on the duration of the loan and is designed to incrementally increase over time. Importantly, the pricing model is subject to modifications.

## 🔍 Task 1: Data Modeling and Use Case Diagrams

**Objective:** Develop and document a detailed data model and a use case diagram for a database-dependent application.

**Tasks:**

1. **Data Model:**  
   _Description:_ Craft a data model outlining the data's structure or requirements in the database.  
   _Format:_ Represent this model via a UML class diagram or an ER diagram using Crow's Foot notation.  
   _Requirement:_ The model should encapsulate at least one generalization/specialization relationship. Use the proper notation for this relationship in the diagram.

2. **Use Case Diagram:**  
   _Description:_ Develop a UML Use Case Diagram showcasing the functionality requirements of the application using the designed data model.

**Submission Requirements:**

- A document presenting the models along with a concise description of the data model.
- The description should lucidly elucidate the importance of each entity set and relationship set.

**Key Points:**

- The generalization/specialization relationship in the data model must be properly showcased.
- The description should be precise, clear, and offer a comprehensive understanding of the model's entities and relationships.

### ✅ Evaluation of Task 1 Solution

- The _cena(price)_ is not a weak entity - each borrowing has a singular price, the rate should be at the tape.
- ERD description is absent.

🟢🟢🟢🟢🔴  
**Total Points: 4/5**

---

## 📜 Task 2: SQL Script Creation for Database Schema

**Objective:** Construct an SQL script to generate and populate a database schema consistent with the [previously designed data model](#task-1-data-modeling-and-use-case-diagrams).

**Tasks:**

1. **Database Schema Creation:**  
   _Description:_ Formulate an SQL script to instantiate the database's foundational objects, including tables. Also, define integrity constraints like primary and foreign keys.  
   _Requirements:_ The resultant schema should resonate with the [prior project's data model](#task-1-data-modeling-and-use-case-diagrams). If any anomalies are discovered in the ER diagram, rectify them to produce an enhanced solution.

2. **Special Column Constraint:**  
   _Description:_ Integrate at least one column in the schema with a distinct value restriction, for instance:

   - Social security number (RČ)
   - Business identification number (IČ)
   - Medical facility ID (IČPE)
   - ISBN or ISSN
   - Bank account number  
     _Requirements:_ Implement a CHECK constraint to ensure only valid values populate this column.

3. **Generalization/Specialization Relationship:**  
   _Description:_ Accurately reflect the generalization/specialization relationship, suited for a purely relational database. Convert the relationship and relevant data model entities into the database schema.  
   _Requirements:_ Offer a clear rationale for the methodology adopted in translating the relationship into the relational database schema in the supplementary [documentation](./submitted-documentation.pdf).

4. **Script Features:**  
   _Description:_ The script should enable the auto-generation of primary key values for a specific table through a sequence.  
   _Requirements:_ For instance, if records are inserted into a certain table and the primary key value is missing, it should be auto-generated.

**Essential Notes:**

- The schema's design and data integrity should mirror the [original data model](#🔍-task-1-data-modeling-and-use-case-diagrams) closely.
- Constraints should be clearly defined to prevent inaccurate data entries.
- Comprehensive documentation, especially concerning decisions during the translation process, is pivotal.

### ✅ Evaluation of Task 2 Solution

- Primary key absent for one table; otherwise, satisfactory.

🟢🟢🟢🟢🟡  
**Total Points: 4.5/5**

---

## 📜 Task 3: Advanced SQL Script Creation

**Objective:** Develop an SQL script that first establishes the foundational objects of the database schema, populates the tables with sample data (mirroring the script in [Task 2](#📜-task-2-sql-script-creation-for-database-schema)), and then executes a variety of SELECT queries.

**Tasks:**

1. **Initial Setup:**  
   _Description:_ Create the basic objects of the database schema and populate the tables with sample data.  
   _Requirements:_ This initial setup should mirror the script described in [Task 2](#📜-task-2-sql-script-creation-for-database-schema).

2. **Two-table Join Queries:**  
   _Description:_ Formulate SQL SELECT queries that join two tables.  
   _Requirements:_

   - At least two such queries should be included in the script.
   - For each query, provide a clear explanation (in SQL code comments) describing the function of the query within the application and the data it seeks.

3. **Three-table Join Query:**  
   _Description:_ Construct an SQL SELECT query that joins three tables.  
   _Requirements:_

   - The script should contain at least one such query.
   - An accompanying comment should describe the data targeted by this query and its role within the application.

4. **Queries with GROUP BY and Aggregate Functions:**  
   _Description:_ Design SQL SELECT queries using the GROUP BY clause and an aggregate function.  
   _Requirements:_

   - Incorporate at least two such queries into the script.
   - Each query should have a corresponding comment that elaborates on the query's application role and the type of data it retrieves.

5. **Query with EXISTS Predicate:**  
   _Description:_ Devise an SQL SELECT query incorporating the EXISTS predicate.  
   _Requirements:_

   - Include at least one such query in the script.
   - A comment should detail the function of this query in the application and the data it aims to fetch.

6. **Query with IN Predicate and Nested Select:**  
   _Description:_ Formulate an SQL SELECT query using the IN predicate combined with a nested SELECT statement (not IN with a set of constant data).  
   _Requirements:_
   - Ensure the script has at least one such query.
   - Attach an explanatory comment highlighting the query's function and the data it is designed to retrieve.

**Important Notes:**

- Ensure each SQL query is crafted to cater to specific data retrieval needs.
- Comments for each query are crucial for clear understanding and documentation.
- Queries should be optimized for efficiency and should retrieve accurate data as per the given requirements.

### ✅ Evaluation of Task 3 Solution

- All requirements met successfully.

🟢🟢🟢🟢🟢  
**Total Points: 5/5**

---

## 📝 Task 4: Advanced SQL Script Creation & Documentation

**Objective:** Develop an SQL script that establishes foundational database schema objects, fills tables with sample data mirroring the script in [Task 2](#📜-task-2-sql-script-creation-for-database-schema), and introduces advanced database restrictions or objects as per specified criteria. The script should also illustrate data manipulation commands and queries to showcase the utilization of the restrictions and objects.

**Tasks:**

1. **Initial Setup:**  
   _Description:_ Create the foundational database schema objects and populate tables with sample data.  
   _Requirements:_ Ensure alignment with the script detailed in [Task 2](#📜-task-2-sql-script-creation-for-database-schema).

2. **Database Triggers:**  
   _Description:_ Design and introduce non-standard database triggers.  
   _Requirements:_

   - Implement at least two unique triggers.
   - Clearly demonstrate the function of each trigger.

3. **Stored Procedures:**  
   _Description:_ Develop non-standard stored procedures.  
   _Requirements:_

   - Formulate a minimum of two procedures.
   - The procedures should, in combination, encompass a cursor, exception management, and the employment of a variable with a datatype that refers to a table row or column type (e.g., table_name.column_name%TYPE or table_name%ROWTYPE).
   - Demonstrate the utility of each procedure.

4. **Index Creation and Optimization:**  
   _Description:_ Construct an explicit index to enhance query processing efficiency.  
   _Requirements:_

   - Develop at least one distinct index.
   - Detail the particular query impacted by this index.
   - Combine the index's utilization in the query with an EXPLAIN PLAN.

5. **EXPLAIN PLAN Usage:**  
   _Description:_ Utilize the EXPLAIN PLAN for a database query incorporating a two-table join, aggregate function, and a GROUP BY clause.  
   _Requirements:_

   - Extensively document the execution plan.
   - Elucidate the techniques employed for query optimization, such as index utility or join type.
   - Propose and execute a strategy for further query enhancement. Reinitiate the EXPLAIN PLAN and compare outcomes pre and post-optimization.

6. **Access Rights:**  
   _Description:_ Determine access rights for database entities for another team participant.  
   _Requirements:_ Ensure these rights are correctly prepared for subsequent tasks.

7. **Materialized View:**  
   _Description:_ Design a materialized view owned by another team participant that uses tables defined by the first team member.  
   _Requirements:_
   - Confirm access rights from the preceding task have been set.
   - Incorporate SQL instructions/queries that demonstrate the function of the materialized view.

**Documentation Requirements:**

- Describe the ultimate database schema in detail.
- Elaborate on every solution aspect from the script in [Task 4](#📝-task-4-advanced-sql-script-creation--documentation), including the rationale (for instance, describing the EXPLAIN PLAN output both before and after the creation of an index).

### ✅ Evaluation of Task 4 Solution

- Points deducted for ambiguous documentation.
- Some SQL commands were missing.
- Specifics on errors encountered:
  - Documentation lacked the reasoning behind certain design decisions.

🟢🟢🟡🔴🔴  
**Total Points: 10/19**

---

**🔙 Back to [Table of Contents](#-table-of-contents)**
