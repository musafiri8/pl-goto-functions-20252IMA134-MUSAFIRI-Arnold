-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part C - Combined Task: Test Suite for Payroll Validator (C1)
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 03_tests/test_validate_payroll.sql
-- ============================================================================

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Test Suite: C1 Payroll Validator Function');
    DBMS_OUTPUT.PUT_LINE('Student: MUSAFIRI Arnold | ID: 20252IMA134');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    -- Case 1: Standard valid case (Employee 1002, Gross 700,000, Tax 140,000)
    DBMS_OUTPUT.PUT_LINE('[Case 1: Standard Valid]');
    DBMS_OUTPUT.PUT_LINE('  Input:  Emp 1002, Gross 700,000, Tax 140,000');
    DBMS_OUTPUT.PUT_LINE('  Result: ' || fn_validate_payroll(1002, 700000, 140000));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- Case 2: Non-existent employee (Employee 9999)
    DBMS_OUTPUT.PUT_LINE('[Case 2: Missing Employee]');
    DBMS_OUTPUT.PUT_LINE('  Input:  Emp 9999, Gross 700,000, Tax 140,000');
    DBMS_OUTPUT.PUT_LINE('  Result: ' || fn_validate_payroll(9999, 700000, 140000));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- Case 3: Invalid gross salary (Zero or Negative)
    DBMS_OUTPUT.PUT_LINE('[Case 3: Zero or Negative Gross Salary]');
    DBMS_OUTPUT.PUT_LINE('  Input:  Emp 1002, Gross 0, Tax 0');
    DBMS_OUTPUT.PUT_LINE('  Result: ' || fn_validate_payroll(1002, 0, 0));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- Case 4: Negative tax amount
    DBMS_OUTPUT.PUT_LINE('[Case 4: Negative Tax Amount]');
    DBMS_OUTPUT.PUT_LINE('  Input:  Emp 1002, Gross 700,000, Tax -5000');
    DBMS_OUTPUT.PUT_LINE('  Result: ' || fn_validate_payroll(1002, 700000, -5000));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    -- Case 5: Tax amount greater than gross salary
    DBMS_OUTPUT.PUT_LINE('[Case 5: Tax Exceeds Gross Salary]');
    DBMS_OUTPUT.PUT_LINE('  Input:  Emp 1002, Gross 700,000, Tax 850,000');
    DBMS_OUTPUT.PUT_LINE('  Result: ' || fn_validate_payroll(1002, 700000, 850000));
    DBMS_OUTPUT.PUT_LINE('====================================================');

    DBMS_OUTPUT.PUT_LINE('All C1 Validation Test Scenarios executed successfully.');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
