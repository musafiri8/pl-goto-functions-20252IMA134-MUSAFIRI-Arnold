-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part A - GOTO: A2 - Salary Review
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 01_goto/A2_salary_review.sql
-- ============================================================================

-- Threshold Assumptions:
--   < 500,000 RWF              -> LOW (review recommended)
--   500,000 - 1,000,000 RWF    -> STANDARD (no special review)
--   > 1,000,000 RWF            -> HIGH (review for senior-level compensation)

SET SERVEROUTPUT ON;

DECLARE
    CURSOR cur_emp IS
        SELECT employee_id, first_name || ' ' || last_name AS emp_name, monthly_salary
        FROM employees
        ORDER BY employee_id;

    v_salary NUMBER;
    v_status VARCHAR2(20);
    v_action VARCHAR2(60);
BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Part A2: Salary Review using PL/SQL GOTO');
    DBMS_OUTPUT.PUT_LINE('Student: MUSAFIRI Arnold | ID: 20252IMA134');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    FOR rec IN cur_emp LOOP
        v_salary := rec.monthly_salary;

        IF v_salary < 500000 THEN
            GOTO low_salary;
        ELSIF v_salary <= 1000000 THEN
            GOTO standard_salary;
        ELSE
            GOTO high_salary;
        END IF;

        <<low_salary>>
        v_status := 'LOW';
        v_action := 'Salary review recommended (entry/under market)';
        GOTO print_result;

        <<standard_salary>>
        v_status := 'STANDARD';
        v_action := 'Standard competitive band (no special action)';
        GOTO print_result;

        <<high_salary>>
        v_status := 'HIGH';
        v_action := 'Senior executive / high-tier compensation band';
        GOTO print_result;

        <<print_result>>
        DBMS_OUTPUT.PUT_LINE(
            'Emp #' || rec.employee_id || ' (' || RPAD(rec.emp_name, 18) || ') | ' ||
            'Salary: ' || LPAD(TO_CHAR(v_salary, 'FM999,999,999'), 10) || ' RWF | ' ||
            'Tier: ' || RPAD(v_status, 9) || ' | Action: ' || v_action
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('A2 Execution Complete - All employee salaries reviewed.');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
