-- Insert a new record into the loans table
-- If it succeeds, return 1 otherwise return -1

CREATE OR REPLACE PROCEDURE spLoansInsert(
    p_loanID IN loans.LOANID%TYPE,
    p_accountNumber IN loans.ACCOUNTNUMBER%TYPE,
    p_loanSpecialist IN loans.LOANSPECIALIST%TYPE,
    p_balance IN loans.BALANCE%TYPE,
    p_loanType IN loans.LOANTYPE%TYPE,
    p_interestRate IN loans.INTERESTRATE%TYPE,
    p_approvalDate IN loans.APPROVALDATE%TYPE,
    p_durationMonths IN loans.DURATIONMONTHS%TYPE,
    p_status IN loans.STATUS%TYPE,
    p_employeeComment IN loans.EMPLOYEECOMMENT%TYPE,
    p_result OUT INT) AS

BEGIN   
    INSERT INTO loans (
        LOANID, 
        ACCOUNTNUMBER, 
        LOANSPECIALIST, 
        BALANCE, 
        LOANTYPE, 
        INTERESTRATE, 
        APPROVALDATE, 
        DURATIONMONTHS, 
        STATUS, 
        EMPLOYEECOMMENT)
        
        VALUES (
        p_loanID, 
        p_accountNumber, 
        p_loanSpecialist, 
        p_balance, 
        p_loanType, 
        p_interestRate, 
        p_approvalDate, 
        p_durationMonths, 
        p_status, 
        p_employeeComment);   
    p_result := 1;
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        p_result := -1; 
    WHEN OTHERS THEN        
        p_result := SQLCODE; 
END spLoansInsert;
/

SET SERVEROUTPUT ON;
DECLARE
    result INT;
BEGIN
    spLoansInsert(
        6021,                    -- p_loanID
        5001,                    -- p_accountNumber
        2001,                    -- p_loanSpecialist
        10000.00,                -- p_balance
        'Personal Loan',         -- p_loanType
        3.75,                    -- p_interestRate
        TO_DATE('2023-11-23', 'YYYY-MM-DD'),                 -- p_approvalDate
        60,                      -- p_durationMonths
        'Active',                -- p_status
        'Approved after review', -- p_employeeComment
        result           -- parameter to see result
    ); 
    DBMS_OUTPUT.PUT_LINE ('Result: ' || result);
END;
/


-- Update a record in the loans table
-- If it succeeds, return 1 otherwise return -1
CREATE OR REPLACE PROCEDURE spLoansUpdate(
    p_loanID IN loans.LOANID%TYPE,
    p_accountNumber IN loans.ACCOUNTNUMBER%TYPE,
    p_loanSpecialist IN loans.LOANSPECIALIST%TYPE,
    p_balance IN loans.BALANCE%TYPE,
    p_loanType IN loans.LOANTYPE%TYPE,
    p_interestRate IN loans.INTERESTRATE%TYPE,
    p_approvalDate IN loans.APPROVALDATE%TYPE,
    p_durationMonths IN loans.DURATIONMONTHS%TYPE,
    p_status IN loans.STATUS%TYPE,
    p_employeeComment IN loans.EMPLOYEECOMMENT%TYPE,
    p_result OUT INT) AS

BEGIN
    UPDATE loans
    SET 
        accountNumber = p_accountNumber,
        loanSpecialist = p_loanSpecialist,
        balance = p_balance,
        loanType = p_loanType,
        interestRate = p_interestRate,
        approvalDate = p_approvalDate,
        durationMonths = p_durationMonths,
        status = p_status,
        employeeComment = p_employeeComment
    WHERE loanID = p_loanID;
    
    IF SQL%ROWCOUNT > 0 THEN
        p_result := 1;
        COMMIT;
    ELSE
        p_result := -1; 
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        p_result := SQLCODE; 
END spLoansUpdate;
/

DECLARE
    result INT;
BEGIN
    spLoansUpdate(
        6021,              -- p_loanID 
        5001,              -- p_accountNumber 
        2001,              -- p_loanSpecialist 
        10000.00,          -- p_balance
        'Personal Loan',   -- p_loanType
        5.00,              -- p_interestRate (Changed)
        SYSDATE,           -- p_approvalDate
        48,                -- p_durationMonths (Changed)
        'Active',          -- p_status
        'New application', -- p_employeeComment (Changed)
        result             -- parameter to see result
    ); 
    DBMS_OUTPUT.PUT_LINE ('Result: ' || result);
END;
/

SELECT * FROM loans WHERE loanID = 6021;


-- Select and return a record from the loans table
-- If it succeeds, return 1 otherwise return -1

create or replace PROCEDURE spLoansSelect(
    p_loanID IN loans.LOANID%TYPE,
    p_cursor OUT SYS_REFCURSOR) AS
BEGIN
    OPEN p_cursor FOR
        SELECT accountNumber, loanSpecialist, balance, loanType,
               interestRate, TO_CHAR(approvalDate, 'DD-MON-YYYY') as approvalDate, 
               durationMonths, status, employeeComment
        FROM loans
        WHERE loanID = p_loanID;
END spLoansSelect;


SET SERVEROUTPUT ON;
DECLARE
    result INT;
BEGIN
    spLoansSelect(6021, result);
    DBMS_OUTPUT.PUT_LINE ('Result: ' || result);
END;
/


-- Delete a record from the loans table
-- If it succeeds, return 1 otherwise return -1

CREATE OR REPLACE PROCEDURE spLoansDelete(
    p_loanID IN loans.loanID%TYPE,
    p_result OUT INT) AS
BEGIN
    DELETE FROM loans WHERE loanID = p_loanID;
    
    IF SQL%ROWCOUNT > 0 THEN
        p_result := 1;
        COMMIT;
    ELSE
        p_result := -1;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        p_result := SQLCODE;
        ROLLBACK;
END spLoansDelete;
/


SET SERVEROUTPUT ON;
DECLARE
    result INT;
BEGIN
    spLoansDelete(6021, result);
    DBMS_OUTPUT.PUT_LINE('Result: ' || result);
END;
/

