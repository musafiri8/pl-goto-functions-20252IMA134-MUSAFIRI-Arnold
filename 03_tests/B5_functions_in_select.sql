-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part B - Functions: B5 - Functions in SQL
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 03_tests/B5_functions_in_select.sql
-- ============================================================================

-- This query demonstrates calling stored PL/SQL functions directly from a SQL SELECT:
--   - fn_annual_salary()
--   - fn_years_of_service()
--   - fn_dept_name()
--   - fn_calculate_tax()

SET LINESIZE 220
SET PAGESIZE 50
COLUMN employee_id HEADING "Emp ID" FORMAT 9999
COLUMN employee_name HEADING "Employee Name" FORMAT A22
COLUMN monthly_salary HEADING "Monthly (RWF)" FORMAT 999,999,999
COLUMN annual_salary HEADING "Annual (RWF)" FORMAT 99,999,999
COLUMN years_of_service HEADING "Tenure (Yrs)" FORMAT 999
COLUMN department_name HEADING "Department" FORMAT A24
COLUMN estimated_tax HEADING "Annual Tax (RWF)" FORMAT 99,999,999

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.monthly_salary,
    fn_annual_salary(e.employee_id) AS annual_salary,
    fn_years_of_service(e.employee_id) AS years_of_service,
    fn_dept_name(e.department_id) AS department_name,
    fn_calculate_tax(fn_annual_salary(e.employee_id)) AS estimated_tax
FROM employees e
ORDER BY e.employee_id;
