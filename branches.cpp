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

#include "branches.h"


void executeProcedure(Connection* conn, const string& sql, int& outStatus) {
    Statement* stmt = conn->createStatement(sql);
    try {

        stmt->registerOutParam(1, oracle::occi::OCCIINT, sizeof(outStatus));

        stmt->executeUpdate();

        // Retrieve the value of the OUT parameter
        outStatus = stmt->getInt(1);

        cout << "Stored procedure executed successfully. Out Status: " << outStatus << endl;
    }
    catch (SQLException& ex) {
        cout << "Error executing stored procedure: " << ex.getMessage() << endl;
    }
    conn->terminateStatement(stmt);
}


void insertBranch(Connection* conn) {
    string branchId, branchName, addressLine1, addressLine2, city, province, postalCode, phone;
    cout << "Enter Branch ID: "; cin >> branchId;
    cout << "Enter Branch Name: "; cin.ignore(); getline(cin, branchName);
    cout << "Enter Address Line 1: "; getline(cin, addressLine1);
    cout << "Enter Address Line 2: "; getline(cin, addressLine2);
    cout << "Enter City: "; getline(cin, city);
    cout << "Enter Province: "; getline(cin, province);
    cout << "Enter Postal Code: "; getline(cin, postalCode);
    cout << "Enter Phone: "; getline(cin, phone);

    int outStatus;
    Statement* stmt = nullptr;

    try {
        stmt = conn->createStatement();
        stmt->setSQL("BEGIN spBranchInsert(:1, :2, :3, :4, :5, :6, :7, :8, :9); END;");
        stmt->setInt(1, stoi(branchId)); // Convert branchId to integer
        stmt->setString(2, branchName);
        stmt->setString(3, addressLine1);
        stmt->setString(4, addressLine2);
        stmt->setString(5, city);
        stmt->setString(6, province);
        stmt->setString(7, postalCode);
        stmt->setString(8, phone);
        stmt->registerOutParam(9, oracle::occi::OCCIINT);

        stmt->executeUpdate();

        // Retrieve the OUT parameter value
        outStatus = stmt->getInt(9);

        if (outStatus == 1) {
            cout << "Branch inserted successfully." << endl;
        }
        else {
            cout << "Failed to insert branch. Status: " << outStatus << endl;
        }
    }
    catch (SQLException& ex) {
        cout << "Error executing stored procedure: " << ex.getMessage() << endl;
    }

    if (stmt) {
        conn->terminateStatement(stmt);
    }
}


void updateBranch(Connection* conn) {
    string branchId, branchName, addressLine1, addressLine2, city, province, postalCode, phone;
    cout << "Enter Branch ID to update: "; cin >> branchId;
    cout << "Enter new Branch Name: "; cin.ignore(); getline(cin, branchName);
    cout << "Enter new Address Line 1: "; getline(cin, addressLine1);
    cout << "Enter new Address Line 2: "; getline(cin, addressLine2);
    cout << "Enter new City: "; getline(cin, city);
    cout << "Enter new Province: "; getline(cin, province);
    cout << "Enter new Postal Code: "; getline(cin, postalCode);
    cout << "Enter new Phone: "; getline(cin, phone);

    int outStatus;
    Statement* stmt = nullptr;

    try {
        stmt = conn->createStatement();
        stmt->setSQL("BEGIN spBranchUpdate(:1, :2, :3, :4, :5, :6, :7, :8, :9); END;");
        stmt->setInt(1, stoi(branchId)); // Convert branchId to integer
        stmt->setString(2, branchName);
        stmt->setString(3, addressLine1);
        stmt->setString(4, addressLine2);
        stmt->setString(5, city);
        stmt->setString(6, province);
        stmt->setString(7, postalCode);
        stmt->setString(8, phone);
        stmt->registerOutParam(9, oracle::occi::OCCIINT);

        stmt->executeUpdate();

        // Retrieve the OUT parameter value
        outStatus = stmt->getInt(9);

        if (outStatus == 1) {
            cout << "Branch updated successfully." << endl;
        }
        else {
            cout << "Failed to update branch. Status: " << outStatus << endl;
        }
    }
    catch (SQLException& ex) {
        cout << "Error executing stored procedure: " << ex.getMessage() << endl;
    }

    if (stmt) {
        conn->terminateStatement(stmt);
    }
}


