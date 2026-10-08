-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Task: Part A - GOTO: A1 - Number Classifier
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 01_goto/A1_number_classifier.sql
-- ============================================================================

SET SERVEROUTPUT ON;

DECLARE
    TYPE t_numbers IS VARRAY(5) OF NUMBER;
    v_test_list t_numbers := t_numbers(-15, 0, 42, -3, 100);
    v_num       NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Part A1: Number Classifier using PL/SQL GOTO');
    DBMS_OUTPUT.PUT_LINE('Student: MUSAFIRI Arnold | ID: 20252IMA134');
    DBMS_OUTPUT.PUT_LINE('====================================================');

    FOR i IN 1..v_test_list.COUNT LOOP
        v_num := v_test_list(i);

        IF v_num > 0 THEN
            GOTO positive_number;
        ELSIF v_num < 0 THEN
            GOTO negative_number;
        ELSE
            GOTO zero_number;
        END IF;

        <<positive_number>>
        DBMS_OUTPUT.PUT_LINE('Item ' || i || ': Number ' || LPAD(v_num, 4) || ' is POSITIVE.');
        GOTO next_iteration;

        <<negative_number>>
        DBMS_OUTPUT.PUT_LINE('Item ' || i || ': Number ' || LPAD(v_num, 4) || ' is NEGATIVE.');
        GOTO next_iteration;

        <<zero_number>>
        DBMS_OUTPUT.PUT_LINE('Item ' || i || ': Number ' || LPAD(v_num, 4) || ' is ZERO.');
        GOTO next_iteration;

        <<next_iteration>>
        NULL; -- Continue loop iteration
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('A1 Execution Complete - All numbers classified.');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
