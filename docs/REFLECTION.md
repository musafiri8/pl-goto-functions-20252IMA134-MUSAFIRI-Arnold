# 📑 Assignment Reflection (Task C2)

**Course:** Database Development with PL/SQL (INSY 8311)  
**Instructor:** Eric Maniraguha | `eric.maniraguha@auca.ac.rw`  
**Student Name:** MUSAFIRI Arnold  
**Student ID:** 20252IMA134  
**Date:** Thursday, October 8, 2026  
**Tool Environment:** Oracle SQL Developer (Version 26.2.0.186.2220) / Oracle AI Database 26ai  

---

## 1. Executive Summary

This practical assignment explored control flow mechanisms and modular programming within Oracle PL/SQL. Specifically, it investigated:
1. The mechanics, syntax, and operational caveats of unconditional branching using the **PL/SQL `GOTO` statement**.
2. The compilation constraints governing `GOTO` jumps (specifically compiler error `PLS-00375`).
3. Refactoring unstructured branch patterns into **structured control flow** (`IF-ELSIF-ELSE`).
4. The design, compilation, and execution of **stored PL/SQL functions** returning scalar values.
5. The integration of user-defined stored functions inside standard SQL `SELECT` statements.
6. Robust exception handling and parameter validation within business logic (payroll validation).

---

## 2. Part A: PL/SQL GOTO Statements & Control Flow

### 2.1 Understanding GOTO Mechanics
The `GOTO` statement unconditionally transfers control to an explicit label enclosed by double angle brackets (e.g., `<<label_name>>`). In task **A1 (Number Classifier)** and **A2 (Salary Review)**, `GOTO` was used to branch execution to specific target labels based on numeric evaluations.

While `GOTO` provides direct jumps, it inherently introduces unstructured control flow ("spaghetti code"), where tracking the program state and variable scopes becomes cognitively demanding and error-prone as the codebase expands.

### 2.2 Compilation Rules and Illegal GOTO (Task A3)
Oracle enforces strict compile-time restrictions on `GOTO` statements to preserve block scoping and execution integrity:
- **Rule 1:** A `GOTO` statement **cannot jump into** an `IF` statement, `CASE` statement, `LOOP`, or child sub-block from the outside.
- **Rule 2:** A `GOTO` statement cannot jump from an exception handler into the current block.
- **Rule 3:** A label must immediately precede an executable statement or a `NULL;` statement.

In task **A3**, attempting to branch from outside into the middle of an `IF` block triggers:
```text
ORA-06550: line 5, column 5:
PLS-00375: illegal GOTO statement; this GOTO cannot branch to label 'INSIDE_IF_BLOCK'
ORA-06550: line 8, column 9:
PL/SQL: Statement ignored
```
The resolution requires placing the label in an accessible outer enclosing block or restructuring the logic into sequential blocks.

### 2.3 Structured Programming vs. Unstructured Jumps (Task A4)
Task **A4** refactored the salary classification from `GOTO` to standard structured `IF ... ELSIF ... ELSE ... END IF;` constructs.

| Evaluation Metric | `GOTO` Branching | Structured `IF/ELSIF` |
|:---|:---|:---|
| **Readability** | Low (non-linear jumping) | High (linear top-down flow) |
| **Maintainability** | High risk of dead code & infinite loops | Easy to extend with new conditions |
| **Debugging** | Difficult step-debugging across labels | Deterministic execution path |
| **Industry Standard** | Strongly discouraged / restricted | Best practice in enterprise PL/SQL |

---

## 3. Part B: Stored Functions and SQL Interoperability

### 3.1 Design of Stored Functions (Tasks B1 – B4)
Functions in PL/SQL encapsulate reusable computations and must always return a value using the `RETURN` statement:
- **`fn_annual_salary` (B1):** Converts monthly compensation to annualized gross (`monthly_salary * 12`).
- **`fn_years_of_service` (B2):** Computes completed full years using `FLOOR(MONTHS_BETWEEN(TRUNC(SYSDATE), hire_date) / 12)`.
- **`fn_calculate_tax` (B3):** Implements progressive tax tiering (10%, 20%, 30%).
- **`fn_dept_name` (B4):** Performs relational lookup from `departments` and translates department IDs to human-readable strings.

### 3.2 Functions Used Directly in SQL Queries (Task B5)
One of the most powerful features of PL/SQL stored functions is their ability to execute seamlessly inside SQL `SELECT`, `WHERE`, and `ORDER BY` clauses. For a PL/SQL function to be callable from SQL:
1. It must be a **stored function** (not a local anonymous procedure).
2. All parameters and the return type must be standard SQL data types (e.g., `NUMBER`, `VARCHAR2`, `DATE`), not PL/SQL-only types (like associative arrays or booleans).
3. It must adhere to purity rules (no DML statements modifying database state during query execution, no transaction control like `COMMIT`/`ROLLBACK`).

Querying `employees` while computing `annual_salary`, `years_of_service`, `department_name`, and `estimated_tax` in a single SQL query demonstrated how business logic is cleanly centralized in the database layer.

---

## 4. Part C: Combined Payroll Validator (Task C1)

Task **C1** combined data validation, multi-rule business logic, and error resilience:
- **Existence Verification:** Queries `COUNT(*)` from `employees` to verify valid foreign key reference before calculating payroll.
- **Boundary Checks:** Enforces `gross_salary > 0`, non-negative taxes (`tax_amount >= 0`), and ensures deductions do not exceed gross pay (`tax_amount <= gross_salary`).
- **Defensive Exception Handling:** Encapsulated within `WHEN OTHERS THEN RETURN 'INVALID: unexpected validation error';` so unhandled runtime exceptions fail gracefully rather than crashing upstream batch workflows.

---

## 5. Challenges Encountered & Resolutions

1. **Managing Label Targets for Loop Iterations:**  
   *Challenge:* In task A1, looping through numbers with `GOTO` originally skipped to the end, but in PL/SQL a label cannot immediately precede an `END LOOP;` without an executable statement.  
   *Resolution:* Appended a `NULL;` statement under the `<<next_iteration>>` label before `END LOOP;`.

2. **Handling Division & Date Boundary Precision:**  
   *Challenge:* `MONTHS_BETWEEN` produces fractional decimal months when dates do not align with month ends.  
   *Resolution:* Used `TRUNC(SYSDATE)` combined with `FLOOR(... / 12)` to ensure strict completed calendar years of tenure.

3. **Exception Shielding for Non-Existent Records:**  
   *Challenge:* Directly querying a non-existent ID using `SELECT INTO` raises `ORA-01403: no data found`.  
   *Resolution:* Trapped `WHEN NO_DATA_FOUND` explicitly to return fallback indicators (`NULL` or `'UNKNOWN DEPARTMENT'`), maintaining SQL query stability.

---

## 6. Academic Integrity & AI Assistance Disclosure

In accordance with the assignment guidelines:
- **AI Tool Usage:** An AI coding assistant was consulted for architectural repository scaffolding, SQL syntax verification, and structuring markdown documentation.
- **Student Ownership & Verification:** All SQL scripts were personally executed and validated on Oracle AI Database 26ai using Oracle SQL Developer (Version 26.2.0.186.2220). I thoroughly understand every algorithm, label scope rule, and function signature presented in this repository, and I am prepared to explain and demonstrate them during the upcoming class quiz.
