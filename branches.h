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

#ifndef BRANCHES_H
#define BRANCHES_H

#include <iostream>
#include <iomanip>
#include <occi.h>

using oracle::occi::Environment;
using oracle::occi::Connection;
using oracle::occi::Statement;
using oracle::occi::ResultSet;

using namespace oracle::occi;
using namespace std;

// BRANCHES

// Function to execute a stored procedure that expects only IN parameters
void executeProcedure(Connection* conn, const string& sql, int& outStatus);

// Function to call INSERT stored procedure for the branch table
void insertBranch(Connection* conn);

// Function to call UPDATE stored procedure for the branch table
void updateBranch(Connection* conn);

// Function to call DELETE stored procedure for the branch table
void deleteBranch(Connection* conn);

// Function to call SELECT stored procedure for the branch table
void selectBranch(Connection* conn);

// Query to select a branch by ID
void queryBranches(Statement* stmt, const string& branchID);

// Menu optons
void manageBranches(Connection* conn);

#endif