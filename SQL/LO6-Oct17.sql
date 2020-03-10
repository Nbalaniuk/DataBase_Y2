--LO6
--Basic insert
DESCRIBE Project;
INSERT INTO Project VALUES (5000, 'Q3 Portfolio Prep', 'CST', 75);
SELECT * FROM Project;
--Specify the fields
INSERT INTO Project (projectID,PRJNAME, department,maxhours) VALUES (5100, 'Q3 Portfolio Work','CST',75);

--Using defaults
--leave out from column list
INSERT INTO Project (projectID,PRJNAME, maxhours) VALUES (5200, 'Q4 Portfolio Work',75);

INSERT INTO Project (projectID,PRJNAME) VALUES (5300, 'Q4 Portfolio Prep');

--Can use DEFAULT and NULL keywords

INSERT INTO Project (projectID,PRJNAME, maxhours) VALUES (5400, 'Q5 Portfolio Work',DEFAULT);
INSERT INTO Project (projectID,PRJNAME, maxhours) VALUES (5500, 'Q5 Portfolio Prep',NULL);

--Undo the changes
ROLLBACK;


-- UPDATE
SELECT * FROM Publisher;
UPDATE Publisher SET city ='Atlanta', state ='GA';

ROLLBACK;

INSERT INTO Publisher VALUES (1000, 'CST', 'Box 1000', NULL, NULL);
UPDATE Publisher SET city='Saskatoo', state ='SK' WHERE pubid=1000;
UPDATE Publisher SET city = 'Saskatoon' WHERE city = 'Saskatoo';
--Increase all book royalties by an absolute 10% (then try a relative 10%)
SELECT * FROM RoySched;
--Increase royalties by an absolute 10%
UPDATE RoySched SET ROYALTY = ROYALTY+.1;
ROLLBACK;
--Increase royalties by a relative 10%
UPDATE RoySched SET ROYALTY = ROYALTY+ROYALTY/10;-- royalty*1.1;

--DELETE 
DELETE FROM PUBLISHER; -- Nothing deletes because of integrity constraint

DELETE FROM Publisher WHERE pubid=1000; -- will work, no child records

--INSERTING multiple rows
CREATE TABLE HiPriceTitles (
  titleID CHAR(6),
  title VARCHAR2(80),
  price NUMBER(9,2)
);

SELECT * FROM HiPriceTitles;
INSERT INTO HiPriceTitles SELECT titleID, title, price FROM Title WHERE price >35;

CREATE TABLE HiPriceTitles2 AS SELECT titleID, title, price FROM Title WHERE price > 35;
DESC HIPRICETITLES2;

SELECT * FROM USER_CONSTRAINTS;

ALTER TABLE HiPriceTitles2 MODIFY (titleID CHAR(6) PRIMARY KEY);

ROLLBACK; --creating table, or altering tables counts as a commit



--SEQUENCES

CREATE TABLE testSequence(
  testID NUMBER(4)
);

CREATE SEQUENCE simpleSequence;
--start at 1 and increase by 1
INSERT INTO testSequence VALUES(simpleSequence.CURRVAL);--this doesnt work because the user has not used the simpleSequence yet


INSERT INTO testSequence VALUES(simpleSequence.NEXTVAL);
SELECT * FROM testSequence;
DROP SEQUENCE simpleSequence;

--start at 100, go up by 10
CREATE SEQUENCE countingSequence START WITH 100 INCREMENT BY 10;
INSERT INTO testSequence VALUES(countingSequence.NEXTVAL);
--has a max
CREATE SEQUENCE maxSequence START WITH 100 INCREMENT BY 10 MAXVALUE 130;
INSERT INTO testSequence VALUES(maxSequence.NEXTVAL);

--add a cycle
CREATE SEQUENCE cycleSequence START WITH 100 INCREMENT BY 10 MAXVALUE 130 CYCLE NOCACHE;
INSERT INTO testSequence VALUES(cycleSequence.NEXTVAL);
SELECT * FROM USER_SEQUENCES;--data dictionary for sequences






















