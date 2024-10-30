/*******************************************************************************
DBS 311 Project
Assignment 1

Group - 10
Section: NBB
Date : October 17, 2023

Name: Thanh My Trang Le
Email: tle70@myseneca.ca
ID: 175409218

Name: Ikechukwu Anthony Attah
Email: iattah@myseneca.ca
ID: 175441211

Serge Safronov
SSafronov@myseneca.ca
ID: 132736224
*******************************************************************************/

#include <iostream>
#include <iomanip>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using oracle::occi::Statement;
using oracle::occi::ResultSet;
using namespace oracle::occi;
using namespace std;

// CONTACTS
void queryContacts(Statement* stmt, const string& contactId) {
    ResultSet* contactRs = stmt->executeQuery("SELECT * FROM contacts WHERE contactID =" + contactId);
        
    cout << "-------------------------------------------------------------------------------------------------------------------------" << endl;
    cout << "contactID  firstName  lastName  dateOfBirth  addressLine1  addressLine2  city  province  postalCode  email  phone  sin" << endl;
    cout << "-------------------------------------------------------------------------------------------------------------------------" << endl;

    while (contactRs->next()) {
        cout << contactRs->getInt(1) << "  ";
        cout << contactRs->getString(2) << "  ";
        cout << contactRs->getString(3) << "  ";
        cout << contactRs->getDate(4).toText("YYYY-MM-DD") << "  ";
        cout << contactRs->getString(5) << "  ";
        cout << contactRs->getString(6) << "  ";
        cout << contactRs->getString(7) << "  ";
        cout << contactRs->getString(8) << "  ";
        cout << contactRs->getString(9) << "  ";
        cout << contactRs->getString(10) << "  ";
        cout << contactRs->getString(11) << "  ";
        cout << contactRs->getString(12) << "\n";
    }
}

// EMPLOYEES
void queryEmployees(Statement* stmt, const string& employeeId) {
    ResultSet* employeeRs = stmt->executeQuery("SELECT * FROM EMPLOYEES WHERE employeeID =" + employeeId);
    std::cout << "------------------------------------------------------------------------------------------------------------------------" << endl;
    std::cout << "employeeID  reportsTo  contactID  branchID  jobTitle" << endl;
    std::cout << "------------------------------------------------------------------------------------------------------------------------" << endl;

    while (employeeRs->next()) {
        cout << employeeRs->getInt(1) << "  ";
        cout << employeeRs->getInt(2) << "  ";
        cout << employeeRs->getInt(3) << "  ";
        cout << employeeRs->getInt(4) << "  ";
        cout << employeeRs->getString(5) << "\n";
    }   
}

// ACCOUNTS
void queryAccounts(Statement* stmt, const string& accountNumber) {
    ResultSet* rs = stmt->executeQuery("SELECT * FROM accounts WHERE accountNumber=" + accountNumber);
    cout << "------------------------------------------------------------------------------------------------" << endl;
    cout << "# AccountNumber  BranchID  CustomerID  Balance  AccountType  OpenDate  Status  InterestRate" << endl;
    cout << "------------------------------------------------------------------------------------------------" << endl;
    while (rs->next()) {
        cout.width(15); cout << left << rs->getString(1) << " ";
        cout.width(10); cout << left << rs->getString(2) << " ";
        cout.width(12); cout << left << rs->getString(3) << " ";
        cout.width(8); cout << left << rs->getDouble(4) << " ";
        cout.width(13); cout << left << rs->getString(5) << " ";
        cout.width(10); cout << left << rs->getString(6) << " ";
        cout.width(7); cout << left << rs->getString(7) << " ";
        cout.width(13); cout << left << rs->getDouble(8) << endl;
    }
}

// BRANCHES
void queryBranches(Statement* stmt, const string& branchID) {
    ResultSet* rs = stmt->executeQuery("SELECT * FROM branches WHERE branchID=" + branchID);
    cout << "------------------------------------------------------------------------------------------------" << endl;
    cout << "# BranchID  BranchName  AddressLine1  AddressLine2  City  Province  PostalCode  Phone" << endl;
    cout << "------------------------------------------------------------------------------------------------" << endl;

    while (rs->next()) {
        cout.width(10); cout << left << rs->getString(1) << " ";
        cout.width(12); cout << left << rs->getString(2) << " ";
        cout.width(14); cout << left << rs->getString(3) << " ";
        cout.width(14); cout << left << rs->getString(4) << " ";
        cout.width(6); cout << left << rs->getString(5) << " ";
        cout.width(9); cout << left << rs->getString(6) << " ";
        cout.width(11); cout << left << rs->getString(7) << " ";
        cout.width(7); cout << left << rs->getString(8) << endl;
    }
}

