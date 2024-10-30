/*******************************************************************************
DBS 311 Project
Assignment 2 - Part 2

Group - 10
Section: NBB
Date : November 25, 2023

Name: Ikechukwu Anthony Attah
Email: iattah@myseneca.ca
ID: 175441211

*******************************************************************************/

#include "accounts.h"


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
