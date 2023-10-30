# IDS-Project-2022

Solution for the project from the subject _'IDS (Database Systems)'_ for the academic year 2021/22 at VUT FIT. \
Řešení projektu z předmětu _'IDS (Databázové systémy)'_ pro akademický rok 2021/22 na VUT FIT.

## Table of Contents

- [Task 1: Data Modeling and Use Case Diagrams](#task-1-data-modeling-and-use-case-diagrams)
  - [Evaluation of Task 1 Solution](#evaluation-of-task-1-solution)
- [Task 2: SQL Script Creation for Database Schema](#task-2-sql-script-creation-for-database-schema)
  - [Evaluation of Task 2 Solution](#evaluation-of-task-2-solution)
- [Task 3: Advanced SQL Script Creation](#task-3-advanced-sql-script-creation)
  - [Evaluation of Task 3 Solution](#evaluation-of-task-3-solution)
- [Task 4: Advanced SQL Script Creation & Documentation Requirements](#task-4-advanced-sql-script-creation--documentation-requirements)
  - [Evaluation of Task 4 Solution](#evaluation-of-task-4-solution)

## Task 1: Data Modeling and Use Case Diagrams

**Objective:**  
Create and document a comprehensive data model and set of use case diagrams for a database-dependent application.

**Tasks:**

1. **Data Model:**

   - **Description:** Develop a data model capturing the structure of data or the data requirements in the database.
   - **Format:** Express this model as either a UML class diagram or an ER diagram using the Crow's Foot notation.
   - **Requirement:** The data model must include at least one relationship of generalization/specialization, meaning it should depict an entity/class and a specialized entity/subclass connected by a generalization/specialization relationship. Ensure the correct notation for this relationship is used in the diagram.

2. **Use Case Diagram:**
   - **Description:** Create a UML Use Case Diagram representing the requirements on the functionality provided by the application using the designed data model.

**Submission:**

- Submit a document containing the above models along with a brief description of the data model.
- The description must clearly articulate the significance of each entity set and relationship set.

**Important Notes:**

- Ensure that the generalization/specialization relationship in the data model is properly represented and easily identifiable.
- The description accompanying the data model should be concise, clear, and provide a comprehensive understanding of the entities and relationships within the model.

### Evaluation of Task 1 Solution

- the _cena(price)_ is not a weak entity - each borrowing has one price, the rate should then be at the tape
- the ERD description is missing

Total points: **4/5**

---

## Task 2: SQL Script Creation for Database Schema

**Objective:**  
Develop an SQL script to create and populate a database schema in line with [the previously created data model](#task-1-data-modeling-and-use-case-diagrams).

**Tasks:**

1. **Database Schema Creation:**

   - **Description:** Write an SQL script to generate the foundational objects of the database schema, including tables, along with defining integrity constraints, especially primary and foreign keys.
   - **Requirements:**
     - Ensure the created database schema aligns with the data model from [the previous project phase](#task-1-data-modeling-and-use-case-diagrams).
     - It's advisable to correct any errors or shortcomings discovered in the ER diagram and make incremental changes to yield a superior solution.

2. **Special Column Constraint:**

   - **Description:** Implement at least one column in the database schema tables with a special value restriction, such as:
     - Social security number or insurance registration number (RČ)
     - Personal/Business identification number (IČ)
     - Medical facility ID (IČPE)
     - ISBN or ISSN
     - Bank account number (also consider the intricacies of account numbers)
   - **Requirements:**
     - Only valid values should be permitted in this column. Achieve this by implementing a CHECK constraint.

3. **Realization of Generalization/Specialization Relationship:**

   - **Description:** Appropriate realization of the generalization/specialization relationship, tailored for a purely relational database. This requires aptly translating the aforementioned relationship and related data model entities into the relational database schema.
   - **Requirements:**
     - Provide a clear description and justification for the chosen method of converting the generalization/specialization relationship into the relational database schema in the accompanying [documentation](./xshili00_xbrazd22.pdf).

4. **Script Features:**
   - **Description:** The script should also facilitate the auto-generation of primary key values for a certain table using a sequence.
   - **Requirements:**
     - For instance, if records are inserted into a specific table and the primary key value is undefined (i.e., NULL), the value should be auto-generated.

**Important Notes:**

- Ensure that the design and data integrity of the created schema closely reflect the original data model.
- The special value constraints should be well-defined to prevent erroneous data entry.
- Proper documentation is essential, particularly for decisions made during the generalization/specialization translation process.

### Evaluation of Task 2 Solution

- missing PK for one table, otherwise OK

Total points: **4.5/5**

---

## Task 3: Advanced SQL Script Creation

**Objective:**  
Develop an SQL script that first establishes the foundational objects of the database schema, populates the tables with sample data (similarly to the script in [Task 2](#task-2-sql-script-creation-for-database-schema)), and then executes several SELECT queries.

**Tasks:**

1. **Initial Setup:**

   - **Description:** Create the basic objects of the database schema and populate the tables with sample data.
   - **Requirements:** This initial setup should mirror the script described in [Task 2](#task-2-sql-script-creation-for-database-schema).

2. **Two-table Join Queries:**

   - **Description:** Formulate SQL SELECT queries to join two tables.
   - **Requirements:**
     - At least two such queries should be included in the script.
     - For each query, provide a clear explanation (in SQL code comments) describing the function of the query within the application and the data it seeks.

3. **Three-table Join Query:**

   - **Description:** Construct an SQL SELECT query that joins three tables.
   - **Requirements:**
     - The script should contain at least one such query.
     - An accompanying comment should describe the data targeted by this query and its role within the application.

4. **Queries with GROUP BY and Aggregate Functions:**

   - **Description:** Design SQL SELECT queries using the GROUP BY clause and an aggregate function.
   - **Requirements:**
     - Incorporate at least two such queries into the script.
     - Each query should have a corresponding comment that elaborates on the query's application role and the type of data it retrieves.

5. **Query with EXISTS Predicate:**

   - **Description:** Devise an SQL SELECT query incorporating the EXISTS predicate.
   - **Requirements:**
     - Include at least one such query in the script.
     - A comment should detail the function of this query in the application and the data it aims to fetch.

6. **Query with IN Predicate and Nested Select:**
   - **Description:** Formulate an SQL SELECT query using the IN predicate combined with a nested SELECT statement (not IN with a set of constant data).
   - **Requirements:**
     - Ensure the script has at least one such query.
     - Attach an explanatory comment highlighting the query's function and the data it is designed to retrieve.

**Important Notes:**

- Ensure each SQL query is crafted to cater to specific data retrieval needs.
- Comments for each query are crucial for clear understanding and documentation.
- Queries should be optimized for efficiency and should retrieve accurate data as per the given requirements.

### Evaluation of Task 3 Solution

- OK

Total points: **5/5**

---

## Task 4: Advanced SQL Script Creation & Documentation Requirements

**Objective:** Develop an SQL script that establishes foundational database schema objects, fills tables with sample data (mirroring the script in [Task 2](#task-2-sql-script-creation-for-database-schema)), and introduces advanced database restrictions or objects as per specified criteria. The script will also demonstrate data manipulation commands and queries to showcase the usage of the restrictions and objects.

**Tasks:**

1. **Initial Setup:**

   - **Description:** Create the basic database schema objects and populate tables with sample data.
   - **Requirements:** Align with the script described [Task 2](#task-2-sql-script-creation-for-database-schema).

2. **Database Triggers:**

   - **Description:** Design and implement non-trivial database triggers.
   - **Requirements:**
     - Include at least two such triggers.
     - Demonstrate each trigger in action.

3. **Stored Procedures:**

   - **Description:** Construct non-trivial stored procedures.
   - **Requirements:**
     - Create at least two procedures.
     - These procedures must collectively feature: a cursor, exception handling, and use of a variable with a datatype referring to a table row or column type (`table_name.column_name%TYPE` or `table_name%ROWTYPE`).
     - Showcase each procedure.

4. **Index Creation and Optimization:**

   - **Description:** Create an index explicitly to optimize query processing.
   - **Requirements:**
     - Develop at least one such index.
     - Provide the specific query that the index impacts.
     - Document the index's utilization in the query. This can be combined with an EXPLAIN PLAN.

5. **EXPLAIN PLAN Usage:**

   - **Description:** Use the EXPLAIN PLAN for a database query with a two-table join, aggregate function, and GROUP BY clause.
   - **Requirements:**
     - Thoroughly document the execution plan.
     - Describe methods used for query optimization (e.g., index usage, join type).
     - Suggest and implement a strategy for further query acceleration. Rerun the EXPLAIN PLAN and compare results before and after the optimization.

6. **Access Rights:**

   - **Description:** Define access rights for database objects for another team member.
   - **Requirements:** Ensure these rights are properly set up for the next task.

7. **Materialized View:**

   - **Description:** Design a materialized view belonging to another team member that uses tables defined by the first team member.
   - **Requirements:**
     - Ensure access rights have been defined from the previous task.
     - Include SQL commands/queries that illustrate how the materialized view functions.

8. **Documentation Requirements:**

   - Describe the final database schema.
   - Detail each solution point from the script in [Task 4](#task-4-advanced-sql-script-creation--documentation-requirements), including the rationale (e.g., describing the EXPLAIN PLAN output before and after index creation).

### Evaluation of Task 4 Solution

Total points: **10/19**
