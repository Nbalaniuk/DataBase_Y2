--Exercise done on oct 15 in class

--CREATE TABLES
CREATE TABLE Major (
  majorID NUMBER(5) CONSTRAINT major_majordid_pk PRIMARY KEY,
  name VARCHAR2(30)
);

CREATE TABLE Department(
  deptID NUMBER(2) CONSTRAINT department_deptid_pk PRIMARY KEY,
  name VARCHAR2(25),
  deptHead NUMBER(3) CONSTRAINT department_depthead_nn NOT NULL 
);

CREATE TABLE Room_Categories (
  roomType CHAR(1) CONSTRAINT room_categories_roomtype_pk PRIMARY KEY,
  description VARCHAR2(9)
);

CREATE TABLE Course(
  courseID CHAR(6) CONSTRAINT course_courseid_pk PRIMARY KEY,
  title VARCHAR2(25),
  credits NUMBER(1) DEFAULT 3 CONSTRAINT course_credits_cc CHECK (credits >= 0)                    
);

CREATE TABLE Term(
  termID CHAR(4) CONSTRAINT term_termid_pk PRIMARY KEY,
  description VARCHAR(15),
  startDate DATE,
  endDate DATE
);

CREATE TABLE Room(
  roomID NUMBER(2) CONSTRAINT room_roomid_pk PRIMARY KEY,
  building VARCHAR(7),
  roomNo NUMBER(3),
  capacity NUMBER(2),
  roomType CHAR(1) CONSTRAINT room_roomtype_nn NOT NULL
                   CONSTRAINT room_roomtype_fk REFERENCES Room_Categories(roomType)
);

CREATE TABLE Student(
  studentID CHAR(5) CONSTRAINT student_studentid_pk PRIMARY KEY,
  firstName VARCHAR2(10),
  lastName VARCHAR2(10),
  street VARCHAR2(20),
  city VARCHAR2(10),
  province CHAR(2) DEFAULT 'SK',
  pCode CHAR(6),
  phone NUMBER(10),
  startTerm CHAR(4) CONSTRAINT student_startterm_nn NOT NULL
                    CONSTRAINT student_startterm_fk REFERENCES Term(termID),
  birthdate DATE,
  advisorID NUMBER(3), 
  majorID NUMBER(3) CONSTRAINT student_majorid_fk REFERENCES Major(majorID)
);

CREATE TABLE Faculty(
  facultyID NUMBER(3) CONSTRAINT faculty_facultyid_pk PRIMARY KEY,
  firstName VARCHAR2(10),
  lastName VARCHAR(10),
  phone NUMBER(3),
  roomID NUMBER(2) CONSTRAINT faculty_roomid_nn NOT NULL
                   CONSTRAINT faculty_rromid_fk REFERENCES Room(roomID),
  deptID NUMBER(1) CONSTRAINT faculty_deptid_nn NOT NULL                
);

CREATE TABLE Section (
	sectionID	NUMBER(4)	CONSTRAINT sectionPK PRIMARY KEY, 
	sectionNumber NUMBER(2), 
	day			CHAR(2)	
	  CONSTRAINT sectionDayCC CHECK ((day = 'MW') OR (day = 'TR') OR (day = 'F')), 
	startTime	DATE, 
	endTime		DATE, 
	capacity	NUMBER(2)	CONSTRAINT sectionCapacityCC CHECK (capacity >= 0), 
	actualEnrollment NUMBER(2) CONSTRAINT sectionEnrollmentCC 
                              CHECK (actualEnrollment >= 0), 
	termID		CHAR(4)	CONSTRAINT sectionTermIDNN NOT NULL
                    CONSTRAINT sectionTermFK REFERENCES Term(termID),
	courseID 	CHAR(6)	CONSTRAINT sectionCourseIDNN NOT NULL
                    CONSTRAINT sectionCourseFK REFERENCES Course(courseID), 
	facultyID	NUMBER(3)	CONSTRAINT sectionFacultyFK REFERENCES Faculty(facultyID), 
	roomID		NUMBER(2)	CONSTRAINT sectionRoomIDNN NOT NULL
                      CONSTRAINT sectionRoomFK REFERENCES Room(roomID),
                      CONSTRAINT Section_Time_cc CHECK(startTime < endTime)
	);

CREATE TABLE Grade(
  studentID CHAR(5) CONSTRAINT grade_studentid_nn NOT NULL
                    CONSTRAINT grade_studentid_fk REFERENCES Student(studentID),
  sectionID NUMBER(4) CONSTRAINT grade_sectionid_nn NOT NULL
                      CONSTRAINT grade_sectionid_fk REFERENCES Section(sectionID),
  midterm CHAR(1),
  final CHAR(1),
  CONSTRAINT grade_compositekey_pk PRIMARY KEY (studentID,sectionID)
);

-- Adding Fk's that could not be added before hand
ALTER TABLE Faculty ADD CONSTRAINT faculty_deptid_fk FOREIGN KEY(deptID) REFERENCES Department(deptID);
ALTER TABLE Student ADD CONSTRAINT student_advisorid_fk FOREIGN KEY(advisorID) REFERENCES Faculty(facultyID);
ALTER TABLE Department ADD CONSTRAINT department_deptHead_fk FOREIGN KEY(deptHead) REFERENCES Faculty(facultyID);


