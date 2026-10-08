-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part B - Functions: B4 - Department Name
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 02_functions/B4_fn_dept_name.sql
-- ============================================================================

-- Function: fn_dept_name
-- Description: Looks up department name corresponding to a department ID.
--              Includes graceful NO_DATA_FOUND exception handling.
-- Parameters:  p_department_id (NUMBER)
-- Returns:     VARCHAR2 (Department name or 'UNKNOWN DEPARTMENT')

CREATE OR REPLACE FUNCTION fn_dept_name (
    p_department_id IN departments.department_id%TYPE
) RETURN VARCHAR2
IS
    v_department_name departments.department_name%TYPE;
BEGIN
    SELECT department_name
      INTO v_department_name
      FROM departments
     WHERE department_id = p_department_id;

    RETURN v_department_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'UNKNOWN DEPARTMENT';
    WHEN OTHERS THEN
        RETURN 'UNKNOWN DEPARTMENT';
END fn_dept_name;
/
SHOW ERRORS;