void deleteBranch(Connection* conn) {
    string branchName;
    cout << "Enter Branch Name to delete: "; cin.ignore(); getline(cin, branchName);

    int outStatus;
    Statement* stmt = nullptr;

    try {
        stmt = conn->createStatement();
        stmt->setSQL("BEGIN spBranchDelete(:1, :2); END;");
        stmt->setString(1, branchName);
        stmt->registerOutParam(2, oracle::occi::OCCIINT);

        stmt->executeUpdate();

        // Retrieve the OUT parameter value
        outStatus = stmt->getInt(2);

        if (outStatus == 1) {
            cout << "Branch deleted successfully." << endl;
        }
        else {
            cout << "Failed to delete branch. Status: " << outStatus << endl;
        }
    }
    catch (SQLException& ex) {
        cout << "Error executing stored procedure: " << ex.getMessage() << endl;
    }

    if (stmt) {
        conn->terminateStatement(stmt);
    }
}


void selectBranch(Connection* conn) {
    Statement* stmt = nullptr;
    string branchId;
    int outStatus = 0;

    // Prompt user for Branch ID
    cout << "Enter Branch ID: ";
    cin >> branchId;

    try {
        // Begin a transaction

        stmt = conn->createStatement();


        // to have OUT parameters for each branch detail and status
        stmt->setSQL("BEGIN spBranchSelect(:1, :2, :3, :4, :5, :6, :7, :8, :9); END;");
        stmt->setString(1, branchId);
        // ... Bind OUT parameters for branch details
        stmt->registerOutParam(2, OCCISTRING, 50); // OUT parameter for BranchName
        stmt->registerOutParam(3, OCCISTRING, 100); // OUT parameter for AddressLine1
        stmt->registerOutParam(4, OCCISTRING, 100); // OUT parameter for AddressLine2
        stmt->registerOutParam(5, OCCISTRING, 50); // OUT parameter for City
        stmt->registerOutParam(6, OCCISTRING, 50); // OUT parameter for Province
        stmt->registerOutParam(7, OCCISTRING, 20); // OUT parameter for PostalCode
        stmt->registerOutParam(8, OCCISTRING, 20); // OUT parameter for Phone
        stmt->registerOutParam(9, OCCIINT, sizeof(outStatus)); // OUT parameter for status code


        // Execute the stored procedure
        stmt->executeUpdate();

        // Commit the transaction
        conn->commit();

        // Retrieve the status
        outStatus = stmt->getInt(9);
        if (outStatus == 1) {
            // If status is successful, fetch and display the results
            cout << "------------------------------------------------------------------------------------------------" << endl;
            cout << left << setw(10) << "BranchID" << setw(20) << "BranchName" << setw(20) << "AddressLine1" << setw(20) << "AddressLine2" << setw(15) << "City" << setw(10) << "Province" << setw(15) << "PostalCode" << setw(15) << "Phone" << endl;
            cout << "------------------------------------------------------------------------------------------------" << endl;

            // Display the row of data
            cout << left << setw(10) << branchId
                << setw(20) << stmt->getString(2)   // BranchName
                << setw(20) << stmt->getString(3)   // AddressLine1
                << setw(20) << stmt->getString(4)   // AddressLine2
                << setw(15) << stmt->getString(5)   // City
                << setw(10) << stmt->getString(6)   // Province
                << setw(15) << stmt->getString(7)   // PostalCode
                << setw(15) << stmt->getString(8)   // Phone
                << endl;
            cout << "------------------------------------------------------------------------------------------------" << endl;
        }
        else {
            cout << "Branch with ID " << branchId << " not found." << endl;
        }
    }
    catch (SQLException& ex) {
        cout << "Error executing stored procedure: " << ex.getMessage() << endl;
        conn->rollback();  // Rollback in case of error
    }

    // Clean up
    if (stmt) {
        conn->terminateStatement(stmt);
    }
}


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

void manageBranches(Connection* conn) {
    int choice;
    do {
        cout << "\nChoose an operation for Branch Table:" << endl;
        cout << "1. Insert new branch" << endl;
        cout << "2. Update existing branch" << endl;
        cout << "3. Delete branch" << endl;
        cout << "4. Select branch" << endl;
        cout << "0. Exit" << endl;
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {
            case 1:
                insertBranch(conn);
                break;
            case 2:
                updateBranch(conn);
                break;
            case 3:
                deleteBranch(conn);
                break;
            case 4:
                selectBranch(conn);
                break;
            case 0:               
                break;
            default:
                cout << "Invalid choice, try again." << endl;
        }
    } while (choice != 0);
}

