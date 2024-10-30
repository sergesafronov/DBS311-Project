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

#ifndef CONTACTS_H
#define CONTACTS_H

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

void queryContacts(Statement* stmt, const string& contactId);

#endif