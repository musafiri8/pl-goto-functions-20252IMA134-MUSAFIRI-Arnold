-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part A - GOTO: A4 - Rewrite Without GOTO
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 01_goto/A4_rewrite_no_goto.sql
-- ============================================================================

-- REASON FOR REWRITE:
-- GOTO statements lead to "spaghetti code" that makes execution flow difficult
-- to trace, test, and maintain. Structured programming constructs (IF-ELSIF-ELSE)
-- provide clear single-entry, single-exit execution paths and adhere to PL/SQL best practices.

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
    DBMS_OUTPUT.PUT_LINE('Part A4: Structured Salary Review (WITHOUT GOTO)');
    DBMS_OUTPUT.PUT_LINE('Student: MUSAFIRI Arnold | ID: 20252IMA134');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    FOR rec IN cur_emp LOOP
        v_salary := rec.monthly_salary;

        -- Clean, structured conditional logic without labels or jumps
        IF v_salary < 500000 THEN
            v_status := 'LOW';
            v_action := 'Salary review recommended (entry/under market)';
        ELSIF v_salary <= 1000000 THEN
            v_status := 'STANDARD';
            v_action := 'Standard competitive band (no special action)';
        ELSE
            v_status := 'HIGH';
            v_action := 'Senior executive / high-tier compensation band';
        END IF;

        DBMS_OUTPUT.PUT_LINE(
            'Emp #' || rec.employee_id || ' (' || RPAD(rec.emp_name, 18) || ') | ' ||
            'Salary: ' || LPAD(TO_CHAR(v_salary, 'FM999,999,999'), 10) || ' RWF | ' ||
            'Tier: ' || RPAD(v_status, 9) || ' | Action: ' || v_action
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('A4 Complete: Structured control flow implemented successfully.');
    DBMS_OUTPUT.PUT_LINE('Advantages: Readable, maintainable, single entry-point.');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
