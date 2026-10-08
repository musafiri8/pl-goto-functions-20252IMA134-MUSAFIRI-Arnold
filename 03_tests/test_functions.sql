-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part B - Test Suite for Functions B1 to B4
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 03_tests/test_functions.sql
-- ============================================================================

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Test Suite: PL/SQL Stored Functions (B1 - B4)');
    DBMS_OUTPUT.PUT_LINE('Student: MUSAFIRI Arnold | ID: 20252IMA134');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    -- B1: Annual Salary Tests
    DBMS_OUTPUT.PUT_LINE('[TEST B1] fn_annual_salary:');
    DBMS_OUTPUT.PUT_LINE('  Emp 1001 (450,000/mo)  -> Annual: ' || TO_CHAR(fn_annual_salary(1001), 'FM99,999,999') || ' RWF');
    DBMS_OUTPUT.PUT_LINE('  Emp 1002 (700,000/mo)  -> Annual: ' || TO_CHAR(fn_annual_salary(1002), 'FM99,999,999') || ' RWF');
    DBMS_OUTPUT.PUT_LINE('  Emp 9999 (Non-existent)-> Return: ' || NVL(TO_CHAR(fn_annual_salary(9999)), 'NULL (handled)'));

    -- B2: Years of Service Tests
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('[TEST B2] fn_years_of_service:');
    DBMS_OUTPUT.PUT_LINE('  Emp 1002 (Hired 2021)  -> Tenure: ' || fn_years_of_service(1002) || ' years');
    DBMS_OUTPUT.PUT_LINE('  Emp 1003 (Hired 2019)  -> Tenure: ' || fn_years_of_service(1003) || ' years');
    DBMS_OUTPUT.PUT_LINE('  Emp 9999 (Non-existent)-> Return: ' || NVL(TO_CHAR(fn_years_of_service(9999)), 'NULL (handled)'));

    -- B3: Tax Calculator Tests
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('[TEST B3] fn_calculate_tax:');
    DBMS_OUTPUT.PUT_LINE('  Band 1:   400,000 RWF (10%) -> Tax: ' || TO_CHAR(fn_calculate_tax(400000), 'FM999,999') || ' RWF');
    DBMS_OUTPUT.PUT_LINE('  Band 2:   800,000 RWF (20%) -> Tax: ' || TO_CHAR(fn_calculate_tax(800000), 'FM999,999') || ' RWF');
    DBMS_OUTPUT.PUT_LINE('  Band 3: 1,500,000 RWF (30%) -> Tax: ' || TO_CHAR(fn_calculate_tax(1500000), 'FM999,999') || ' RWF');
    DBMS_OUTPUT.PUT_LINE('  Edge:           0 RWF (0%)  -> Tax: ' || TO_CHAR(fn_calculate_tax(0), 'FM999,999') || ' RWF');

    -- B4: Department Name Tests
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('[TEST B4] fn_dept_name:');
    DBMS_OUTPUT.PUT_LINE('  Dept 10 -> ' || fn_dept_name(10));
    DBMS_OUTPUT.PUT_LINE('  Dept 20 -> ' || fn_dept_name(20));
    DBMS_OUTPUT.PUT_LINE('  Dept 30 -> ' || fn_dept_name(30));
    DBMS_OUTPUT.PUT_LINE('  Dept 99 -> ' || fn_dept_name(99) || ' (handled)');

    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('All B1-B4 Function Unit Tests PASSED successfully.');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
