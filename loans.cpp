/*******************************************************************************
DBS 311 Project
Assignment 2 - Part 2

Group - 10
Section: NBB
Date : November 25, 2023

Serge Safronov
SSafronov@myseneca.ca
ID: 132736224
*******************************************************************************/

#include "loans.h"

using namespace std;


void queryLoans(Statement* stmt) {

    string loanID;
    cout << "Enter Loan ID: ";
    cin >> loanID;

    ResultSet* rsss = stmt->executeQuery(
        "SELECT loanID, accountNumber, loanSpecialist, loanType, balance, "
        "interestRate, TO_CHAR(approvalDate, 'DD Mon, YYYY') as approvalDate, "
        "durationMonths, status, employeeComment "
        "FROM loans "
        "WHERE loanID =" + loanID);

    bool hasData = false;
    bool printHeader = false;

    while (rsss->next()) {
        hasData = true;

        if (!printHeader) {
            cout << endl << "Loan " << loanID << " details:" << endl << endl;
            cout << "+--------+----------------+---------------+----------------+--------------+---------------+-----------------+-----------------+-------------+--------------------------+" << endl;
            cout << "| LoanID | Account Number | Specialist ID |      Loan Type |  Balance CAD | Interest Rate |   Approval Date | Duration Months |      Status |       Specialist Comment |" << endl;
            cout << "+--------+----------------+---------------+----------------+--------------+---------------+-----------------+-----------------+-------------+--------------------------+" << endl;
            printHeader = true;
        }

        int loanID = rsss->getInt(1);
        int accountNumber = rsss->getInt(2);
        int loanSpecialist = rsss->getInt(3);
        string loanType = rsss->getString(4);
        double balance = rsss->getDouble(5);
        double interestRate = rsss->getDouble(6);
        string approvalDate = rsss->getString(7);
        int durationMonths = rsss->getInt(8);
        string status = rsss->getString(9);
        string employeeComment = rsss->getString(10);

        cout << "| ";
        cout << setw(6) << right << loanID << " | ";
        cout << setw(14) << right << accountNumber << " | ";
        cout << setw(13) << right << loanSpecialist << " | ";
        cout << setw(14) << right << loanType << " | ";
        cout << setw(12) << right << fixed << setprecision(2) << balance << " | ";
        cout << setw(13) << right << fixed << setprecision(2) << interestRate << " | ";
        cout << setw(15) << right << approvalDate << " | ";
        cout << setw(15) << right << durationMonths << " | ";
        cout << setw(11) << right << status << " | ";
        cout << setw(24) << right << employeeComment << " |" << endl;
        cout << "+--------+----------------+---------------+----------------+--------------+---------------+-----------------+-----------------+-------------+--------------------------+" << endl;
    }
    if (!hasData) {
        cout << endl << "No loans for this ID." << endl;
    }
}

void selectLoan(Statement* stmt) {
    int loanID;
    cout << "Enter Loan ID: ";
    cin >> loanID;

    try {
        stmt->setSQL("BEGIN spLoansSelect(:1, :2); END;");
        stmt->setInt(1, loanID); 
        stmt->registerOutParam(2, Type::OCCICURSOR); 

        stmt->executeUpdate();

        ResultSet* rs = stmt->getCursor(2);

        if (rs->next()) {

            // Extract loan details
            int accountNumber = rs->getInt(1);
            int loanSpecialist = rs->getInt(2);
            double balance = rs->getDouble(3);
            string loanType = rs->getString(4);
            double interestRate = rs->getDouble(5);
            string approvalDate = rs->getString(6);
            int durationMonths = rs->getInt(7);
            string status = rs->getString(8);
            string employeeComment = rs->isNull(9) ? "No comment" : rs->getString(9);

            // Display loan details
            cout << endl;
            cout << "Loan ID: " << loanID << endl;
            cout << "Account Number: " << accountNumber << endl;
            cout << "Loan Specialist: " << loanSpecialist << endl;
            cout << fixed << setprecision(2) << "Balance: " << balance << endl;
            cout << "Loan Type: " << loanType << endl;
            cout << fixed << setprecision(1) << "Interest Rate: " << interestRate << "%" << endl;
            cout << "Approval Date: " << approvalDate << endl;
            cout << "Duration Months: " << durationMonths << endl;
            cout << "Status: " << status << endl;
            cout << "Specialist Comment: " << employeeComment << endl;
        }
        else {
            cout << "No loan found with ID: " << loanID << endl;
        }
    }
    catch (SQLException& error) {
        cout << endl << "Error: " << error.getMessage();
        cout << endl << "Code: " << error.getErrorCode() << endl;
    }
}

