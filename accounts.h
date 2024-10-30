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

#ifndef ACCOUNTS_H
#define ACCOUNTS_H

#include <iostream>
#include <iomanip>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using oracle::occi::Statement;
using oracle::occi::ResultSet;

using namespace oracle::occi;
using namespace std;

// ACCOUNTS

void queryAccounts(Statement* stmt, const string& accountNumber);

#endif