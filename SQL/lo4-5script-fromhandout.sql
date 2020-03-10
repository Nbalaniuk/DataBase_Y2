-- Create a simple table without constraints
CREATE TABLE Project(
    projectID NUMBER(4),
    name VARCHAR2(25),
    department VARCHAR2(100),
    maxHours NUMBER(6,1)
);

-- Delete a table
DROP TABLE Project;

-- DESC shows the structure of a table
DESC Project;

-- Query the meta data in the data dictionary
SELECT table_name FROM user_tables;
SELECT * FROM user_tables;
DESC user_tables;

-- recreate the table with constraints
CREATE TABLE Project(
    projectID NUMBER(4) PRIMARY KEY,
    name VARCHAR2(25) UNIQUE NOT NULL,
    department VARCHAR2(100) CHECK ((department = 'CST') OR (department = 'CADCAM')),
    maxHours NUMBER(6,1) DEFAULT 100
);

-- recreate the table with named constraints
DROP TABLE Project;
CREATE TABLE Project(
    projectID NUMBER(4) CONSTRAINT project_projectID PRIMARY KEY,
    name VARCHAR2(25) CONSTRAINT project_name_uk UNIQUE
                      CONSTRAINT project_name_nn NOT NULL,
    department VARCHAR2(100) CONSTRAINT project_department_cc CHECK ((department = 'CST') OR (department = 'CADCAM')),
    maxHours NUMBER(6,1) DEFAULT 100
);
-- named constraints, end of create table
CREATE TABLE Project(
    projectID NUMBER(4),
    name VARCHAR2(25),
    department VARCHAR2(100),
    maxHours NUMBER(6,1) DEFAULT 100,
    CONSTRAINT project_projectID PRIMARY KEY (projectID),
    CONSTRAINT project_name_uk UNIQUE (name),
    CONSTRAINT project_department_cc CHECK ((department = 'CST') OR (department = 'CADCAM')),
     CONSTRAINT project_name_nn CHECK (name IS NOT NULL)
);

-- data dictionary views
DESC Project;
SELECT * FROM user_constraints WHERE table_name = 'PROJECT';

SELECT * FROM user_tab_columns WHERE table_name = 'PROJECT';
SELECT * FROM user_indexes WHERE table_name = 'PROJECT';

--Create the assignment table
CREATE TABLE Assignment(
    projectID NUMBER(4) CONSTRAINT assignment_projectID_fk REFERENCES Project(projectID),
    employeeNumber NUMBER(3),
    hoursWorked NUMBER(5, 2) DEFAULT 10,
    CONSTRAINT assignment_projID_empNum_uk PRIMARY KEY (projectID, employeeNumber)
);
DROP TABLE Assignment;

-- create another table that is missing some things
CREATE TABLE Employee(
    employeeNumber NUMBER(3),
    firstName VARCHAR2(15) CONSTRAINT employee_firstname_nn NOT NULL,
    lastName VARCHAR2(15) CONSTRAINT employee_lastname_nn NOT NULL
);

--Alter Table
-- add a PK
ALTER TABLE Employee ADD CONSTRAINT employee_empNum_pk PRIMARY KEY (employeeNumber);
SELECT * FROM user_constraints;
-- delete one of the not null constraints
ALTER TABLE Employee DROP CONSTRAINT employee_firstName_nn;
-- add an FK
ALTER TABLE Assignment ADD CONSTRAINT assignment_empNum_fk FOREIGN KEY (employeeNumber) REFERENCES Employee(employeeNumber);

-- add a field
ALTER TABLE Project ADD (budget NUMBER(8, 2) DEFAULT 1000);
DESC Project;
ALTER TABLE Project DROP COLUMN budget;

--modify a field
ALTER TABLE Employee MODIFY (lastName VARCHAR2(30));
DESC Employee;
