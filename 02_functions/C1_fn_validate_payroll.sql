-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part C - Combined Task: C1 - Payroll Validator
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 02_functions/C1_fn_validate_payroll.sql
-- ============================================================================

-- Function: fn_validate_payroll
-- Description: Validates payroll integrity combining employee verification,
--              business rules, and defensive exception handling.
-- Validation Rules:
--   1. Employee must exist in the employees table
--   2. Gross salary must be non-null and strictly greater than zero
--   3. Tax amount must be non-null and non-negative (>= 0)
--   4. Tax amount cannot exceed gross salary
-- Parameters:
--   p_employee_id  (NUMBER)
--   p_gross_salary (NUMBER)
--   p_tax_amount   (NUMBER)
-- Returns:
--   VARCHAR2 ('VALID' or descriptive 'INVALID: ...' failure reason)

CREATE OR REPLACE FUNCTION fn_validate_payroll (
    p_employee_id  IN NUMBER,
    p_gross_salary IN NUMBER,
    p_tax_amount   IN NUMBER
) RETURN VARCHAR2
IS
    v_employee_count NUMBER := 0;
BEGIN
    -- 1. Check employee existence
    SELECT COUNT(*)
      INTO v_employee_count
      FROM employees
     WHERE employee_id = p_employee_id;

    IF v_employee_count = 0 THEN
        RETURN 'INVALID: employee does not exist';
    ELSIF p_gross_salary IS NULL OR p_gross_salary <= 0 THEN
        RETURN 'INVALID: gross salary must be greater than 0';
    ELSIF p_tax_amount IS NULL OR p_tax_amount < 0 THEN
        RETURN 'INVALID: tax amount cannot be negative';
    ELSIF p_tax_amount > p_gross_salary THEN
        RETURN 'INVALID: tax amount cannot exceed gross salary';
    ELSE
        RETURN 'VALID';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'INVALID: unexpected validation error';
END fn_validate_payroll;
/
SHOW ERRORS;
