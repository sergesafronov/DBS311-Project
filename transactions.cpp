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


#include "transactions.h"


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


