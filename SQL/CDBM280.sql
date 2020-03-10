--LO4 and LO5 DDL

--Create a basic table with no constraints
--Crtl Enter to run the command your cursor is in or the big play button
--The small play button runs all scripts

CREATE TABLE Project (
  projectID NUMBER(4),
  projName VARCHAR2(25),
  department VARCHAR2(100),
  maxHours Number (6,1)
);


--Describe the table
DESC Project;

--Select form table
SELECT * FROM Project;

DROP TABLE Project;
