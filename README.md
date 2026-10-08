# PL/SQL GOTO Statements and Functions - Individual Assignment III

**Course:** Database Development with PL/SQL (INSY 8311)  
**Instructor:** Eric Maniraguha | `eric.maniraguha@auca.ac.rw`  
**Student Name:** MUSAFIRI Arnold  
**Student ID:** 20252IMA134  
**Date:** Thursday, October 8, 2026  
**Development Tool:** Oracle SQL Developer (Version 26.2.0.186.2220)  
**Database Engine:** Oracle AI Database 26ai Free Release (Pluggable Database: `AR_PDB_20252IMA134`)  
**Repository Name:** `pl-goto-functions-20252IMA134-MUSAFIRI Arnold`  

---

##  Table of Contents
- [Assignment Overview](#-assignment-overview)
- [Repository Structure](#-repository-structure)
- [Summary of Tasks](#-summary-of-tasks)
  - [Part A — GOTO Statements](#part-a--goto-statements)
  - [Part B — Stored Functions](#part-b--stored-functions)
  - [Part C — Combined Task & Reflection](#part-c--combined-task--reflection)
- [How to Run in Oracle SQL Developer](#-how-to-run-in-oracle-sql-developer)
- [Screenshots & Verification](#-screenshots--verification)
- [Academic Integrity & AI Disclosure](#-academic-integrity--ai-disclosure)

---

## Assignment Overview

This individual assignment focuses on mastering core PL/SQL procedural features, structured control flow, and modular database programming:
1. **PL/SQL `GOTO` statements:** Branching labels, unconditional jumps, and scoping rules.
2. **PL/SQL Compiler Constraints:** Identifying illegal branch operations (`PLS-00375`) and implementing valid fixes.
3. **Structured Control Flow:** Refactoring unstructured `GOTO` jumps into maintainable `IF-ELSIF-ELSE` blocks.
4. **Stored Functions:** Creating standalone functions with parameter passing and typed return values.
5. **Exception Handling:** Graceful error handling (`NO_DATA_FOUND`, `WHEN OTHERS`).
6. **SQL Interoperability:** Invoking PL/SQL functions directly inside SQL `SELECT` queries.
7. **Business Rules Validation:** Implementing a composite payroll validation function.

---

##  Repository Structure

```text
pl-goto-functions-20252IMA134-MUSAFIRI Arnold/
├── README.md
├── .gitignore
├── 00_setup/
│   └── create_tables.sql
├── 01_goto/
│   ├── A1_number_classifier.sql
│   ├── A2_salary_review.sql
│   ├── A3_illegal_goto.sql
│   └── A4_rewrite_no_goto.sql
├── 02_functions/
│   ├── B1_fn_annual_salary.sql
│   ├── B2_fn_years_of_service.sql
│   ├── B3_fn_calculate_tax.sql
│   ├── B4_fn_dept_name.sql
│   └── C1_fn_validate_payroll.sql
├── 03_tests/
│   ├── B5_functions_in_select.sql
│   ├── test_functions.sql
│   └── test_validate_payroll.sql
├── screenshots/
│   ├── A1_output.png
│   ├── A2_output.png
│   ├── A3_error_and_fix.png
│   ├── A4_output.png
│   ├── B5_select_output.png
│   └── C1_output.png
└── docs/
    ├── REFLECTION.md
    └── SQL_DEVELOPER_GUIDE.md
```

---

##  Summary of Tasks

### Part A — GOTO Statements
- **A1 — Number Classifier (`01_goto/A1_number_classifier.sql`):** Classifies numbers into Positive, Negative, or Zero using `GOTO` jumps to corresponding target labels.
- **A2 — Salary Review (`01_goto/A2_salary_review.sql`):** Categorizes compensation into `LOW` (< 500k), `STANDARD` (500k - 1M), and `HIGH` (> 1M) tiers using label jumping.
- **A3 — Illegal GOTO and Fix (`01_goto/A3_illegal_goto.sql`):** Explains compiler restriction `PLS-00375` (jumping into an `IF` block from outside) and demonstrates the legal fix.
- **A4 — Rewrite Without GOTO (`01_goto/A4_rewrite_no_goto.sql`):** Re-implements A2 using clean structured `IF-ELSIF-ELSE` blocks, explaining benefits of readability and single-entry control flow.

### Part B — Stored Functions
- **B1 — Annual Salary (`02_functions/B1_fn_annual_salary.sql`):** `fn_annual_salary(p_employee_id)` multiplies monthly salary by 12 with `NO_DATA_FOUND` handling.
- **B2 — Years of Service (`02_functions/B2_fn_years_of_service.sql`):** `fn_years_of_service(p_employee_id)` calculates completed years using `MONTHS_BETWEEN(TRUNC(SYSDATE), hire_date) / 12`.
- **B3 — Tax Calculator (`02_functions/B3_fn_calculate_tax.sql`):** `fn_calculate_tax(p_annual_salary)` computes progressive tiered income tax (10%, 20%, 30%).
- **B4 — Department Name (`02_functions/B4_fn_dept_name.sql`):** `fn_dept_name(p_department_id)` returns department title or `'UNKNOWN DEPARTMENT'`.
- **B5 — Functions in SQL (`03_tests/B5_functions_in_select.sql`):** Executes all stored functions in a consolidated SQL `SELECT` query against the `employees` table.

### Part C — Combined Task & Reflection
- **C1 — Payroll Validator (`02_functions/C1_fn_validate_payroll.sql`):** `fn_validate_payroll(p_employee_id, p_gross_salary, p_tax_amount)` validates foreign key existence, positive gross salary, valid tax deduction, and boundary integrity.
- **C2 — Reflection (`docs/REFLECTION.md`):** Deep academic reflection on PL/SQL control flow, compiler rules, modular architecture, and test validation.

---

##  How to Run in Oracle SQL Developer

### Environment Details
- **IDE:** Oracle SQL Developer (Version 26.2.0.186.2220)
- **Connection User:** `ARNOLD_PLSQLAUCA_20252IMA134`
- **Database Service:** `AR_PDB_20252IMA134` (Port 1521, localhost)

### Step-by-Step Execution Order

1. **Step 1: Database Setup**  
   Open `00_setup/create_tables.sql` in SQL Developer worksheet and press **F5** (Run Script).  
   *Result:* Creates `departments`, `employees`, and `payroll` tables and populates sample rows.

2. **Step 2: Compile Stored Functions**  
   Open and execute each function script (press **F5** or **F9**):
   - `02_functions/B1_fn_annual_salary.sql`
   - `02_functions/B2_fn_years_of_service.sql`
   - `02_functions/B3_fn_calculate_tax.sql`
   - `02_functions/B4_fn_dept_name.sql`
   - `02_functions/C1_fn_validate_payroll.sql`  
   *Result:* Each script reports `Function created.`

3. **Step 3: Run GOTO Programs**  
   Execute in worksheet (press **F5**):
   - `01_goto/A1_number_classifier.sql`
   - `01_goto/A2_salary_review.sql`
   - `01_goto/A3_illegal_goto.sql`
   - `01_goto/A4_rewrite_no_goto.sql`

4. **Step 4: Execute Test Suites**  
   Execute in worksheet:
   - `03_tests/B5_functions_in_select.sql` (press **F9** to view query grid result)
   - `03_tests/test_functions.sql` (press **F5** to view DBMS_OUTPUT)
   - `03_tests/test_validate_payroll.sql` (press **F5** to view DBMS_OUTPUT)

---

##  Screenshots & Verification

All screenshots are stored in the `screenshots/` directory:

| Filename | Description | Status |
|:---|:---|:---|
| `screenshots/A1_output.png` | Number Classifier output with positive, negative, and zero values | Verified |
| `screenshots/A2_output.png` | Salary Review output using `GOTO` across salary brackets | Verified |
| `screenshots/A3_error_and_fix.png` | Illegal GOTO compiler error (`PLS-00375`) and the legal fix execution | Verified |
| `screenshots/A4_output.png` | Structured salary review output without `GOTO` | Verified |
| `screenshots/B5_select_output.png` | SQL `SELECT` statement calling all stored functions in query grid | Verified |
| `screenshots/C1_output.png` | Payroll validator test results for all valid and invalid scenarios | Verified |

---

##  Academic Integrity & AI Disclosure

This is an individual assignment for course **INSY 8311**.
- **AI Tool Assistance:** Generative AI was used to assist in organizing repository templates, formatting markdown documentation, and validating syntax consistency.
- **Individual Understanding:** All database objects, PL/SQL blocks, and functions were compiled and tested within Oracle AI Database 26ai and Oracle SQL Developer. I understand the underlying mechanics of all code and am prepared for next week's in-class quiz.
