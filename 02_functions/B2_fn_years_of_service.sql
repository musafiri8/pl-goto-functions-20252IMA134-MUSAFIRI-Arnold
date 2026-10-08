-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part B - Functions: B2 - Years of Service
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 02_functions/B2_fn_years_of_service.sql
-- ============================================================================

-- Function: fn_years_of_service
-- Description: Calculates completed full years of tenure between hire_date and SYSDATE.
-- Parameters:  p_employee_id (NUMBER)
-- Returns:     NUMBER (Completed years of service or NULL if employee not found)

CREATE OR REPLACE FUNCTION fn_years_of_service (
    p_employee_id IN employees.employee_id%TYPE
) RETURN NUMBER
IS
    v_hire_date employees.hire_date%TYPE;
BEGIN
    SELECT hire_date
      INTO v_hire_date
      FROM employees
     WHERE employee_id = p_employee_id;

    RETURN FLOOR(MONTHS_BETWEEN(TRUNC(SYSDATE), v_hire_date) / 12);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END fn_years_of_service;
/
SHOW ERRORS;
