-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part B - Functions: B3 - Tax Calculator
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 02_functions/B3_fn_calculate_tax.sql
-- ============================================================================

-- Function: fn_calculate_tax
-- Description: Computes tax liability based on standard progressive compensation bands:
--   - Annual Salary <= 500,000 RWF       -> 10%
--   - Annual Salary 500,001 - 1,000,000  -> 20%
--   - Annual Salary > 1,000,000 RWF      -> 30%
-- Parameters:  p_annual_salary (NUMBER)
-- Returns:     NUMBER (Rounded calculated tax liability)

CREATE OR REPLACE FUNCTION fn_calculate_tax (
    p_annual_salary IN NUMBER
) RETURN NUMBER
IS
    v_tax NUMBER := 0;
BEGIN
    IF p_annual_salary IS NULL OR p_annual_salary <= 0 THEN
        RETURN 0;
    ELSIF p_annual_salary <= 500000 THEN
        v_tax := p_annual_salary * 0.10;
    ELSIF p_annual_salary <= 1000000 THEN
        v_tax := p_annual_salary * 0.20;
    ELSE
        v_tax := p_annual_salary * 0.30;
    END IF;

    RETURN ROUND(v_tax, 2);
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END fn_calculate_tax;
/
SHOW ERRORS;
