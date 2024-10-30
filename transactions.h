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


#ifndef TRANSACTIONS_H
#define TRANSACTIONS_H

#include <iostream>
#include <iomanip>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using oracle::occi::Statement;
using oracle::occi::ResultSet;

using namespace oracle::occi;
using namespace std;

// TRANSACTIONS

void queryTransactions(Statement* stmt, const string& accountID);

#endif