// TRANSACTIONS
void queryTransactions(Statement* stmt, const string& accountID) {   
    
    ResultSet* rsss = stmt->executeQuery(
        "SELECT transactionID, transactions.accountNumber, transactionType, "
        "amount, TO_CHAR(transactionDate, 'DD Mon, YYYY HH24:MI:SS') as trDateTime "
        "FROM transactions "
        "RIGHT JOIN accounts ON transactions.accountNumber = accounts.accountNumber "
        "WHERE transactions.accountnumber =" + accountID);

    bool hasData = false;
    bool printHeader = false;

    while (rsss->next()) {
        hasData = true;

        if (!printHeader) {
            cout << endl << "Detailed transactions of account " << accountID << ":" << endl << endl;
            cout << "+----------------+----------------+------------------+-------------+--------------------------+" << endl;
            cout << "| Account Number | Transaction ID | Transaction Type |  Amount CAD | Tranaction Date and Time |" << endl;
            cout << "+----------------+----------------+------------------+-------------+--------------------------+" << endl;
            printHeader = true;
        }

        int transactionID = rsss->getInt(1);
        int accountNumber = rsss->getInt(2);
        string transactionType = rsss->getString(3);
        double amount = rsss->getDouble(4);
        string trDateTime = rsss->getString(5);

        cout << "| ";
        cout << setw(14) << right << accountNumber << " | ";
        cout << setw(14) << right << transactionID << " | ";
        cout << setw(16) << right << transactionType << " | ";
        cout << setw(11) << right << fixed << setprecision(2) << amount << " | ";
        cout << setw(24) << right << trDateTime << " |" << endl;
        cout << "+----------------+----------------+------------------+-------------+--------------------------+" << endl;
    }
    if (!hasData) {
        cout << endl << "No transactions found for this ID." << endl;
    }
    cout << endl << endl;
}


// LOANS
void queryLoans(Statement* stmt, const string& loanID) {
   
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
            cout << "| LoanID | Account Number | Specialist ID |      Loan Type |  Balance CAD | Interest Rate |   Approval Date | Duration Months |      Status |         Employee Comment |" << endl;
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

int main(void) {
    /* OCCI Variables */
    Environment* env = nullptr;
    Connection* conn = nullptr;
    /* Used Variables */
    string user = "dbs311_233nbb21";//Add your dbs username from Blackboard here
    string pass = "21991169";///Add your dbs password from Blackboard here

    string srv = "myoracle12c.senecacollege.ca:1521/oracle12c";
    try {
        env = Environment::createEnvironment(Environment::DEFAULT);
        conn = env->createConnection(user, pass, srv);
        cout << "Connection is Successful!" << endl << endl;

        Statement* stmt = conn->createStatement();
        
        int choice;
        string input;      

        // QUERY SELECTION
        do {
            cout << "\nChoose Table to Query: " << endl;
            cout << "1. Contacts" << endl;
            cout << "2. Employees" << endl;
            cout << "3. Accounts" << endl;
            cout << "4. Branches" << endl;
            cout << "5. Transactions" << endl;
            cout << "6. Loans" << endl;
            cout << "0. Exit" << endl;
            cout << "Enter choice: ";

            cin >> choice;
            if (choice == 1) {
                 cout << "Enter ContactID: ";
                 cin >> input;
                 queryContacts(stmt, input);
            }
            else if (choice == 2) {
                cout << "Enter EmployeeID: ";
                cin >> input;
                queryEmployees(stmt, input);
            }                 
            else if (choice == 3) {
                cout << "Enter Account Number: ";
                cin >> input;
                queryAccounts(stmt, input);
            }
            else if (choice == 4) {
                cout << "Enter Branch ID: ";
                cin >> input;
                queryBranches(stmt, input);
            }
            else if (choice == 5) {
                cout << "Enter Account ID to see its transactions: ";
                cin >> input;
                queryTransactions(stmt, input);
            }
            else if (choice == 6) {
                cout << "Enter Loan ID: ";
                cin >> input;
                queryLoans(stmt, input);
            }
            else if (choice == 0) {
                break;
            }
            else {
                cout << "Invalid choice." << endl;
            }
        } while (choice != 0);        

        conn->terminateStatement(stmt);
        env->terminateConnection(conn);
        Environment::terminateEnvironment(env);
    }
    catch (SQLException& sqlExcp) {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }

    return 0;
}
