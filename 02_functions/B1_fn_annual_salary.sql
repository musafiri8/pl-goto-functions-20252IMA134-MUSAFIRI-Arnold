-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part B - Functions: B1 - Annual Salary
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 02_functions/B1_fn_annual_salary.sql
-- ============================================================================

-- Function: fn_annual_salary
-- Description: Computes an employee's annual compensation (monthly_salary * 12).
-- Parameters:  p_employee_id (NUMBER)
-- Returns:     NUMBER (Annual Salary or NULL if employee not found)

CREATE OR REPLACE FUNCTION fn_annual_salary (
    p_employee_id IN employees.employee_id%TYPE
) RETURN NUMBER
IS
    v_annual_salary NUMBER(12,2);
BEGIN
    SELECT monthly_salary * 12
      INTO v_annual_salary
      FROM employees
     WHERE employee_id = p_employee_id;

    RETURN v_annual_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END fn_annual_salary;
/
SHOW ERRORS;
