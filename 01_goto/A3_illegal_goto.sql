-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part A - GOTO: A3 - Illegal GOTO and Fix
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 01_goto/A3_illegal_goto.sql
-- ============================================================================

-- PL/SQL GOTO RESTRICTION RULES:
-- 1. A GOTO statement CANNOT branch into an IF statement, CASE statement,
--    LOOP, or child sub-block from the outside.
-- 2. Attempting to branch into an IF statement triggers:
--    ORA-06550 / PLS-00375: illegal GOTO statement; this GOTO cannot branch to label '...'

SET SERVEROUTPUT ON;

-- ----------------------------------------------------------------------------
-- PART 1: DEMONSTRATION OF ILLEGAL GOTO (Uncomment to view PLS-00375 compilation error)
-- ----------------------------------------------------------------------------
/*
DECLARE
    v_status VARCHAR2(20) := 'PENDING';
BEGIN
    -- ILLEGAL: Branching into an IF statement body from outside!
    GOTO inside_if_block;

    IF v_status = 'PENDING' THEN
        <<inside_if_block>>
        DBMS_OUTPUT.PUT_LINE('Inside IF block: This jump is forbidden in PL/SQL.');
    END IF;
END;
/
-- Compilation Output from Oracle:
-- Error report -
-- ORA-06550: line 5, column 5:
-- PLS-00375: illegal GOTO statement; this GOTO cannot branch to label 'INSIDE_IF_BLOCK'
-- ORA-06550: line 8, column 9:
-- PL/SQL: Statement ignored
*/

-- ----------------------------------------------------------------------------
-- PART 2: THE LEGAL FIX
-- Branching only to labels in the enclosing scope or structured control flow.
-- ----------------------------------------------------------------------------
DECLARE
    v_salary        NUMBER := 750000;
    v_bonus_rate    NUMBER := 0;
    v_review_status VARCHAR2(50);
BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Part A3: Illegal GOTO and Fix Demonstration');
    DBMS_OUTPUT.PUT_LINE('Student: MUSAFIRI Arnold | ID: 20252IMA134');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Explanation: PL/SQL restricts GOTO branching into nested');
    DBMS_OUTPUT.PUT_LINE('structures (IF/LOOP blocks). The fix keeps branch labels');
    DBMS_OUTPUT.PUT_LINE('in the legal outer scope.');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    IF v_salary > 500000 THEN
        v_bonus_rate := 0.15;
        GOTO calculate_payout;
    ELSE
        v_bonus_rate := 0.05;
        GOTO calculate_payout;
    END IF;

    -- Unreachable code bypassed by branch
    DBMS_OUTPUT.PUT_LINE('This line is skipped.');

    <<calculate_payout>>
    v_review_status := 'Approved standard executive bonus.';
    DBMS_OUTPUT.PUT_LINE('Base Salary    : ' || TO_CHAR(v_salary, 'FM999,999,999') || ' RWF');
    DBMS_OUTPUT.PUT_LINE('Bonus Rate     : ' || (v_bonus_rate * 100) || '%');
    DBMS_OUTPUT.PUT_LINE('Total Bonus    : ' || TO_CHAR(v_salary * v_bonus_rate, 'FM999,999,999') || ' RWF');
    DBMS_OUTPUT.PUT_LINE('Review Status  : ' || v_review_status);
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('A3 Fix executed successfully within legal PL/SQL rules.');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
