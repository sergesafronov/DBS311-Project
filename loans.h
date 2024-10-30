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


#ifndef LOANS_H
#define LOANS_H

#include <iostream>
#include <iomanip>
#include <string>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using oracle::occi::Statement;
using oracle::occi::ResultSet;

using namespace oracle::occi;
using namespace std;

// LOANS

void queryLoans(Statement* stmt);

void selectLoan(Statement* stmt);

void insertLoan(Statement* stmt);

void updateLoan(Statement* stmt);

void deleteLoan(Statement* stmt);

// Menu optons
void manageLoans(Statement* stmt);

#endif