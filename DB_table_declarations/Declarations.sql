CREATE TABLE STUDENT(
    SSN INT NOT NULL,
    ID INT NOT NULL,
    FIRSTNAME VARCHAR(50) NOT NULL,
    MIDDLENAME VARCHAR(50),
    LASTNAME VARCHAR(50) NOT NULL,
    RESIDENCY VARCHAR(10) NOT NULL,
    ENROLLMENT VARCHAR(10) NOT NULL,
    CONSTRAINT PK_STD PRIMARY KEY(ID)
);


CREATE TABLE DEPT(
    DEPT_NAME VARCHAR(50) NOT NULL,
    CONSTRAINT PK_DEPT PRIMARY KEY(DEPT_NAME)
);

CREATE TABLE FACULTY(
  FACULTY_NAME VARCHAR(50) NOT NULL,
  TITLE VARCHAR(50) NOT NULL,
  DEPT VARCHAR(50) NOT NULL,
  CONSTRAINT PK_FACULTY PRIMARY KEY(FACULTY_NAME),
  FOREIGN KEY (DEPT) references DEPT(DEPT_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DEGREE(
  DEGREE_NAME VARCHAR(50) NOT NULL,
  DEGREE_TYPE VARCHAR(50) NOT NULL,
  UNITS INT NOT NULL,
  DEPT VARCHAR(50) NOT NULL references DEPT(DEPT_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PK_DEGREE PRIMARY KEY(DEGREE_NAME,DEGREE_TYPE)
);

CREATE TABLE CATEGORY(
    CATE_NAME VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CATE PRIMARY KEY(CATE_NAME)
);

CREATE TABLE CATEGORY_DEGREE(
  CATE_NAME VARCHAR(50) NOT NULL references CATEGORY(CATE_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  MIN_UNIT INT NOT NULL,
    GPA REAL NOT NULL,
    MAJOR VARCHAR(50) NOT NULL,
    DEGREE_TYPE VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CATEDEGREE PRIMARY KEY(CATE_NAME,MAJOR,DEGREE_TYPE),
    FOREIGN KEY (MAJOR,DEGREE_TYPE) references DEGREE(DEGREE_NAME,DEGREE_TYPE)
    ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE COURSE(
    COURSE_ID VARCHAR(50) NOT NULL,
    COURSE_NAME VARCHAR(50) NOT NULL,
    MIN_UNIT INT NOT NULL,
    MAX_UNIT INT NOT NULL,
    DEPT VARCHAR(10) NOT NULL references DEPT(DEPT_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
    GRADE_OPTION VARCHAR(10) NOT NULL,
    LAB_REQUIRED VARCHAR(10) NOT NULL,
    INSTRUCTOR_CONSENT VARCHAR(10) NOT NULL,
    CURRENT_TAUGHT VARCHAR(50) NOT NULL,
    NEXT_QUARTER VARCHAR(50) NOT NULL,
    NEXT_YEAR INT NOT NULL,
    CONSTRAINT PK_COURSE PRIMARY KEY(COURSE_ID)
);


CREATE TABLE CONCENTRATION(
    CON_NAME VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CONNAME PRIMARY KEY(CON_NAME)
);

CREATE TABLE CONCENTRATION_LIST(
  CON_NAME VARCHAR(50) NOT NULL references CONCENTRATION(CON_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE VARCHAR(50) NOT NULL references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CATEGORY_LIST(
  CATE_NAME VARCHAR(50) NOT NULL references CATEGORY(CATE_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE VARCHAR(50) NOT NULL references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DEGREE_NAME VARCHAR(50) NOT NULL,
  DEGREE_TYPE VARCHAR(50) NOT NULL,
  FOREIGN KEY(DEGREE_NAME, DEGREE_TYPE) references DEGREE(DEGREE_NAME, DEGREE_TYPE)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PK_CATLIST PRIMARY KEY(CATE_NAME, COURSE, DEGREE_NAME, DEGREE_TYPE)
);


CREATE TABLE CONCENTRATION_DEGREE(
    CON_NAME VARCHAR(50) NOT NULL references CONCENTRATION(CON_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
    MIN_UNIT INT NOT NULL,
    GPA REAL NOT NULL,
    DEPT VARCHAR(50) NOT NULL,
    DEGREE_TYPE VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CONDEGREE PRIMARY KEY(CON_NAME,DEPT,DEGREE_TYPE),
    FOREIGN KEY (DEPT,DEGREE_TYPE) references DEGREE(DEGREE_NAME,DEGREE_TYPE)
    ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE UNDERGRAD(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COLLEGE VARCHAR(50) NOT NULL,
  MAJOR VARCHAR(50) NOT NULL,
  MINOR VARCHAR(50) NOT NULL,
  MAJOR_TYPE VARCHAR(50) NOT NULL,
  CONSTRAINT PK_UNDERGRAD PRIMARY KEY(PID),
  FOREIGN KEY (MAJOR,MAJOR_TYPE) references DEGREE(DEGREE_NAME,DEGREE_TYPE)
  ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE GRAD(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DEPT VARCHAR(50) NOT NULL references DEPT(DEPT_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  PROGRAM VARCHAR(50) NOT NULL,
  NUM_OF_COMMITTEE INT NOT NULL,
    ADVISOR VARCHAR(50) NOT NULL references FACULTY(FACULTY_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PK_GRAD PRIMARY KEY(PID)
);



CREATE TABLE PREREQ(
    COURSE_ID VARCHAR(50) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PREREQ_ID VARCHAR(50) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PK_PREREQ PRIMARY KEY(COURSE_ID,PREREQ_ID)
);

CREATE TABLE QUARTER_OFFERED(
    COURSE_ID VARCHAR(50) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    OFFERED_QUARTER VARCHAR(100) NOT NULL,
    CONSTRAINT PK_OFFERED PRIMARY KEY(COURSE_ID,OFFERED_QUARTER)
);


CREATE TABLE OWNED_DEGREE(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DEGREE VARCHAR(50) NOT NULL,
  UNIVERSITY VARCHAR(50) NOT NULL,
  CONSTRAINT PK_OWNED PRIMARY KEY(PID, DEGREE)
);



CREATE TABLE ATTENDANCE(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  START_QUARTER VARCHAR(50) NOT NULL,
  START_YEAR INT NOT NULL,
  END_QUARTER VARCHAR(50) NOT NULL,
  END_YEAR INT NOT NULL,
  CONSTRAINT PK_ATTEND PRIMARY KEY(PID, START_QUARTER, START_YEAR)
);

CREATE TABLE PROBATION(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CASE_ID INT NOT NULL,
  START_QUARTER VARCHAR(50) NOT NULL,
  START_YEAR INT NOT NULL,
  END_QUARTER VARCHAR(50) NOT NULL,
  END_YEAR INT NOT NULL,
  REASON VARCHAR(50) NOT NULL,
  CONSTRAINT PK_CASEID PRIMARY KEY(CASE_ID)
);


CREATE TABLE THESIS_COMMITTEE(
  PID INT NOT NULL references GRAD(PID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FACULTY VARCHAR(50) NOT NULL references FACULTY(FACULTY_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PK_COMMITTE PRIMARY KEY(PID, FACULTY)
);


CREATE TABLE CLASS(
    CLASS_ID INT NOT NULL,
    COURSE_ID VARCHAR(50) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    INSTRUCTOR VARCHAR(50) NOT NULL references FACULTY(FACULTY_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
    ENROLLMENT_LIMIT INT NOT NULL,
    QUARTER VARCHAR(50) NOT NULL,
    YEAR INT NOT NULL,
    CONSTRAINT PK_CLASS PRIMARY KEY(CLASS_ID)
);


CREATE TABLE ENROLLED_LIST(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE_ID VARCHAR(50) references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  GRADE_OPTION VARCHAR(50) NOT NULL,
  GRADE_RECEIVED VARCHAR(50) NOT NULL,
  UNIT INT NOT NULL,
  QUARTER VARCHAR(50) NOT NULL,
  YEAR INT NOT NULL,
  CONSTRAINT PK_ENROLLED PRIMARY KEY(CLASS_ID, PID)
);

CREATE TABLE ENROLL_CURRENT(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE_ID VARCHAR(50) references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  GRADE_OPTION VARCHAR(50) NOT NULL,
  UNIT INT NOT NULL,
  CONSTRAINT PK_ENROLLCURRENT PRIMARY KEY(CLASS_ID, PID)
);

CREATE TABLE WAIT_LIST(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  GRADE_OPTION VARCHAR(10) NOT NULL,
  UNIT INT NOT NULL,
  CONSTRAINT PK_WL PRIMARY KEY(CLASS_ID)
);

CREATE TABLE WEEKLY_MEETINGS(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
    REQUIRED VARCHAR(50) NOT NULL,
    TYPE VARCHAR(50) NOT NULL,
  DAY_WEEKLY VARCHAR(50) NOT NULL,
  START_WEEKLY TIME NOT NULL,
  END_WEEKLY TIME NOT NULL,
  ROOM_WEEKLY VARCHAR(50) NOT NULL,
  CONSTRAINT PK_WM PRIMARY KEY(CLASS_ID, DAY_WEEKLY, START_WEEKLY, END_WEEKLY, ROOM_WEEKLY)
);

CREATE TABLE REVIEW_SESSIONS(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DATE_REVIEW VARCHAR(50) NOT NULL,
  START_REVIEW TIME NOT NULL,
  END_REVIEW TIME NOT NULL,
  ROOM_REVIEW VARCHAR(50) NOT NULL,
  CONSTRAINT PK_REVIEW PRIMARY KEY(CLASS_ID, DATE_REVIEW, START_REVIEW, END_REVIEW, ROOM_REVIEW)
);

-- part4

-- 1.

DROP TRIGGER IF EXISTS LE_DI_LAB ON weekly_meetings;
DROP FUNCTION IF EXISTS LE_DI_LAB();

CREATE FUNCTION LE_DI_LAB() RETURNS trigger AS $LE_DI_LAB$
  BEGIN
    IF EXISTS(
      SELECT *
      FROM weekly_meetings w
      WHERE w.class_id = NEW.class_id AND NEW.day_weekly = w.day_weekly AND((NEW.start_weekly > w.start_weekly AND NEW.start_weekly < w.end_weekly) OR (NEW.end_weekly > w.start_weekly AND NEW.end_weekly < w.end_weekly) OR (NEW.start_weekly = w.start_weekly AND NEW.end_weekly = w.end_weekly))
    )
    THEN RAISE EXCEPTION 'TIME CONFLICT';
    END IF;
    RETURN NEW;
  END;
  $LE_DI_LAB$ LANGUAGE plpgsql;

CREATE TRIGGER LE_DI_LAB BEFORE INSERT OR UPDATE ON weekly_meetings
  FOR EACH ROW EXECUTE PROCEDURE LE_DI_LAB();


-- 3.

DROP TRIGGER IF EXISTS prof_time_conflict ON weekly_meetings;
DROP FUNCTION IF EXISTS prof_time_conflict();

CREATE FUNCTION prof_time_conflict() RETURNS trigger AS $prof_time_conflict$
  BEGIN
    IF EXISTS(
      SELECT *
      FROM weekly_meetings w, class c1, class c2
      WHERE NEW.class_id = c1.class_id AND c1.instructor = c2.instructor AND w.class_id = c2.class_id AND ((NEW.day_weekly = w.day_weekly AND NEW.start_weekly > w.start_weekly AND NEW.start_weekly < w.end_weekly) OR (NEW.day_weekly = w.day_weekly AND NEW.end_weekly > w.start_weekly AND NEW.end_weekly < w.end_weekly) OR (NEW.day_weekly = w.day_weekly AND NEW.start_weekly = w.start_weekly AND NEW.end_weekly = w.end_weekly))
    )
    THEN RAISE EXCEPTION 'PROF TIME CONFLICT';
    END IF;
    RETURN NEW;
  END;
  $prof_time_conflict$ LANGUAGE plpgsql;

CREATE TRIGGER prof_time_conflict BEFORE INSERT OR UPDATE ON weekly_meetings
  FOR EACH ROW EXECUTE PROCEDURE prof_time_conflict();

create table GRADE_CONVERSION
( LETTER_GRADE CHAR(2) NOT NULL,
NUMBER_GRADE DECIMAL(2,1)
);

insert into grade_conversion values('A+', 4.0);
insert into grade_conversion values('A', 4.0);
insert into grade_conversion values('A-', 3.7);
insert into grade_conversion values('B+', 3.3);
insert into grade_conversion values('B', 3.0);
insert into grade_conversion values('B-', 2.7);
insert into grade_conversion values('C+', 2.3);
insert into grade_conversion values('C', 2.0);
insert into grade_conversion values('C-', 1.7);
insert into grade_conversion values('D', 1.0);
insert into grade_conversion values('F', 0.0);

create table TIME_SLOT(
  BEGIN_TIME TIME NOT NULL,
  END_TIME TIME NOT NULL
);

insert into TIME_SLOT values('0800', '0900');
insert into TIME_SLOT values('0900', '1000');
insert into TIME_SLOT values('1000', '1100');
insert into TIME_SLOT values('1100', '1200');
insert into TIME_SLOT values('1200', '1300');
insert into TIME_SLOT values('1300', '1400');
insert into TIME_SLOT values('1400', '1500');
insert into TIME_SLOT values('1500', '1600');
insert into TIME_SLOT values('1600', '1700');
insert into TIME_SLOT values('1700', '1800');
insert into TIME_SLOT values('1800', '1900');
insert into TIME_SLOT values('1900', '2000');

INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (1, 1, 'Benjamin','', 'B', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (2, 2, 'Kristen', '', 'W', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (3, 3, 'Daniel', '', 'F', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (4, 4, 'Claire', '', 'J', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (5, 5, 'Julie','' , 'C', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (6, 6, 'Kevin', '', 'L', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (7, 7, 'Michael', '', 'B', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (8, 8, 'Joseph', '', 'J', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (9, 9, 'Devin','' , 'P', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (10, 10, 'Logan', '', 'F', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (11, 11, 'Vikram', '', 'N', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (12, 12, 'Rachel','' , 'Z', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (13, 13, 'Zach','' , 'M', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (14, 14, 'Justin', '', 'H', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (15, 15, 'Rahul','' , 'R', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (16, 16, 'Dave','' , 'C', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (17, 17, 'Nelson','' , 'H', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (18, 18, 'Andrew','' , 'P', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (19, 19, 'Nathan','' , 'S', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (20, 20, 'John','' , 'H', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (21, 21, 'Anwell','' , 'W', 'CA', 'YES');
INSERT INTO student(
  ssn, id, firstname, middlename, lastname, residency, enrollment)
  VALUES (22, 22, 'Tim','' , 'K', 'CA', 'YES');




INSERT INTO dept(
  dept_name)
  VALUES ('CSE');
INSERT INTO dept(
  dept_name)
  VALUES ('PHIL');
INSERT INTO dept(
  dept_name)
  VALUES ('MAE');


INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Justin Bieber', 'Associate Professor', 'CSE');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Flo Rida', 'Professor', 'PHIL');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Selena Gomez', 'Professor', 'MAE');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Adele', 'Professor', 'MAE');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Taylor Swift', 'Professor', 'CSE');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Kelly Clarkson', 'Professor', 'CSE');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Adam Levine', 'Professor', 'PHIL');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Bjork', 'Professor', 'CSE');
INSERT INTO faculty(
  faculty_name, title, dept)
  VALUES ('Unknown', 'Professor', 'CSE');




INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE8A', 'Introduction to Computer Science: Java', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'YES', 'sp', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE105', 'Intro to Theory', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'YES', 'fa', 2017);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE250A', 'Probabilistic Reasoning', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'NO', 'sp', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE250B', 'Machine Learning', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'NO', 'fa', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE255', 'Data Mining and Predictive Analytics', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'YES', 'wi', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE232A', 'Databases', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'NO', 'sp', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE221', 'Operating Systems', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'YES', 'fa', 2017);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('MAE3', 'UNKNOWN', 4, 4, 'MAE',   'ANY', 'NO', 'NO', 'NO', 'fa', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('CSE123', 'UNKNOWN', 4, 4, 'CSE', 'ANY', 'NO', 'NO', 'NO', 'fa', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('MAE107', 'Computational Methods', 4, 4, 'MAE', 'ANY', 'NO', 'NO', 'NO', 'sp', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('MAE108', 'Probability and Statistics', 4, 4, 'MAE', 'ANY', 'NO', 'NO', 'YES', 'fa', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('PHIL10', 'Intro to Logic', 4, 4, 'PHIL', 'ANY', 'NO', 'NO', 'NO', 'wi', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('PHIL12', 'Scientific Reasoning', 4, 4, 'PHIL', 'ANY', 'NO', 'NO', 'YES', 'sp', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('PHIL165', 'Freedom, Equality, and the Law', 4, 4, 'PHIL', 'ANY', 'NO', 'NO', 'YES', 'sp', 2018);
INSERT INTO course(
  course_id, course_name, min_unit, max_unit, dept, grade_option, lab_required, instructor_consent, current_taught, next_quarter, next_year)
  VALUES ('PHIL167', 'UNKNOWN', 4, 4, 'PHIL', 'ANY', 'NO', 'NO', 'NO', 'sp', 2018);


INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (1, 'MAE108', 'Adele', 2, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (2, 'CSE221', 'Kelly Clarkson', 5, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (3, 'CSE255', 'Flo Rida', 5, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (4, 'PHIL12', 'Adam Levine', 2, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (5, 'CSE221', 'Kelly Clarkson', 3, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (6, 'CSE105', 'Taylor Swift', 3, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (7, 'PHIL165', 'Taylor Swift', 3, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (8, 'MAE108', 'Selena Gomez', 1, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (9, 'CSE221', 'Justin Bieber', 2, 'sp', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (10, 'CSE8A', 'Adele', 5, 'sp', 2017);



INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (101, 'CSE8A', 'Justin Bieber', 100, 'fa', 2014);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (102, 'PHIL165', 'Flo Rida', 100, 'sp', 2016);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (103, 'CSE8A', 'Selena Gomez', 100, 'fa', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (105, 'CSE105', 'Taylor Swift', 100, 'wi', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (106, 'CSE8A', 'Kelly Clarkson', 100, 'sp', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (107, 'CSE250A', 'Bjork', 100, 'fa', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (108, 'PHIL10', 'Bjork', 100, 'fa', 2016);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (109, 'CSE250B', 'Justin Bieber', 100, 'wi', 2016);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (114, 'CSE232A', 'Kelly Clarkson', 100, 'fa', 2016);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (115, 'PHIL165', 'Adam Levine', 100, 'fa', 2016);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (116, 'MAE107', 'Bjork', 100, 'sp', 2016);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (118, 'MAE108', 'Selena Gomez', 100, 'wi', 2017);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (120, 'CSE250A', 'Bjork', 100, 'fa', 2014);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (110, 'CSE250B', 'Unknown', 100, 'wi', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (121, 'CSE255', 'Unknown', 100, 'fa', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (122, 'CSE232A', 'Unknown', 100, 'fa', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (123, 'CSE221', 'Unknown', 100, 'sp', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (124, 'MAE107', 'Unknown', 100, 'sp', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (125, 'MAE108', 'Unknown', 100, 'fa', 2014);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (126, 'MAE108', 'Unknown', 100, 'wi', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (127, 'PHIL10', 'Unknown', 100, 'fa', 2015);
INSERT INTO class(
  class_id, course_id, instructor, enrollment_limit, quarter, year)
  VALUES (128, 'PHIL165', 'Unknown', 100, 'fa', 2015);



INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (2, 'CSE221', 16, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (9, 'CSE221', 17, 'S/U',4 );
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (5, 'CSE221', 18, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (2, 'CSE221', 19, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (9, 'CSE221', 20, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (5, 'CSE221', 21, 'S/U', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (3, 'CSE255', 22, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (3, 'CSE255', 16, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (3, 'CSE255', 17, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (10, 'CSE8A', 1, 'S/U', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (10, 'CSE8A', 5, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (10, 'CSE8A', 3, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (1, 'MAE108', 7, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (1, 'MAE108', 8, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (8, 'MAE108', 9, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (6, 'CSE105', 4, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (4, 'PHIL12', 12, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (7, 'PHIL165', 13, 'S/U', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (4, 'PHIL12', 14, 'Letter Grade', 4);
INSERT INTO enroll_current(
  class_id, course_id, pid, grade_option, unit)
  VALUES (7, 'PHIL165', 15, 'Letter Grade', 4);

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (1, 'YES', 'LEC', 'MON', '1000', '1100', 'CENTER110');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (1, 'YES', 'LEC', 'WED', '1000', '1100', 'CENTER110');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (1, 'YES', 'LEC', 'FRI', '1000', '1100', 'CENTER110');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (2, 'YES', 'LEC', 'MON', '1000', '1100', 'CENTER111');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (2, 'YES', 'LEC', 'WED', '1000', '1100', 'CENTER111');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (2, 'YES', 'LEC', 'FRI', '1000', '1100', 'CENTER111');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (3, 'YES', 'LEC', 'MON', '1200', '1300', 'CENTER111');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (3, 'YES', 'LEC', 'WED', '1200', '1300', 'CENTER111');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (3, 'YES', 'LEC', 'FRI', '1200', '1300', 'CENTER111');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (4, 'YES', 'LEC', 'MON', '1200', '1300', 'CENTER112');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (4, 'YES', 'LEC', 'WED', '1200', '1300', 'CENTER112');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (4, 'YES', 'LEC', 'FRI', '1200', '1300', 'CENTER112');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (5, 'YES', 'LEC', 'MON', '1200', '1300', 'CENTER113');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (5, 'YES', 'LEC', 'WED', '1200', '1300', 'CENTER113');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (5, 'YES', 'LEC', 'FRI', '1200', '1300', 'CENTER113');


INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (6, 'YES', 'LEC', 'TUE', '1400', '1500', 'CENTER114');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (6, 'YES', 'LEC', 'THURS', '1400', '1500', 'CENTER114');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (7, 'YES', 'LEC', 'TUE', '1500', '1600', 'CENTER115');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (7, 'YES', 'LEC', 'THURS', '1500', '1600', 'CENTER115');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (8, 'YES', 'LEC', 'TUE', '1500', '1600', 'CENTER116');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (8, 'YES', 'LEC', 'THURS', '1500', '1600', 'CENTER116');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (9, 'YES', 'LEC', 'TUE', '1700', '1800', 'CENTER115');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (9, 'YES', 'LEC', 'THURS', '1700', '1800', 'CENTER115');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (10, 'YES', 'LEC', 'TUE', '1700', '1800', 'CENTER116');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (10, 'YES', 'LEC', 'THURS', '1700', '1800', 'CENTER116');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (6, 'YES', 'DIS', 'FRI', '1800', '1900', 'CENTER121');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (10, 'YES', 'DIS', 'WED', '1900', '2000', 'CENTER122');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (1, 'YES', 'DIS', 'TUE', '1000', '1100', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (1, 'YES', 'DIS', 'THURS', '1000', '1100', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (1, 'YES', 'LAB', 'FRI', '1800', '1900', 'CENTER122');


INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (2, 'YES', 'DIS', 'TUE', '1100', '1200', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (2, 'YES', 'DIS', 'THURS', '1100', '1200', 'CENTER122');


INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (4, 'YES', 'DIS', 'WED', '1300', '1400', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (4, 'YES', 'DIS', 'FRI', '1300', '1400', 'CENTER122');


INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (5, 'YES', 'DIS', 'TUE', '1200', '1300', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (5, 'YES', 'DIS', 'THURS', '1200', '1300', 'CENTER122');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (7, 'YES', 'DIS', 'THURS', '1300', '1400', 'CENTER122');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (8, 'YES', 'DIS', 'MON', '1500', '1600', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (8, 'YES', 'LAB', 'FRI', '1700', '1800', 'CENTER122');

INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (9, 'YES', 'DIS', 'MON', '0900', '1000', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (9, 'YES', 'DIS', 'FRI', '0900', '1000', 'CENTER122');


INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (10, 'YES', 'LAB', 'TUE', '1500', '1600', 'CENTER122');
INSERT INTO weekly_meetings(
  class_id, required, type, day_weekly, start_weekly, end_weekly, room_weekly)
  VALUES (10, 'YES', 'LAB', 'THURS', '1500', '1600', 'CENTER122');



insert into degree values('Computer Science', 'BS', 40, 'CSE');
insert into degree values('Philosophy', 'BA', 35, 'PHIL');
insert into degree values('Mechanical Engineering', 'BS', 50, 'MAE');
insert into degree values('Computer Science', 'MS', 45, 'CSE');

insert into CATEGORY values('lower');
insert into CATEGORY values('upper');
insert into CATEGORY values('technical');

insert into CATEGORY_DEGREE values('lower', 10, 1.0, 'Computer Science', 'BS');
insert into CATEGORY_DEGREE values('upper', 15, 1.0, 'Computer Science', 'BS');
insert into CATEGORY_DEGREE values('technical', 15, 1.0, 'Computer Science', 'BS');
insert into CATEGORY_DEGREE values('lower', 15, 1.0, 'Philosophy', 'BA');
insert into CATEGORY_DEGREE values('upper', 20, 1.0, 'Philosophy', 'BA');
insert into CATEGORY_DEGREE values('lower', 20, 1.0, 'Mechanical Engineering', 'BS');
insert into CATEGORY_DEGREE values('upper', 20, 1.0, 'Mechanical Engineering', 'BS');
insert into CATEGORY_DEGREE values('technical', 10, 1.0, 'Mechanical Engineering', 'BS');
insert into CONCENTRATION values('Databases');
insert into CONCENTRATION values('AI');
insert into CONCENTRATION values('Systems');
insert into CONCENTRATION_DEGREE values('Databases', 4, 3.0, 'Computer Science', 'MS');
insert into CONCENTRATION_DEGREE values('AI', 8, 3.1, 'Computer Science', 'MS');
insert into CONCENTRATION_DEGREE values('Systems', 4, 3.3, 'Computer Science', 'MS');
insert into CATEGORY_LIST values('technical', 'CSE250A', 'Computer Science', 'MS');
insert into CATEGORY_LIST values('technical', 'CSE221', 'Computer Science', 'MS');
insert into CATEGORY_LIST values('technical', 'CSE105', 'Computer Science', 'BS');
insert into CATEGORY_LIST values('technical', 'MAE107', 'Mechanical Engineering', 'BS');
insert into CATEGORY_LIST values('technical', 'MAE3', 'Mechanical Engineering', 'BS');
insert into CATEGORY_LIST values('lower', 'MAE3', 'Mechanical Engineering', 'BS');
insert into CATEGORY_LIST values('upper', 'MAE107', 'Mechanical Engineering', 'BS');
insert into CATEGORY_LIST values('upper', 'MAE108', 'Mechanical Engineering', 'BS');
insert into CATEGORY_LIST values('lower', 'CSE8A', 'Computer Science', 'BS');
insert into CATEGORY_LIST values('upper', 'CSE105', 'Computer Science', 'BS');
insert into CATEGORY_LIST values('upper', 'CSE123', 'Computer Science', 'BS');
insert into CATEGORY_LIST values('lower', 'PHIL10', 'Philosophy', 'BA');
insert into CATEGORY_LIST values('lower', 'PHIL12', 'Philosophy', 'BA');
insert into CATEGORY_LIST values('upper', 'PHIL165', 'Philosophy', 'BA');
insert into CATEGORY_LIST values('upper', 'PHIL167', 'Philosophy', 'BA');

insert into CONCENTRATION_LIST values('Databases', 'CSE232A');
insert into CONCENTRATION_LIST values('AI', 'CSE255');
insert into CONCENTRATION_LIST values('AI', 'CSE250A');
insert into CONCENTRATION_LIST values('Systems', 'CSE221');


insert into UNDERGRAD values(1, 'SIX', 'Computer Science', 'None', 'BS');
insert into UNDERGRAD values(2, 'SIX', 'Computer Science', 'None', 'BS');
insert into UNDERGRAD values(3, 'SIX', 'Computer Science', 'None', 'BS');
insert into UNDERGRAD values(4, 'SIX', 'Computer Science', 'None', 'BS');
insert into UNDERGRAD values(5, 'SIX', 'Computer Science', 'None', 'BS');
insert into UNDERGRAD values(6, 'SIX', 'Mechanical Engineering', 'None', 'BS');
insert into UNDERGRAD values(7, 'SIX', 'Mechanical Engineering', 'None', 'BS');
insert into UNDERGRAD values(8, 'SIX', 'Mechanical Engineering', 'None', 'BS');
insert into UNDERGRAD values(9, 'SIX', 'Mechanical Engineering', 'None', 'BS');
insert into UNDERGRAD values(10, 'SIX', 'Mechanical Engineering', 'None', 'BS');
insert into UNDERGRAD values(11, 'SIX', 'Philosophy', 'None', 'BA');
insert into UNDERGRAD values(12, 'SIX', 'Philosophy', 'None', 'BA');
insert into UNDERGRAD values(13, 'SIX', 'Philosophy', 'None', 'BA');
insert into UNDERGRAD values(14, 'SIX', 'Philosophy', 'None', 'BA');
insert into UNDERGRAD values(15, 'SIX', 'Philosophy', 'None', 'BA');

insert into grad values(16, 'CSE', 'MS', 3, 'Bjork');
insert into grad values(17, 'CSE', 'MS', 2, 'Bjork');
insert into grad values(18, 'CSE', 'MS', 3, 'Justin Bieber');
insert into grad values(19, 'CSE', 'MS', 3, 'Bjork');
insert into grad values(20, 'CSE', 'MS', 5, 'Bjork');
insert into grad values(21, 'CSE', 'MS', 3, 'Bjork');
insert into grad values(22, 'CSE', 'MS', 5, 'Bjork');


INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (101, 'CSE8A', 1, 'Letter Grade', 'A-', 4, 'fa', 2014);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (101, 'CSE8A', 3, 'Letter Grade', 'B+', 4, 'fa', 2014);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (106, 'CSE8A', 2, 'Letter Grade', 'C-', 4, 'sp', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (103, 'CSE8A', 4, 'Letter Grade', 'A-', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (103, 'CSE8A', 5, 'Letter Grade', 'B', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (105, 'CSE105', 1, 'Letter Grade', 'A-', 4, 'wi', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (105, 'CSE105', 5, 'Letter Grade', 'B+', 4, 'wi', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (105, 'CSE105', 4, 'Letter Grade', 'C', 4, 'wi', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (120, 'CSE250A', 16, 'Letter Grade', 'C', 4, 'fa', 2014);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (107, 'CSE250A', 22, 'Letter Grade', 'B+', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (107, 'CSE250A', 18, 'Letter Grade', 'D', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (107, 'CSE250A', 19, 'Letter Grade', 'F', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (110, 'CSE250B', 17, 'Letter Grade', 'A', 4, 'wi', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (110, 'CSE250B', 19, 'Letter Grade', 'A', 4, 'wi', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (121, 'CSE255', 20, 'Letter Grade', 'B-', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (121, 'CSE255', 18, 'Letter Grade', 'B', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (121, 'CSE255', 21, 'Letter Grade', 'F', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (122, 'CSE232A', 17, 'Letter Grade', 'A-', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (123, 'CSE221', 22, 'Letter Grade', 'A', 4, 'sp', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (123, 'CSE221', 20, 'Letter Grade', 'A', 4, 'sp', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (124, 'MAE107', 10, 'Letter Grade', 'B+', 4, 'sp', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (125, 'MAE108', 8, 'Letter Grade', 'B-', 2, 'fa', 2014);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (125, 'MAE108', 7, 'Letter Grade', 'A-', 2, 'fa', 2014);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (126, 'MAE108', 6, 'Letter Grade', 'B', 2, 'wi', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (126, 'MAE108', 10, 'Letter Grade', 'B+', 2, 'wi', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (127, 'PHIL10', 11, 'Letter Grade', 'A', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (127, 'PHIL10', 12, 'Letter Grade', 'A', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (127, 'PHIL10', 13, 'Letter Grade', 'C-', 4, 'fa', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (127, 'PHIL10', 14, 'Letter Grade', 'C+', 4, 'fa', 2015);

INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (128, 'PHIL165', 15, 'Letter Grade', 'F', 2, 'sp', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (128, 'PHIL165', 12, 'Letter Grade', 'D', 2, 'sp', 2015);
INSERT INTO enrolled_list(
  class_id, course_id, pid, grade_option, grade_received, unit, quarter, year)
  VALUES (128, 'PHIL165', 11, 'Letter Grade', 'A-', 2, 'fa', 2015);


INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('CSE8A', 'fa2014, sp2015, fa2015, fa2016, wi2016, wi2017');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('CSE105', 'wi2015, wi2016');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('CSE250A', 'fa2014, fa2015,wi2015, fa2016');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('CSE250B', 'wi2016, wi2015, fa2015');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('CSE255', 'fa2015, wi2016');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('CSE232A', 'fa2015');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('CSE221', 'sp2015, wi2016');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('MAE107', 'sp2015, sp2016');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('MAE108', 'fa2014, wi2015, wi2016, wi2017');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('PHIL10', 'fa2015, fa2016');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('PHIL12', 'wi2016');
INSERT INTO quarter_offered(
  course_id, offered_quarter)
  VALUES ('PHIL165', 'sp2015, fa2015, wi2016, sp2016, fa2016');



  CREATE FUNCTION check_limit() RETURNS trigger AS $check_limit$
  DECLARE
    limit_ int8;
  BEGIN
    limit_ = (SELECT class.ENROLLMENT_LIMIT from class where class.CLASS_ID = NEW.CLASS_ID);
    IF (TG_OP = 'Insert') THEN
      IF EXISTS(
        SELECT * FROM enroll_current WHERE enroll_current.CLASS_ID = NEW.CLASS_ID
      )
      THEN
        IF (SELECT COUNT(*) FROM enroll WHERE enroll_current.CLASS_ID = NEW.CLASS_ID) >= limit_
        THEN RAISE EXCEPTION 'the class limit exceeded!';
        END IF;
      END IF;
    ELSE
      IF limit_ <= (SELECT COUNT(*) FROM enroll_current WHERE enroll_current.CLASS_ID = NEW.CLASS_ID)
      THEN RAISE EXCEPTION 'the class limit exceeded!';
      END IF;
    END IF;
    RETURN NEW;
  END;
  $check_limit$ LANGUAGE plpgsql;

  CREATE TRIGGER check_limit BEFORE INSERT OR UPDATE ON enroll_current
      FOR EACH ROW EXECUTE PROCEDURE check_limit();

      CREATE TABLE CPQG AS (
        WITH newEnroll AS (SELECT c.COURSE_ID, c.INSTRUCTOR, c.QUARTER, c.YEAR, case when (e.GRADE_RECEIVED = 'A' or
        e.GRADE_RECEIVED = 'A+' or e.GRADE_RECEIVED = 'A-') then 'A' when e.GRADE_RECEIVED = 'B' or
        e.GRADE_RECEIVED = 'B+' or e.GRADE_RECEIVED = 'B-' then 'B' when e.GRADE_RECEIVED = 'C' or
        e.GRADE_RECEIVED = 'C+' or e.GRADE_RECEIVED = 'C-' then 'C' when e.GRADE_RECEIVED = 'D' then 'D'
        ELSE 'OTHER' END AS GRADE FROM class c
        INNER JOIN enrolled_list e ON c.CLASS_ID = e.CLASS_ID)
        SELECT COURSE_ID, INSTRUCTOR, QUARTER, YEAR, GRADE, COUNT(GRADE) AS COUNT_OF_GRADE
        FROM newEnroll
        GROUP BY COURSE_ID, INSTRUCTOR, QUARTER, YEAR, GRADE
      );

      CREATE TABLE CPG AS (
        WITH newEnroll AS (SELECT c.COURSE_ID, c.INSTRUCTOR, case when (e.GRADE_RECEIVED = 'A' or
        e.GRADE_RECEIVED = 'A+' or e.GRADE_RECEIVED = 'A-') then 'A' when e.GRADE_RECEIVED = 'B' or
        e.GRADE_RECEIVED = 'B+' or e.GRADE_RECEIVED = 'B-' then 'B' when e.GRADE_RECEIVED = 'C' or
        e.GRADE_RECEIVED = 'C+' or e.GRADE_RECEIVED = 'C-' then 'C' when e.GRADE_RECEIVED = 'D' then 'D'
        ELSE 'OTHER' END AS GRADE FROM class c
        INNER JOIN enrolled_list e ON c.CLASS_ID = e.CLASS_ID)
        SELECT COURSE_ID, INSTRUCTOR, GRADE, COUNT(GRADE) AS COUNT_OF_GRADE
        FROM newEnroll
        GROUP BY COURSE_ID, INSTRUCTOR, GRADE
      )


      CREATE FUNCTION check_update() RETURNS trigger AS $check_update$
      DECLARE
        conversion_grade_ varchar = '';
        old_grade_ varchar = '';
        prof_ varchar = '';
      BEGIN
        IF (TG_OP = 'INSERT') THEN
          IF NEW.GRADE_RECEIVED = 'A' or NEW.GRADE_RECEIVED = 'A-' or NEW.GRADE_RECEIVED = 'A+' THEN conversion_grade_ = 'A';
          ELSEIF NEW.GRADE_RECEIVED = 'B' or NEW.GRADE_RECEIVED = 'B-' or NEW.GRADE_RECEIVED = 'B+' THEN conversion_grade_ = 'B';
          ELSEIF NEW.GRADE_RECEIVED = 'C' or NEW.GRADE_RECEIVED = 'C-' or NEW.GRADE_RECEIVED = 'C+' THEN conversion_grade_ = 'C';
          ELSEIF NEW.GRADE_RECEIVED = 'D' THEN conversion_grade_ = 'D';
          ELSE conversion_grade_ = 'OTHER';
          END IF;
          -- IF NEW.GRADE_RECEIVED = 'B' THEN RAISE EXCEPTION 'HERE!';
          -- END IF;
          IF NEW.COURSE_ID IN (SELECT CPQG.COURSE_ID FROM CPQG WHERE CPQG.INSTRUCTOR IN (SELECT INSTRUCTOR FROM class WHERE CLASS_ID = NEW.CLASS_ID)
          AND CPQG.QUARTER = NEW.QUARTER AND CPQG.YEAR = NEW.YEAR AND conversion_grade_ = CPQG.GRADE) THEN
            UPDATE CPQG SET COUNT_OF_GRADE = COUNT_OF_GRADE + 1
            WHERE COURSE_ID = NEW.COURSE_ID AND INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = NEW.CLASS_ID)
            AND QUARTER = NEW.QUARTER AND YEAR = NEW.YEAR AND GRADE = conversion_grade_;
          ELSE
            prof_ = (SELECT INSTRUCTOR FROM class where CLASS_ID = NEW.CLASS_ID);
            INSERT INTO CPQG VALUES (NEW.COURSE_ID, prof_, NEW.QUARTER, NEW.YEAR, conversion_grade_, 1);
          END IF;
          IF NEW.COURSE_ID IN (SELECT CPG.COURSE_ID FROM CPG WHERE CPG.INSTRUCTOR IN (SELECT INSTRUCTOR FROM class WHERE CLASS_ID = NEW.CLASS_ID) AND
          conversion_grade_ = CPG.GRADE) THEN
            UPDATE CPG
            SET COUNT_OF_GRADE = COUNT_OF_GRADE + 1
            WHERE CPG.COURSE_ID = NEW.COURSE_ID AND CPG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = NEW.CLASS_ID)
            AND CPG.GRADE = conversion_grade_;
          ELSE
            prof_ = (SELECT INSTRUCTOR FROM class where CLASS_ID = NEW.CLASS_ID);
            INSERT INTO CPG VALUES (NEW.COURSE_ID, prof_, conversion_grade_, 1);
          END IF;
        ELSEIF (TG_OP = 'DELETE') THEN
          IF OLD.GRADE_RECEIVED = 'A' or OLD.GRADE_RECEIVED = 'A-' or OLD.GRADE_RECEIVED = 'A+' THEN old_grade_ = 'A';
          ELSEIF OLD.GRADE_RECEIVED = 'B' or OLD.GRADE_RECEIVED = 'B-' or OLD.GRADE_RECEIVED = 'B+' THEN old_grade_ = 'B';
          ELSEIF OLD.GRADE_RECEIVED = 'C' or OLD.GRADE_RECEIVED = 'C-' or OLD.GRADE_RECEIVED = 'C+' THEN old_grade_ = 'C';
          ELSEIF OLD.GRADE_RECEIVED = 'D' THEN old_grade_ = 'D';
          ELSE old_grade_ = 'OTHER';
          END IF;
          UPDATE CPQG
          SET COUNT_OF_GRADE = COUNT_OF_GRADE - 1
          WHERE CPQG.COURSE_ID = OLD.COURSE_ID AND CPQG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = OLD.CLASS_ID)
          AND CPQG.QUARTER = OLD.QUARTER AND CPQG.YEAR = OLD.YEAR AND CPQG.GRADE = old_grade_;
          UPDATE CPG
          SET COUNT_OF_GRADE = COUNT_OF_GRADE - 1
          WHERE CPG.COURSE_ID = OLD.COURSE_ID AND CPG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = OLD.CLASS_ID)
          AND CPG.GRADE = old_grade_;
        ELSEIF (TG_OP = 'UPDATE') THEN
          IF NEW.GRADE_RECEIVED = 'A' or NEW.GRADE_RECEIVED = 'A-' or NEW.GRADE_RECEIVED = 'A+' THEN conversion_grade_ = 'A';
          ELSEIF NEW.GRADE_RECEIVED = 'B' or NEW.GRADE_RECEIVED = 'B-' or NEW.GRADE_RECEIVED = 'B+' THEN conversion_grade_ = 'B';
          ELSEIF NEW.GRADE_RECEIVED = 'C' or NEW.GRADE_RECEIVED = 'C-' or NEW.GRADE_RECEIVED = 'C+' THEN conversion_grade_ = 'C';
          ELSEIF NEW.GRADE_RECEIVED = 'D' THEN conversion_grade_ = 'D';
          ELSE conversion_grade_ = 'OTHER';
          END IF;
          IF OLD.GRADE_RECEIVED = 'A' or OLD.GRADE_RECEIVED = 'A-' or OLD.GRADE_RECEIVED = 'A+' THEN old_grade_ = 'A';
          ELSEIF OLD.GRADE_RECEIVED = 'B' or OLD.GRADE_RECEIVED = 'B-' or OLD.GRADE_RECEIVED = 'B+' THEN old_grade_ = 'B';
          ELSEIF OLD.GRADE_RECEIVED = 'C' or OLD.GRADE_RECEIVED = 'C-' or OLD.GRADE_RECEIVED = 'C+' THEN old_grade_ = 'C';
          ELSEIF OLD.GRADE_RECEIVED = 'D' THEN old_grade_ = 'D';
          ELSE old_grade_ = 'OTHER';
          END IF;
          IF NEW.COURSE_ID IN (SELECT CPQG.COURSE_ID FROM CPQG WHERE CPQG.INSTRUCTOR IN (SELECT INSTRUCTOR FROM class WHERE CLASS_ID = NEW.CLASS_ID)
          AND conversion_grade_ = CPQG.GRADE) THEN
            UPDATE CPQG SET COUNT_OF_GRADE = COUNT_OF_GRADE + 1
            WHERE CPQG.COURSE_ID = NEW.COURSE_ID AND CPQG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = NEW.CLASS_ID)
            AND CPQG.QUARTER = NEW.QUARTER AND CPQG.YEAR = NEW.YEAR AND CPQG.GRADE = conversion_grade_;
            UPDATE CPQG SET COUNT_OF_GRADE = COUNT_OF_GRADE - 1
            WHERE CPQG.COURSE_ID = OLD.COURSE_ID AND CPQG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = OLD.CLASS_ID)
            AND CPQG.QUARTER = OLD.QUARTER AND CPQG.YEAR = OLD.YEAR AND CPQG.GRADE = old_grade_;
          ELSE
            prof_ = (SELECT INSTRUCTOR FROM class WHERE CLASS_ID = NEW.CLASS_ID);
            UPDATE CPQG SET COUNT_OF_GRADE = COUNT_OF_GRADE - 1
            WHERE CPQG.COURSE_ID = OLD.COURSE_ID AND CPQG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = OLD.CLASS_ID)
            AND CPQG.QUARTER = OLD.QUARTER AND CPQG.YEAR = OLD.YEAR AND CPQG.GRADE = old_grade_;
            INSERT INTO CPQG VALUES (NEW.COURSE_ID, prof_, NEW.QUARTER, NEW.YEAR, conversion_grade_, 1);
          END IF;
          IF NEW.COURSE_ID IN (SELECT CPG.COURSE_ID FROM CPG WHERE CPG.INSTRUCTOR IN (SELECT INSTRUCTOR FROM class WHERE CLASS_ID = NEW.CLASS_ID) AND
          conversion_grade_ = CPG.GRADE) THEN
            UPDATE CPG SET COUNT_OF_GRADE = COUNT_OF_GRADE + 1
            WHERE CPG.COURSE_ID = NEW.COURSE_ID AND CPG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = NEW.CLASS_ID)
            AND CPG.GRADE = conversion_grade_;
            UPDATE CPG SET COUNT_OF_GRADE = COUNT_OF_GRADE - 1
            WHERE CPG.COURSE_ID = OLD.COURSE_ID AND CPG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = OLD.CLASS_ID)
            AND CPG.GRADE = old_grade_;
          ELSE
            prof_ = (SELECT INSTRUCTOR FROM class where CLASS_ID = NEW.CLASS_ID);
            UPDATE CPG SET COUNT_OF_GRADE = COUNT_OF_GRADE - 1
            WHERE CPG.COURSE_ID = OLD.COURSE_ID AND CPG.INSTRUCTOR IN (SELECT class.INSTRUCTOR FROM class WHERE class.CLASS_ID = OLD.CLASS_ID)
            AND CPG.GRADE = old_grade_;
            INSERT INTO CPG VALUES (NEW.COURSE_ID, prof_, conversion_grade_, 1);
          END IF;
        END IF;
        RETURN NEW;
      END;
      $check_update$ LANGUAGE plpgsql;

      CREATE TRIGGER check_update AFTER INSERT OR UPDATE OR DELETE ON enrolled_list
          FOR EACH ROW EXECUTE PROCEDURE check_update();
