/*******************************************************************************
DBS 311 Project
Assignment 1

Group - 10
Section: NBB
Date : October 17, 2023

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


-- Create a table CONTACTS
CREATE TABLE contacts (
    contactID INT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    dateOfBirth DATE NOT NULL,
    addressLine1 VARCHAR(100) NOT NULL,
    addressLine2 VARCHAR(100),
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    postalCode CHAR(7) NOT NULL,           -- Canadian postal codes have have 7 symbols.
    email VARCHAR(100) UNIQUE NOT NULL,
    phone NUMBER(10,0) NOT NULL,           -- Canadian phone numbers have 10 digits.
    SINumber NUMBER(9,0) UNIQUE NOT NULL,  -- Canadian SINs have 9 digits.
    CONSTRAINT contacts_pk PRIMARY KEY (contactID)
);


-- Create a table BRANCHES
CREATE TABLE branches (
    branchID INT PRIMARY KEY,
    branchName VARCHAR2(50),
    addressLine1 VARCHAR2(100),
    addressLine2 VARCHAR2(100),
    city VARCHAR2(50),
    province VARCHAR2(50),
    postalCode VARCHAR2(20),
    phone VARCHAR2(15)
);


--Create a table EMPLOYEES
CREATE TABLE employees (
    employeeID INT NOT NULL,
    reportsTo INT,
    contactID INT NOT NULL,
    branchID INT NOT NULL,
    jobTitle VARCHAR(100) NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY (employeeID),
    CONSTRAINT emp_contact_fk FOREIGN KEY (contactID) REFERENCES CONTACTS(contactID),
    CONSTRAINT emp_branch_fk FOREIGN KEY (branchID) REFERENCES BRANCHES(branchID),
    CONSTRAINT emp_reportsTo_fk FOREIGN KEY (reportsTo) REFERENCES EMPLOYEES(employeeID)
);


SELECT e.employeeID, c.firstName, c.lastName, c.email
FROM employees e
JOIN contacts c ON e.contactID = c.contactID
ORDER BY e.employeeID;




-- Create a table CUSTOMERS
CREATE TABLE customers (
    customerID INT NOT NULL,
    contactID INT NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY (customerID),
    CONSTRAINT cust_contact_fk FOREIGN KEY (contactID) REFERENCES CONTACTS(contactID)
);


-- Create a table ACCOUNTS
CREATE TABLE accounts (
    accountNumber INT NOT NULL,
    branchID INT NOT NULL,
    customerID INT NOT NULL,
    balance DECIMAL(18, 2) NOT NULL,
    accountType VARCHAR2(50 )NOT NULL,
    openDate DATE NOT NULL,
    status VARCHAR2(20) NOT NULL,
    interestRate DECIMAL(5,2) NOT NULL,
    CONSTRAINT accounts_pk PRIMARY KEY (accountNumber),
    CONSTRAINT acc_branch_fk FOREIGN KEY (branchID) REFERENCES BRANCHES(branchID),
    CONSTRAINT acc_customer_fk FOREIGN KEY (customerID) REFERENCES CUSTOMERS(customerID)
);

-- Create a table TRANSACTIONS
CREATE TABLE transactions (
    transactionID INT NOT NULL,
    accountNumber INT NOT NULL,
    transactionType VARCHAR(50) NOT NULL,
    amount DECIMAL(20,2) NOT NULL,
    transactionDate DATE NOT NULL, -- Stoars both, DATE and TIME.    
    CONSTRAINT trans_pk PRIMARY KEY (transactionID, accountNumber),
    CONSTRAINT trans_account_fk FOREIGN KEY (accountNumber) REFERENCES accounts(accountNumber)
);


-- Create a table LOANS
CREATE TABLE loans (
    loanID INT NOT NULL,
    accountNumber INT NOT NULL,
    loanSpecialist INT NOT NULL,
    balance DECIMAL(20,2) NOT NULL,
    loanType VARCHAR(50) NOT NULL,
    interestRate DECIMAL(4,2) NOT NULL,
    approvalDate DATE NOT NULL,
    durationMonths INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    employeeComment VARCHAR(500),    
    CONSTRAINT loan_pk PRIMARY KEY (loanID, accountNumber),
    CONSTRAINT loan_account_fk FOREIGN KEY (accountNumber) REFERENCES accounts(accountNumber),
    CONSTRAINT loan_loanSpecialist_fk FOREIGN KEY (loanSpecialist) REFERENCES employees(employeeID)
);


-- Insert data into BRANCHES table.
INSERT ALL
    INTO branches VALUES (4001, 'North Branch', '123 North St', 'Suite 1', 'Cityville', 'ProvinceX', '12345', '123-456-7890')
    INTO branches VALUES (4002, 'South Branch', '456 South Rd', 'Bldg 2', 'Townburg', 'ProvinceY', '67890', '987-654-3210')
    INTO branches VALUES (4003, 'East Branch', '789 East Ave', NULL, 'VillageTown', 'ProvinceZ', '11222', '555-444-3333')
    INTO branches VALUES (4004, 'West Branch', '101 West Blvd', 'Apt 304', 'BoroughShire', 'ProvinceA', '33445', '666-777-8888')
    INTO branches VALUES (4005, 'Central Branch', '202 Central Ln', NULL, 'MetroCity', 'ProvinceB', '55678', '222-111-0000')
    INTO branches VALUES (4006, 'Suburban Branch', '303 Suburban Dr', 'Suite B', 'Urbanville', 'ProvinceC', '77885', '999-888-7777')
    INTO branches VALUES (4007, 'Rural Branch', '404 Rural Rd', NULL, 'CountryTown', 'ProvinceD', '99887', '111-222-3333')
    INTO branches VALUES (4008, 'Downtown Branch', '505 Downtown St', 'Floor 5', 'CityCenter', 'ProvinceE', '44993', '444-555-6666')
    INTO branches VALUES (4009, 'Uptown Branch', '606 Uptown Ave', NULL, 'TownCity', 'ProvinceF', '77345', '777-666-5555')
    INTO branches VALUES (4010, 'Midtown Branch', '707 Midtown Blvd', 'Room 707', 'CityMetro', 'ProvinceG', '88234', '333-222-1111')
    INTO branches VALUES (4011, 'Harbor Branch', '808 Harbor Way', NULL, 'PortCity', 'ProvinceH', '93012', '444-555-9999')
    INTO branches VALUES (4012, 'Hilltop Branch', '909 Hilltop Dr', 'Unit 90', 'HillTown', 'ProvinceI', '33912', '222-555-9999')
    INTO branches VALUES (4013, 'Lakeside Branch', '101 Lakeside Ln', NULL, 'LakeCity', 'ProvinceJ', '55122', '333-555-9999')
    INTO branches VALUES (4014, 'Valley Branch', '202 Valley Rd', 'Suite 200', 'ValleyTown', 'ProvinceK', '99663', '444-777-9999')
    INTO branches VALUES (4015, 'Forest Branch', '303 Forest Ave', NULL, 'ForestCity', 'ProvinceL', '11023', '888-555-9999')
    INTO branches VALUES (4016, 'Desert Branch', '404 Desert Blvd', 'Unit 4', 'DesertTown', 'ProvinceM', '44220', '555-777-9999')
    INTO branches VALUES (4017, 'Mountain Branch', '505 Mountain St', NULL, 'MountainCity', 'ProvinceN', '55330', '777-555-9999')
    INTO branches VALUES (4018, 'Seafront Branch', '606 Seafront Ln', 'Apt 6', 'Seaside', 'ProvinceO', '22550', '999-555-9999')
    INTO branches VALUES (4019, 'Prairie Branch', '707 Prairie Ave', NULL, 'PrairieCity', 'ProvinceP', '44882', '111-777-9999')
    INTO branches VALUES (4020, 'Canyon Branch', '808 Canyon Blvd', 'Unit 80', 'CanyonTown', 'ProvinceQ', '99442', '222-777-9999')
SELECT * FROM DUAL;
COMMIT;


-- Insert data into CONTACTS table.
INSERT ALL   
    INTO contacts VALUES (1001, 'Skell', 'Lofty', TO_DATE('1985-04-15', 'YYYY-MM-DD'), '1351 Fallview Avenue', 'Suite 2', 'Toronto', 'ON', 'M5H 2N2', 'slofty@canmail.ca', 4161234567, 123456789)
    INTO contacts VALUES (1002, 'Viva', 'Elcox', TO_DATE('1990-08-21', 'YYYY-MM-DD'), '97 Forest Dale Plaza', 'Suite 27', 'Mississauga', 'ON', 'L5B 3Y5', 'velcox@canmail.ca', 9051234567, 234567890)
    INTO contacts VALUES (1003, 'Gladys', 'Craisford', TO_DATE('1995-12-05', 'YYYY-MM-DD'), '06499 Onsgard Road', 'PO Box 30888', 'Brampton', 'ON', 'L6Y 2G8', 'gcraisford@canmail.ca', 9051234568, 345678901)
    INTO contacts VALUES (1004, 'Berthe', 'Loseby', TO_DATE('1982-06-17', 'YYYY-MM-DD'), '0550 Crownhardt Drive', '7th Floor', 'Vaughan', 'ON', 'L4K 4G8', 'bloseby@canmail.ca', 9051234569, 456789012)
    INTO contacts VALUES (1005, 'Gerta', 'Rickersey', TO_DATE('1993-02-11', 'YYYY-MM-DD'), '33 Washington Avenue', 'Room 417', 'Markham', 'ON', 'L3R 9V6', 'grickersey@canmail.ca', 9051234570, 567890123)
    INTO contacts VALUES (1006, 'Dorolisa', 'Wrist', TO_DATE('1989-07-25', 'YYYY-MM-DD'), '4 Corscot Hill', 'Suite 4', 'Richmond Hill', 'ON', 'L4C 4Z5', 'dwrist@canmail.ca', 9051234571, 678901234)
    INTO contacts VALUES (1007, 'Priscella', 'Pavey', TO_DATE('1992-11-03', 'YYYY-MM-DD'), '8724 Steensland Plaza', 'Suite 65', 'Scarborough', 'ON', 'M1V 5P8', 'ppavey@canmail.ca', 4161234572, 789012345)
    INTO contacts VALUES (1008, 'Ebonee', 'Maylard', TO_DATE('1994-01-28', 'YYYY-MM-DD'), '2952 Anniversary Terrace', 'PO Box 5293', 'North York', 'ON', 'M3J 0H7', 'emaylard@canmail.ca', 4161234573, 890123456)
    INTO contacts VALUES (1009, 'Cristina', 'Boggish', TO_DATE('1987-10-14', 'YYYY-MM-DD'), '71 Weeping Birch Park', '4th Floor', 'Etobicoke', 'ON', 'M9W 6J4', 'cboggish@canmail.ca', 4161234574, 901234567)
    INTO contacts VALUES (1010, 'Berty', 'Liccardo', TO_DATE('1988-03-03', 'YYYY-MM-DD'), '10492 Burning Wood Junction', '8th Floor', 'Oakville', 'ON', 'L6H 5Z9', 'bliccardo@canmail.ca', 9051234575, 123456780)
    INTO contacts VALUES (1011, 'Frazier', 'Paradine', TO_DATE('1983-05-18', 'YYYY-MM-DD'), '94 Fieldstone Circle', '12th Floor', 'Toronto', 'ON', 'M5V 2T6', 'fparadine@canmail.ca', 4161234576, 212345678)
    INTO contacts VALUES (1012, 'Vi', 'Desouza', TO_DATE('1987-09-22', 'YYYY-MM-DD'), '58 Hanover Drive', 'Apt 1939', 'Mississauga', 'ON', 'L5R 3E4', 'vdesouza@canmail.ca', 9051234577, 323456789)
    INTO contacts VALUES (1013, 'Lancelot', 'Longworthy', TO_DATE('1984-12-31', 'YYYY-MM-DD'), '61933 Sloan Point', '9th Floor', 'Brampton', 'ON', 'L6S 4Z4', 'llongworthy@canmail.ca', 9051234578, 434567890)
    INTO contacts VALUES (1014, 'Lona', 'Prigg', TO_DATE('1991-02-16', 'YYYY-MM-DD'), '8900 Gerald Court', 'Room 547', 'Vaughan', 'ON', 'L4J 8J8', 'lprigg@canmail.ca', 9051234579, 545678901)
    INTO contacts VALUES (1015, 'Mireielle', 'Splaven', TO_DATE('1988-08-08', 'YYYY-MM-DD'), '299 Riverside Point', '3rd Floor', 'Markham', 'ON', 'L3R 0B9', 'msplaven@canmail.ca', 9051234580, 656789012)
    INTO contacts VALUES (1016, 'Shaina', 'Boas', TO_DATE('1992-11-12', 'YYYY-MM-DD'), '388 Arapahoe Trail', 'Apt 1874', 'Richmond Hill', 'ON', 'L4C 4Z6', 'sboas@canmail.ca', 9051234581, 767890123)
    INTO contacts VALUES (1017, 'Dalton', 'Van den Hof', TO_DATE('1986-04-25', 'YYYY-MM-DD'), '3096 Larry Junction', '20th Floor', 'Scarborough', 'ON', 'M1B 2W3', 'dvandenhof@canmail.ca', 4161234582, 878901234)
    INTO contacts VALUES (1018, 'Rodina', 'Sikorsky', TO_DATE('1985-06-15', 'YYYY-MM-DD'), '3 Sundown Terrace', 'Suite 79', 'North York', 'ON', 'M2N 6X4', 'rsikorsky@canmail.ca', 4161234583, 989012345)
    INTO contacts VALUES (1019, 'Jo-ann', 'Abrehart', TO_DATE('1990-07-17', 'YYYY-MM-DD'), '44079 Northview Circle', 'PO Box 12630', 'Etobicoke', 'ON', 'M9W 5L4', 'jabrehart@canmail.ca', 4161234584, 190123456)
    INTO contacts VALUES (1020, 'Hagan', 'Climpson', TO_DATE('1989-03-03', 'YYYY-MM-DD'), '301 Butterfield Terrace', '8th Floor', 'Oakville', 'ON', 'L6H 7L8', 'hclimpson@canmail.ca', 9051234585, 201234567)
    INTO contacts VALUES (1021, 'Bernadine', 'Getcliff', TO_DATE('1982-03-11', 'YYYY-MM-DD'), '47643 Gerald Avenue', 'Apt 1012', 'Toronto', 'ON', 'M5T 2V6', 'bgetcliff@canmail.ca', 4161234586, 212345671)
    INTO contacts VALUES (1022, 'Arluene', 'Zorzenoni', TO_DATE('1984-06-22', 'YYYY-MM-DD'), '2234 Susan Plaza', 'PO Box 99531', 'Mississauga', 'ON', 'L5M 7L1', 'azorzenoni@canmail.ca', 9051234587, 323456782)
    INTO contacts VALUES (1023, 'Beltran', 'Chiene', TO_DATE('1987-10-12', 'YYYY-MM-DD'), '1 South Road', '12th Floor', 'Brampton', 'ON', 'L6Y 4M1', 'bchiene@canmail.ca', 9051234588, 434567893)
    INTO contacts VALUES (1024, 'Hart', 'Bennion', TO_DATE('1990-11-05', 'YYYY-MM-DD'), '8525 Dakota Way', 'PO Box 51066', 'Vaughan', 'ON', 'L4K 4T7', 'hbennion@canmail.ca', 9051234589, 545678904)
    INTO contacts VALUES (1025, 'Alexandro', 'Bootman', TO_DATE('1985-05-19', 'YYYY-MM-DD'), '1473 Vermont Parkway', 'Suite 67', 'Markham', 'ON', 'L3R 5B4', 'abootman@canmail.ca', 9051234590, 656789015)
    INTO contacts VALUES (1026, 'Jayson', 'Manoelli', TO_DATE('1983-08-27', 'YYYY-MM-DD'), '04574 Sachs Lane', 'Room 245', 'Richmond Hill', 'ON', 'L4S 1P4', 'jmanoelli@canmail.ca', 9051234591, 767890126)
    INTO contacts VALUES (1027, 'Tedd', 'Huckett', TO_DATE('1986-01-16', 'YYYY-MM-DD'), '31 Bunting Circle', 'Apt 1088', 'North York', 'ON', 'M2J 4R3', 'thuckett@canmail.ca', 4161234592, 878901237)
    INTO contacts VALUES (1028, 'Clo', 'Mogey', TO_DATE('1992-04-04', 'YYYY-MM-DD'), '90 Glacier Hill Junction', '16th Floor', 'Scarborough', 'ON', 'M1R 5K1', 'cmogey@canmail.ca', 4161234593, 989012348)
    INTO contacts VALUES (1029, 'Vernor', 'Yusupov', TO_DATE('1988-07-07', 'YYYY-MM-DD'), '66794 Monterey Parkway', 'Suite 45', 'Etobicoke', 'ON', 'M9B 6R1', 'vyusupov@canmail.ca', 4161234594, 190123459)
    INTO contacts VALUES (1030, 'Hubey', 'Backson', TO_DATE('1989-09-09', 'YYYY-MM-DD'), '826 Thierer Lane', 'Room 1314', 'Oakville', 'ON', 'L6K 3S2', 'hbackson@canmail.ca', 9051234595, 201234560)
    INTO contacts VALUES (1031, 'Micki', 'Manifold', TO_DATE('1981-10-25', 'YYYY-MM-DD'), '96400 Columbus Hill', 'Suite 25', 'Toronto', 'ON', 'M5V 3T5', 'mmanifold@canmail.ca', 4161234596, 212345670)
    INTO contacts VALUES (1032, 'Horst', 'Topham', TO_DATE('1983-03-15', 'YYYY-MM-DD'), '731 Farwell Road', 'Room 965', 'Mississauga', 'ON', 'L5W 1A1', 'htopham@canmail.ca', 9051234597, 323456781)
    INTO contacts VALUES (1033, 'Maryellen', 'Duncklee', TO_DATE('1986-06-03', 'YYYY-MM-DD'), '49176 Dorton Street', 'Room 64', 'Brampton', 'ON', 'L6Y 4N7', 'mduncklee@canmail.ca', 9051234598, 434567892)
    INTO contacts VALUES (1034, 'Brigitte', 'Bouch', TO_DATE('1982-09-12', 'YYYY-MM-DD'), '5 Lukken Circle', 'Apt 1081', 'Vaughan', 'ON', 'L4L 8W3', 'bbouch@canmail.ca', 9051234599, 545678903)
    INTO contacts VALUES (1035, 'Jeanine', 'Tregensoe', TO_DATE('1985-12-22', 'YYYY-MM-DD'), '43445 Northland Circle', 'Apt 458', 'Markham', 'ON', 'L3R 9W6', 'jtregensoe@canmail.ca', 9051234500, 656789014)
    INTO contacts VALUES (1036, 'Brandea', 'Benedikt', TO_DATE('1989-02-18', 'YYYY-MM-DD'), '49114 Schmedeman Parkway', '14th Floor', 'Richmond Hill', 'ON', 'L4C 6Z1', 'bbenedikt@canmail.ca', 9051234501, 767890125)
    INTO contacts VALUES (1037, 'Radcliffe', 'Pirolini', TO_DATE('1987-05-27', 'YYYY-MM-DD'), '9 Marcy Center', 'Room 154', 'North York', 'ON', 'M2N 6L4', 'rpirolini@canmail.ca', 4161234502, 878901236)
    INTO contacts VALUES (1038, 'Wesley', 'Benbough', TO_DATE('1990-08-10', 'YYYY-MM-DD'), '4126 Buena Vista Place', 'Suite 5', 'Scarborough', 'ON', 'M1P 2P1', 'wbenbough@canmail.ca', 4161234503, 989012347)
    INTO contacts VALUES (1039, 'Puff', 'Bratchell', TO_DATE('1984-11-21', 'YYYY-MM-DD'), '798 Clemons Plaza', 'Room 1848', 'Etobicoke', 'ON', 'M9C 5H5', 'pbratchell@canmail.ca', 4161234504, 190123458)
    INTO contacts VALUES (1040, 'Joly', 'Perry', TO_DATE('1986-02-09', 'YYYY-MM-DD'), '49 Goodland Way', 'Room 1020', 'Oakville', 'ON', 'L6J 7C7', 'jperry@canmail.ca', 9051234505, 201234569)
SELECT * FROM DUAL;
COMMIT;


-- Insert data into EMPLOYEES table.
INSERT ALL
    INTO employees VALUES (2001, NULL, 1001, 4001, 'Branch Manager')
    INTO employees VALUES (2002, 2001, 1002, 4001, 'Assistant Manager')
    INTO employees VALUES (2003, 2001, 1003, 4001, 'Sales Associate')
    INTO employees VALUES (2004, NULL, 1004, 4002, 'Branch Manager')
    INTO employees VALUES (2005, 2004, 1005, 4002, 'Assistant Manager')
    INTO employees VALUES (2006, 2004, 1006, 4002, 'Sales Associate')
    INTO employees VALUES (2007, NULL, 1007, 4003, 'Branch Manager')
    INTO employees VALUES (2008, 2007, 1008, 4003, 'Assistant Manager')
    INTO employees VALUES (2009, 2007, 1009, 4003, 'Sales Associate')
    INTO employees VALUES (2010, NULL, 1010, 4004, 'Branch Manager')
    INTO employees VALUES (2011, 2010, 1011, 4004, 'Assistant Manager')
    INTO employees VALUES (2012, 2010, 1012, 4004, 'Sales Associate')
    INTO employees VALUES (2013, NULL, 1013, 4005, 'Branch Manager')
    INTO employees VALUES (2014, 2013, 1014, 4005, 'Assistant Manager')
    INTO employees VALUES (2015, 2013, 1015, 4005, 'Sales Associate')
    INTO employees VALUES (2016, NULL, 1016, 4006, 'Branch Manager')
    INTO employees VALUES (2017, 2016, 1017, 4006, 'Assistant Manager')
    INTO employees VALUES (2018, 2016, 1018, 4006, 'Sales Associate')
    INTO employees VALUES (2019, NULL, 1019, 4007, 'Branch Manager')
    INTO employees VALUES (2020, 2019, 1020, 4007, 'Assistant Manager')
SELECT * FROM DUAL;
COMMIT;


-- Insert data into CUSTOMERS table.
INSERT ALL
    INTO customers VALUES (3001, 1021)
    INTO customers VALUES (3002, 1022)
    INTO customers VALUES (3003, 1023)
    INTO customers VALUES (3004, 1024)
    INTO customers VALUES (3005, 1025)
    INTO customers VALUES (3006, 1026)
    INTO customers VALUES (3007, 1027)
    INTO customers VALUES (3008, 1028)
    INTO customers VALUES (3009, 1029)
    INTO customers VALUES (3010, 1030)
    INTO customers VALUES (3011, 1031)
    INTO customers VALUES (3012, 1032)
    INTO customers VALUES (3013, 1033)
    INTO customers VALUES (3014, 1034)
    INTO customers VALUES (3015, 1035)
    INTO customers VALUES (3016, 1036)
    INTO customers VALUES (3017, 1037)
    INTO customers VALUES (3018, 1038)
    INTO customers VALUES (3019, 1039)
    INTO customers VALUES (3020, 1040)
SELECT * FROM DUAL;
COMMIT;


-- Insert data into ACCOUNTS table.
INSERT ALL
    INTO accounts VALUES (5001, 4001, 3001, 1000.00, 'Savings', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Active', 1.5)
    INTO accounts VALUES (5002, 4002, 3002, 1500.00, 'Checking', TO_DATE('2022-05-01', 'YYYY-MM-DD'), 'Active', 1.0)
    INTO accounts VALUES (5003, 4003, 3003, 2000.00, 'Savings', TO_DATE('2021-08-15', 'YYYY-MM-DD'), 'Inactive', 1.5)
    INTO accounts VALUES (5004, 4004, 3004, 2500.00, 'Checking', TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'Active', 1.0)
    INTO accounts VALUES (5005, 4005, 3005, 2100.00, 'Savings', TO_DATE('2022-04-21', 'YYYY-MM-DD'), 'Inactive', 2.0)
    INTO accounts VALUES (5006, 4006, 3006, 3200.00, 'Checking', TO_DATE('2021-12-11', 'YYYY-MM-DD'), 'Active', 1.2)
    INTO accounts VALUES (5007, 4007, 3007, 1400.00, 'Savings', TO_DATE('2023-02-17', 'YYYY-MM-DD'), 'Inactive', 1.8)
    INTO accounts VALUES (5008, 4008, 3008, 1100.00, 'Checking', TO_DATE('2023-08-20', 'YYYY-MM-DD'), 'Active', 1.4)
    INTO accounts VALUES (5009, 4009, 3009, 2800.00, 'Savings', TO_DATE('2022-03-13', 'YYYY-MM-DD'), 'Active', 1.7)
    INTO accounts VALUES (5010, 4010, 3010, 1600.00, 'Checking', TO_DATE('2022-07-07', 'YYYY-MM-DD'), 'Inactive', 1.1)
    INTO accounts VALUES (5011, 4011, 3011, 2300.00, 'Savings', TO_DATE('2022-11-23', 'YYYY-MM-DD'), 'Active', 1.6)
    INTO accounts VALUES (5012, 4012, 3012, 1500.00, 'Checking', TO_DATE('2022-09-19', 'YYYY-MM-DD'), 'Active', 1.3)
    INTO accounts VALUES (5013, 4013, 3013, 2600.00, 'Savings', TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'Inactive', 1.9)
    INTO accounts VALUES (5014, 4014, 3014, 1700.00, 'Checking', TO_DATE('2021-10-10', 'YYYY-MM-DD'), 'Active', 1.2)
    INTO accounts VALUES (5015, 4015, 3015, 2200.00, 'Savings', TO_DATE('2023-06-06', 'YYYY-MM-DD'), 'Inactive', 1.5)
    INTO accounts VALUES (5016, 4016, 3016, 1800.00, 'Checking', TO_DATE('2022-12-01', 'YYYY-MM-DD'), 'Active', 1.8)
    INTO accounts VALUES (5017, 4017, 3017, 2400.00, 'Savings', TO_DATE('2023-01-02', 'YYYY-MM-DD'), 'Active', 1.3)
    INTO accounts VALUES (5018, 4018, 3018, 2000.00, 'Checking', TO_DATE('2023-04-04', 'YYYY-MM-DD'), 'Inactive', 1.6)
    INTO accounts VALUES (5019, 4019, 3019, 1900.00, 'Savings', TO_DATE('2022-02-02', 'YYYY-MM-DD'), 'Active', 3.4)
    INTO accounts VALUES (5020, 4020, 3020, 1900.00, 'Checking', TO_DATE('2022-02-02', 'YYYY-MM-DD'), 'Active', 3.4)
SELECT * FROM DUAL;
COMMIT;


-- Insert data to LOANS table.
-- Accounts  5005 and 5018 do not have any loans.
-- Account 5013 has specific data.
INSERT ALL
    INTO loans VALUES (6001, 5001, 2005, 1000000.00, 'Home Loan', 5.50, TO_DATE('2000-01-02', 'YYYY-MM-DD'), 360, 'Approved', 'Approved by Manager.')
    INTO loans VALUES (6002, 5002, 2002, 50000.00, 'Car Loan', 10.50, TO_DATE('2001-02-03', 'YYYY-MM-DD'), 60, 'Approved', 'Approved Manager.')
    INTO loans VALUES (6003, 5003, 2018, 1500.00, 'Personal Loan', 5.00, TO_DATE('2002-03-04', 'YYYY-MM-DD'), 6, 'Pending', 'Waiting for further documents.')
    INTO loans VALUES (6004, 5004, 2004, 15000.00, 'Education Loan', 3.00, TO_DATE('2003-04-05', 'YYYY-MM-DD'), 36, 'Rejected', 'Low credit score.')
    INTO loans VALUES (6005, 5006, 2005, 3000.00, 'Home Loan', 4.00, TO_DATE('2005-06-07', 'YYYY-MM-DD'), 120, 'Approved', 'Loan issued.')
    INTO loans VALUES (6006, 5007, 2006, 80000.00, 'Car Loan', 9.50, TO_DATE('2006-07-08', 'YYYY-MM-DD'), 48, 'Pending', 'Awaiting credit check.')
    INTO loans VALUES (6007, 5008, 2005, 2000.00, 'Personal Loan', 5.50, TO_DATE('2007-08-09', 'YYYY-MM-DD'), 12, 'Rejected', 'Incomplete documentation.')
    INTO loans VALUES (6008, 5009, 2004, 13000.00, 'Education Loan', 7.50, TO_DATE('2008-09-10', 'YYYY-MM-DD'), 60, 'Approved', 'Loan approved after verification.')
    INTO loans VALUES (6009, 5010, 2009, 650000.00, 'Home Loan', 4.50, TO_DATE('2009-10-11', 'YYYY-MM-DD'), 360, 'Pending', 'Under review.')
    INTO loans VALUES (6010, 5011, 2018, 30000.00, 'Car Loan', 5.00, TO_DATE('2010-11-12', 'YYYY-MM-DD'), 36, 'Approved', 'Loan approved by department.')
    INTO loans VALUES (6011, 5012, 2005, 50000.00, 'Personal Loan', 6.00, TO_DATE('2011-12-13', 'YYYY-MM-DD'), 48, 'Rejected', 'High risk profile.')
    INTO loans VALUES (6012, 5013, 2012, 777.77, 'Education Loan', 7.77, TO_DATE('2012-07-7', 'YYYY-MM-DD'), 7, 'Approved', 'Loan sanctioned.')
    INTO loans VALUES (6013, 5014, 2013, 555000.00, 'Home Loan', 4.00, TO_DATE('2013-02-15', 'YYYY-MM-DD'), 360, 'Pending', 'Awaiting final approval.')
    INTO loans VALUES (6014, 5015, 2014, 17000.00, 'Car Loan', 8.50, TO_DATE('2014-03-16', 'YYYY-MM-DD'), 36, 'Rejected', 'Loan rejected due to low income.')
    INTO loans VALUES (6015, 5016, 2004, 2500.00, 'Personal Loan', 5.50, TO_DATE('2015-04-17', 'YYYY-MM-DD'), 24, 'Approved', 'Loan approved.')
    INTO loans VALUES (6016, 5017, 2005, 8500.00, 'Education Loan', 3.00, TO_DATE('2016-05-18', 'YYYY-MM-DD'), 48, 'Pending', 'Under process.')
    INTO loans VALUES (6017, 5019, 2017, 400000.00, 'Home Loan', 4.50, TO_DATE('2018-07-20', 'YYYY-MM-DD'), 120, 'Rejected', 'Not meeting the criteria.')
    INTO loans VALUES (6018, 5020, 2018, 25000.00, 'Car Loan', 5.00, TO_DATE('2019-08-21', 'YYYY-MM-DD'), 60, 'Approved', 'Loan sanctioned.')
SELECT * FROM DUAL;
COMMIT;


-- Insert data to TRANSACTIONS table.
-- Accounts  5005 and 5018 do not have any transactions.
-- Account 5013 has specific data.
INSERT ALL
    INTO transactions VALUES (1, 5001, 'Deposit', 2500.25, TO_DATE('2000-01-01 01:30:15', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5001, 'Withdrawal', 500.50, TO_DATE('2000-01-01 02:30:45', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5002, 'Deposit', 3000.35, TO_DATE('2001-02-02 03:30:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5002, 'Withdrawal', 600.60, TO_DATE('2001-02-02 04:31:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5003, 'Deposit', 3500.45, TO_DATE('2002-03-03 05:31:15', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5003, 'Withdrawal', 700.70, TO_DATE('2002-03-03 06:31:45', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5004, 'Deposit', 4000.55, TO_DATE('2003-04-04 07:32:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5004, 'Withdrawal', 800.80, TO_DATE('2003-04-04 08:32:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5006, 'Deposit', 2000.75, TO_DATE('2005-06-06 11:34:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5006, 'Withdrawal', 400.95, TO_DATE('2005-06-06 12:34:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5007, 'Deposit', 1500.85, TO_DATE('2006-07-07 13:35:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5007, 'Withdrawal', 300.05, TO_DATE('2006-07-07 14:35:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5008, 'Deposit', 1000.95, TO_DATE('2007-08-08 15:36:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5008, 'Withdrawal', 200.15, TO_DATE('2007-08-08 16:36:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5009, 'Deposit', 5000.05, TO_DATE('2008-09-09 17:37:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5009, 'Withdrawal', 1000.25, TO_DATE('2008-09-09 18:37:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5010, 'Deposit', 3000.15, TO_DATE('2009-10-10 19:38:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5010, 'Withdrawal', 600.35, TO_DATE('2009-10-10 20:38:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5011, 'Deposit', 2500.25, TO_DATE('2010-11-11 21:39:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5011, 'Withdrawal', 500.45, TO_DATE('2010-11-11 22:39:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5012, 'Deposit', 4000.35, TO_DATE('2011-12-12 23:40:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5012, 'Withdrawal', 800.55, TO_DATE('2011-12-12 00:40:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5013, 'Deposit', 1.01, TO_DATE('2012-01-13 01:41:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5013, 'Withdrawal', 0.50, TO_DATE('2012-01-13 02:41:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5014, 'Deposit', 2000.55, TO_DATE('2013-02-14 03:42:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5014, 'Withdrawal', 400.75, TO_DATE('2013-02-14 04:42:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5015, 'Deposit', 1500.65, TO_DATE('2014-03-15 05:43:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5015, 'Withdrawal', 300.85, TO_DATE('2014-03-15 06:43:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5016, 'Deposit', 1000.75, TO_DATE('2015-04-16 07:44:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5016, 'Withdrawal', 200.95, TO_DATE('2015-04-16 08:44:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5017, 'Deposit', 5000.85, TO_DATE('2016-05-17 09:45:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5017, 'Withdrawal', 1000.05, TO_DATE('2016-05-17 10:45:30', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (1, 5018, 'Deposit', 3000.95, TO_DATE('2017-06-18 11:46:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5018, 'Withdrawal', 600.15, TO_DATE('2017-06-18 12:46:30', 'YYYY-MM-DD HH24:MI:SS'))    
    INTO transactions VALUES (1, 5020, 'Deposit', 4000.15, TO_DATE('2019-08-20 15:48:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO transactions VALUES (2, 5020, 'Withdrawal', 800.35, TO_DATE('2019-08-20 16:48:30', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM DUAL;
COMMIT;


-- Tables deletion
--DROP TABLE loans;
--DROP TABLE transactions;
--DROP TABLE accounts;
--DROP TABLE customers;
--DROP TABLE employees;
--DROP TABLE branches;
--DROP TABLE contacts;


-- Data deletion
--DELETE FROM transactions;
--DELETE FROM loans;
--DELETE FROM accounts;
--DELETE FROM employees;
--DELETE FROM branches;
--DELETE FROM accounts;
--DELETE FROM contacts;