void insertLoan(Statement* stmt) {
    int loanID, accountNumber, loanSpecialist, durationMonths;
    double balance, interestRate;
    string loanType, status, employeeComment, approvalDate;

    // Get loan details from user
    cout << "Enter Loan ID: ";
    cin >> loanID;
    cout << "Enter Account Number: ";
    cin >> accountNumber;
    cout << "Enter Loan Specialist ID: ";
    cin >> loanSpecialist;
    cout << "Enter Balance: ";
    cin >> balance;
    cout << "Enter Loan Type: ";
    cin.ignore();
    getline(cin, loanType);
    cout << "Enter Interest Rate: ";
    cin >> interestRate;
    cout << "Enter Approval Date (DD-MON-YYYY): ";
    cin >> approvalDate;
    cout << "Enter Duration Months: ";
    cin >> durationMonths;
    cout << "Enter Status: ";
    cin.ignore();
    getline(cin, status);
    cout << "Enter Employee Comment: ";
    getline(cin, employeeComment);

    stmt->setSQL("BEGIN spLoansInsert(:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11); END;");
    stmt->setInt(1, loanID);
    stmt->setInt(2, accountNumber);
    stmt->setInt(3, loanSpecialist);
    stmt->setDouble(4, balance);
    stmt->setString(5, loanType);
    stmt->setDouble(6, interestRate);
    stmt->setString(7, approvalDate);
    stmt->setInt(8, durationMonths);
    stmt->setString(9, status);
    stmt->setString(10, employeeComment);

    int result;
    stmt->registerOutParam(11, OCCIINT, sizeof(result));

    try {
        stmt->executeUpdate();
        result = stmt->getInt(11);
        cout << "Result: " << result << endl;
        if (result == 1) {
            cout << "Loan inserted successfully." << endl;
        }
        else if (result == -1) {
            cout << "Error: Duplicate value." << endl;
        }
        else {
            cout << "Error: " << result << endl;
        }
    }
    catch (SQLException& error) {
        cout << endl << "Error: " << error.getMessage();
        cout << endl << "Code: " << error.getErrorCode() << endl;
    }
}

void updateLoan(Statement* stmt) {
    int loanID, accountNumber, loanSpecialist, durationMonths;
    double balance, interestRate;
    string loanType, status, employeeComment, approvalDate;
    int result;

    // Input loan details
    cout << "Enter Loan ID: ";
    cin >> loanID;
    cout << "Enter Account Number: ";
    cin >> accountNumber;
    cout << "Enter Loan Specialist ID: ";
    cin >> loanSpecialist;
    cout << "Enter Balance: ";
    cin >> balance;
    cout << "Enter Loan Type: ";
    cin.ignore();
    getline(cin, loanType);
    cout << "Enter Interest Rate: ";
    cin >> interestRate;
    cout << "Enter Approval Date (DD-MON-YYYY): ";
    cin.ignore();
    getline(cin, approvalDate);
    cout << "Enter Duration Months: ";
    cin >> durationMonths;
    cout << "Enter Status: ";
    cin.ignore();
    getline(cin, status);
    cout << "Enter Employee Comment: ";
    getline(cin, employeeComment);

    try {
        stmt->setSQL("BEGIN spLoansUpdate(:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11); END;");
        stmt->setInt(1, loanID);
        stmt->setInt(2, accountNumber);
        stmt->setInt(3, loanSpecialist);
        stmt->setDouble(4, balance);
        stmt->setString(5, loanType);
        stmt->setDouble(6, interestRate);
        stmt->setString(7, approvalDate);
        stmt->setInt(8, durationMonths);
        stmt->setString(9, status);
        stmt->setString(10, employeeComment);
        stmt->registerOutParam(11, OCCIINT, sizeof(result));
        stmt->executeUpdate();

        result = stmt->getInt(11);
        if (result == 1) {
            cout << "Loan updated successfully." << endl;
        }
        else {
            cout << "Loan update failed. Loan ID may not exist." << endl;
        }
    }
    catch (SQLException& error) {
        cout << "Error: " << error.getMessage() << endl;
        cout << "Code: " << error.getErrorCode() << endl;
    }
}

void deleteLoan(Statement* stmt) {
    int loanID;
    int result;

    cout << "Enter Loan ID to delete: ";
    cin >> loanID;

    try {
        stmt->setSQL("BEGIN spLoansDelete(:1, :2); END;");
        stmt->setInt(1, loanID);
        stmt->registerOutParam(2, OCCIINT, sizeof(result));
        stmt->executeUpdate();

        result = stmt->getInt(2);
        if (result == 1) {
            cout << "Loan with ID " << loanID << " was successfully deleted." << endl;
        }
        else if (result == -1) {
            cout << "No loan found with ID " << loanID << ". Deletion failed." << endl;
        }
        else {
            cout << "Error: " << result << endl;
        }
    }
    catch (SQLException& error) {
        cout << "Error: " << error.getMessage() << endl;
        cout << "Code: " << error.getErrorCode() << endl;
    }
}


void manageLoans(Statement* stmt) {
    
    int choice;
    
    do {
        cout << "\nChoose an operation for Loans Table:" << endl;
        cout << "1. Select loan (using query)" << endl;
        cout << "2. Select loan (using stoared prosedure)" << endl;
        cout << "3. Add a new loan" << endl;
        cout << "4. Update existing loan" << endl;
        cout << "5. Delete loan" << endl;
        cout << "0. Exit" << endl;
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
            case 1:
                queryLoans(stmt);
                break;
            case 2:
                selectLoan(stmt);
                break;
            case 3:
                insertLoan(stmt);
                break;
            case 4:
                updateLoan(stmt);
                break;
            case 5:
                deleteLoan(stmt);
                break;            
            case 0:
                break;
            default:
                cout << "Invalid choice, try again." << endl;
        }
    } while (choice != 0);
}
