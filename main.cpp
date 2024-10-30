/*******************************************************************************
DBS 311 Project
Assignment 2 - Part 2

Group - 10
Section: NBB
Date : November 25, 2023

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


#include "contacts.h"
#include "employees.h"
#include "accounts.h"
#include "branches.h"
#include "loans.h"
#include "transactions.h"


int main(void) {

    /* OCCI Variables */
    Environment* env = nullptr;
    Connection* conn = nullptr;

    /* Used Variables */

    // Name: Thanh My Trang Le
    //string user = ""; //Add your dbs username from Blackboard here
    //string pass = ""; //Add your dbs password from Blackboard here

    // Name: Ikechukwu Anthony Attah
    string user = "dbs311_233nbb03"; //Add your dbs username from Blackboard here
    string pass = "24543249"; //Add your dbs password from Blackboard here
    
    // Name: Serge Safronov
    //string user = "dbs311_233nbb21"; //Add your dbs username from Blackboard here
    //string pass = "21991169"; //Add your dbs password from Blackboard here

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
            cout << "\n\nChoose a Table to Query: " << endl;
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
                manageBranches(conn);
            }
            else if (choice == 5) {
                cout << "Enter Account ID to see its transactions: ";
                cin >> input;
                queryTransactions(stmt, input);
            }
            else if (choice == 6) {
                manageLoans(stmt);
            }
            else if (choice == 0) {
                cout << "Exiting the program..." << endl;
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
