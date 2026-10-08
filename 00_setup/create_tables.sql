-- ============================================================================
-- Course: Database Development with PL/SQL (INSY 8311)
-- Instructor: Eric Maniraguha | eric.maniraguha@auca.ac.rw
-- Student: MUSAFIRI Arnold
-- Student ID: 20252IMA134
-- Assignment: Individual Assignment III: PL/SQL GOTO Statements and Functions
-- Tool: Oracle SQL Developer (Version 26.2.0.186.2220)
-- File: 00_setup/create_tables.sql
-- ============================================================================

SET SERVEROUTPUT ON;

-- Safely drop existing tables if they already exist
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE payroll CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

-- 1. Departments Table
CREATE TABLE departments (
    department_id   NUMBER(4) CONSTRAINT pk_departments PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL CONSTRAINT uq_department_name UNIQUE
);

-- 2. Employees Table
CREATE TABLE employees (
    employee_id     NUMBER(6) CONSTRAINT pk_employees PRIMARY KEY,
    first_name      VARCHAR2(50) NOT NULL,
    last_name       VARCHAR2(50) NOT NULL,
    department_id   NUMBER(4) NOT NULL,
    monthly_salary  NUMBER(12,2) NOT NULL CONSTRAINT ck_employee_salary CHECK (monthly_salary > 0),
    hire_date       DATE NOT NULL,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 3. Payroll Table
CREATE TABLE payroll (
    payroll_id      NUMBER(8) CONSTRAINT pk_payroll PRIMARY KEY,
    employee_id     NUMBER(6) NOT NULL,
    pay_period      DATE NOT NULL,
    gross_salary    NUMBER(12,2) NOT NULL CONSTRAINT ck_payroll_gross CHECK (gross_salary > 0),
    tax_amount      NUMBER(12,2) NOT NULL CONSTRAINT ck_payroll_tax CHECK (tax_amount >= 0),
    net_salary      NUMBER(12,2) GENERATED ALWAYS AS (gross_salary - tax_amount) VIRTUAL,
    CONSTRAINT fk_payroll_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT ck_payroll_tax_not_greater CHECK (tax_amount <= gross_salary)
);

-- Seed Data: Departments
INSERT INTO departments (department_id, department_name) VALUES (10, 'Human Resources');
INSERT INTO departments (department_id, department_name) VALUES (20, 'Information Technology');
INSERT INTO departments (department_id, department_name) VALUES (30, 'Finance');
INSERT INTO departments (department_id, department_name) VALUES (40, 'Operations');

-- Seed Data: Employees
INSERT INTO employees (employee_id, first_name, last_name, department_id, monthly_salary, hire_date)
VALUES (1001, 'Aline', 'Mukamana', 10, 450000, DATE '2023-02-15');

INSERT INTO employees (employee_id, first_name, last_name, department_id, monthly_salary, hire_date)
VALUES (1002, 'Eric', 'Niyonsenga', 20, 700000, DATE '2021-08-01');

INSERT INTO employees (employee_id, first_name, last_name, department_id, monthly_salary, hire_date)
VALUES (1003, 'Kevin', 'Ishimwe', 30, 950000, DATE '2019-05-20');

INSERT INTO employees (employee_id, first_name, last_name, department_id, monthly_salary, hire_date)
VALUES (1004, 'Grace', 'Uwase', 40, 1250000, DATE '2024-01-10');

INSERT INTO employees (employee_id, first_name, last_name, department_id, monthly_salary, hire_date)
VALUES (1005, 'Samuel', 'Habimana', 20, 600000, DATE '2022-11-05');

-- Seed Data: Payroll Records
INSERT INTO payroll (payroll_id, employee_id, pay_period, gross_salary, tax_amount)
VALUES (5001, 1001, DATE '2026-09-30', 450000, 45000);

INSERT INTO payroll (payroll_id, employee_id, pay_period, gross_salary, tax_amount)
VALUES (5002, 1002, DATE '2026-09-30', 700000, 140000);

INSERT INTO payroll (payroll_id, employee_id, pay_period, gross_salary, tax_amount)
VALUES (5003, 1003, DATE '2026-09-30', 950000, 190000);

INSERT INTO payroll (payroll_id, employee_id, pay_period, gross_salary, tax_amount)
VALUES (5004, 1004, DATE '2026-09-30', 1250000, 375000);

INSERT INTO payroll (payroll_id, employee_id, pay_period, gross_salary, tax_amount)
VALUES (5005, 1005, DATE '2026-09-30', 600000, 120000);

COMMIT;

BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Setup complete: departments, employees, and payroll created.');
    DBMS_OUTPUT.PUT_LINE('Student: MUSAFIRI Arnold | ID: 20252IMA134');
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/
