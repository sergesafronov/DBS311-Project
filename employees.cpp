/*******************************************************************************
DBS 311 Project
Assignment 2 - Part 2

Group - 10
Section: NBB
Date : November 25, 2023

Name: Thanh My Trang Le
Email: tle70@myseneca.ca
ID: 175409218

*******************************************************************************/

#include "employees.h"

 
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