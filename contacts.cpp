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

#include "contacts.h"

 
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