# 🛠️ Oracle SQL Developer Step-by-Step Execution Guide

**Course:** Database Development with PL/SQL (INSY 8311)  
**Instructor:** Eric Maniraguha | `eric.maniraguha@auca.ac.rw`  
**Student Name:** MUSAFIRI Arnold  
**Student ID:** 20252IMA134  
**Tool:** Oracle SQL Developer (Version 26.2.0.186.2220)  
**Database:** Oracle AI Database 26ai (`AR_PDB_20252IMA134`)  

---

## 📌 1. Database Connection Setup

To connect to your pluggable database in Oracle SQL Developer:

1. Launch **Oracle SQL Developer (Version 26.2.0.186.2220)**.
2. In the **Connections** panel on the left, click the green **`+`** icon (New Connection).
3. Enter the following parameters:

| Configuration Property | Value |
|:---|:---|
| **Connection Name** | `arnold_plsqlauca_20252IMA134` |
| **Username** | `arnold_plsqlauca_20252IMA134` |
| **Password** | `Arnold2026#` (or your configured password) |
| **Connection Type** | Basic |
| **Role** | default |
| **Hostname** | `localhost` |
| **Port** | `1521` |
| **Service Name** | `AR_PDB_20252IMA134` |

4. Click **Test** (should indicate **Status: Success**), then click **Save** and **Connect**.

---

## 🖥️ 2. Enable DBMS_OUTPUT Panel

Because PL/SQL scripts use `DBMS_OUTPUT.PUT_LINE` to display output:
1. Go to the top menu: **View** -> **DBMS Output**.
2. In the **DBMS Output** pane that appears at the bottom:
   - Click the green **`+`** icon to attach your connection (`arnold_plsqlauca_20252IMA134`).
   - Set the buffer size to unlimited (or default `20000`).

---

## 🚀 3. Execution Order

Run the files in the following strict sequential order:

### Step 1: Database Setup
- Open `00_setup/create_tables.sql` in SQL Developer.
- Press **F5** (Run Script).
- Verify tables `departments`, `employees`, and `payroll` are created and populated.

### Step 2: Compile Stored Functions
Open each file and press **F5** or **F9**:
- `02_functions/B1_fn_annual_salary.sql`
- `02_functions/B2_fn_years_of_service.sql`
- `02_functions/B3_fn_calculate_tax.sql`
- `02_functions/B4_fn_dept_name.sql`
- `02_functions/C1_fn_validate_payroll.sql`  
*Verify in the compiler log: `Function created.`*

### Step 3: Run GOTO Programs
- `01_goto/A1_number_classifier.sql` -> Press **F5** (observe output in Script Output / DBMS Output)
- `01_goto/A2_salary_review.sql` -> Press **F5**
- `01_goto/A3_illegal_goto.sql` -> Press **F5**
- `01_goto/A4_rewrite_no_goto.sql` -> Press **F5**

### Step 4: Run Tests
- `03_tests/B5_functions_in_select.sql` -> Press **F9** (Run Statement to view grid with 5 calculated columns)
- `03_tests/test_functions.sql` -> Press **F5**
- `03_tests/test_validate_payroll.sql` -> Press **F5**

---

## 📸 4. Screenshot Checklist

Capture and verify that each required image exists in `screenshots/`:

1. `A1_output.png`: Number classifier output for positive, negative, and zero.
2. `A2_output.png`: Salary review output across tiers using GOTO.
3. `A3_error_and_fix.png`: The illegal GOTO error explanation/message and the legal fixed execution.
4. `A4_output.png`: Structured salary review output without GOTO.
5. `B5_select_output.png`: SQL Developer query grid for the `SELECT` query calling the 4 stored functions.
6. `C1_output.png`: Unit test results of `fn_validate_payroll` verifying valid and invalid cases.
