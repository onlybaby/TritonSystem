CREATE TABLE STUDENT(
    SSN INT NOT NULL,
    ID INT NOT NULL,
    FIRSTNAME VARCHAR(20) NOT NULL,
    MIDDLENAME VARCHAR(20),
    LASTNAME VARCHAR(20) NOT NULL,
    RESIDENCY VARCHAR(10) NOT NULL,
    ENROLLMENT VARCHAR(10) NOT NULL,
    CONSTRAINT PK_STD PRIMARY KEY(ID)
);


CREATE TABLE DEPT(
    DEPT_NAME VARCHAR(20) NOT NULL,
    CONSTRAINT PK_DEPT PRIMARY KEY(DEPT_NAME)
);

CREATE TABLE FACULTY(
  FACULTY_NAME VARCHAR(50) NOT NULL,
  TITLE VARCHAR(50) NOT NULL,
  DEPT VARCHAR(20) NOT NULL,
  CONSTRAINT PK_FACULTY PRIMARY KEY(FACULTY_NAME),
  FOREIGN KEY (DEPT) references DEPT(DEPT_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DEGREE(
  DEGREE_NAME VARCHAR(20) NOT NULL,
  DEGREE_TYPE VARCHAR(20) NOT NULL,
  UNITS INT NOT NULL,
  DEPT VARCHAR(20) NOT NULL references DEPT(DEPT_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PK_DEGREE PRIMARY KEY(DEGREE_NAME,DEGREE_TYPE)
);

CREATE TABLE CATEGORY(
    CATE_NAME VARCHAR(20) NOT NULL,
    CONSTRAINT PK_CATE PRIMARY KEY(CATE_NAME)
);

CREATE TABLE CATEGORY_DEGREE(
  CATE_NAME VARCHAR(20) NOT NULL references CATEGORY(CATE_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  MIN_UNIT INT NOT NULL,
    GPA REAL NOT NULL,
    MAJOR VARCHAR(20) NOT NULL,
    DEGREE_TYPE VARCHAR(20) NOT NULL,
    CONSTRAINT PK_CATEDEGREE PRIMARY KEY(CATE_NAME,MAJOR,DEGREE_TYPE),
    FOREIGN KEY (MAJOR,DEGREE_TYPE) references DEGREE(DEGREE_NAME,DEGREE_TYPE)
    ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE COURSE(
    COURSE_ID VARCHAR(20) NOT NULL,
    COURSE_NAME VARCHAR(50) NOT NULL,
    MIN_UNIT INT NOT NULL,
    MAX_UNIT INT NOT NULL,
    DEPT VARCHAR(10) NOT NULL references DEPT(DEPT_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
    GRADE_OPTION VARCHAR(10) NOT NULL,
    LAB_REQUIRED VARCHAR(10) NOT NULL,
    INSTRUCTOR_CONSENT VARCHAR(10) NOT NULL,
    CURRENT_TAUGHT VARCHAR(20) NOT NULL,
    NEXT_QUARTER VARCHAR(20) NOT NULL,
    NEXT_YEAR INT NOT NULL,
    CONSTRAINT PK_COURSE PRIMARY KEY(COURSE_ID)
);


CREATE TABLE CONCENTRATION(
    CON_NAME VARCHAR(20) NOT NULL,
    CONSTRAINT PK_CONNAME PRIMARY KEY(CON_NAME)
);

CREATE TABLE CONCENTRATION_LIST(
  CON_NAME VARCHAR(20) NOT NULL references CONCENTRATION(CON_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE VARCHAR(20) NOT NULL references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CATEGORY_LIST(
  CATE_NAME VARCHAR(20) NOT NULL references CATEGORY(CATE_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE VARCHAR(20) NOT NULL references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PK_CATLIST PRIMARY KEY(CATE_NAME, COURSE)
);


CREATE TABLE CONCENTRATION_DEGREE(
    CON_NAME VARCHAR(20) NOT NULL references CONCENTRATION(CON_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
    MIN_UNIT INT NOT NULL,
    GPA REAL NOT NULL,
    DEPT VARCHAR(20) NOT NULL,
    DEGREE_TYPE VARCHAR(20) NOT NULL,
    CONSTRAINT PK_CONDEGREE PRIMARY KEY(CON_NAME,DEPT,DEGREE_TYPE),
    FOREIGN KEY (DEPT,DEGREE_TYPE) references DEGREE(DEGREE_NAME,DEGREE_TYPE)
    ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE UNDERGRAD(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COLLEGE VARCHAR(20) NOT NULL,
  MAJOR VARCHAR(20) NOT NULL,
  MINOR VARCHAR(20) NOT NULL,
  MAJOR_TYPE VARCHAR(20) NOT NULL,
  CONSTRAINT PK_UNDERGRAD PRIMARY KEY(PID),
  FOREIGN KEY (MAJOR,MAJOR_TYPE) references DEGREE(DEGREE_NAME,DEGREE_TYPE)
  ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE GRAD(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DEPT VARCHAR(20) NOT NULL references DEPT(DEPT_NAME)
  ON UPDATE CASCADE ON DELETE CASCADE,
  PROGRAM VARCHAR(20) NOT NULL,
  NUM_OF_COMMITTEE INT NOT NULL,
    ADVISOR VARCHAR(20) NOT NULL references FACULTY(FACULTY_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PK_GRAD PRIMARY KEY(PID)
);



CREATE TABLE PREREQ(
    COURSE_ID VARCHAR(20) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PREREQ_ID VARCHAR(20) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PK_PREREQ PRIMARY KEY(COURSE_ID,PREREQ_ID)
);

CREATE TABLE QUARTER_OFFERED(
    COURSE_ID VARCHAR(20) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    OFFERED_QUARTER VARCHAR(20) NOT NULL,
    OFFERED_YEAR INT NOT NULL,
    CONSTRAINT PK_OFFERED PRIMARY KEY(COURSE_ID,OFFERED_QUARTER,OFFERED_YEAR)
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
  START_QUARTER VARCHAR(20) NOT NULL,
  START_YEAR INT NOT NULL,
  END_QUARTER VARCHAR(20) NOT NULL,
  END_YEAR INT NOT NULL,
  CONSTRAINT PK_ATTEND PRIMARY KEY(PID, START_QUARTER, START_YEAR)
);

CREATE TABLE PROBATION(
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CASE_ID INT NOT NULL,
  START_QUARTER VARCHAR(20) NOT NULL,
  START_YEAR INT NOT NULL,
  END_QUARTER VARCHAR(20) NOT NULL,
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
    COURSE_ID VARCHAR(20) NOT NULL references COURSE(COURSE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    INSTRUCTOR VARCHAR(20) NOT NULL references FACULTY(FACULTY_NAME)
    ON UPDATE CASCADE ON DELETE CASCADE,
    ENROLLMENT_LIMIT INT NOT NULL,
    QUARTER VARCHAR(20) NOT NULL,
    YEAR INT NOT NULL,
    CONSTRAINT PK_CLASS PRIMARY KEY(CLASS_ID)
);


CREATE TABLE ENROLLED_LIST(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE_ID VARCHAR(20) references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  GRADE_OPTION VARCHAR(20) NOT NULL,
  GRADE_RECEIVED VARCHAR(20) NOT NULL,
  UNIT INT NOT NULL,
  QUARTER VARCHAR(20) NOT NULL,
  YEAR INT NOT NULL,
  CONSTRAINT PK_ENROLLED PRIMARY KEY(CLASS_ID, PID)
);

CREATE TABLE ENROLL_CURRENT(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  COURSE_ID VARCHAR(20) references COURSE(COURSE_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  PID INT NOT NULL references STUDENT(ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  GRADE_OPTION VARCHAR(20) NOT NULL,
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
    REQUIRED VARCHAR(20) NOT NULL,
    TYPE VARCHAR(20) NOT NULL,
  DAY_WEEKLY VARCHAR(20) NOT NULL,
  START_WEEKLY TIME NOT NULL,
  END_WEEKLY TIME NOT NULL,
  ROOM_WEEKLY VARCHAR(20) NOT NULL,
  CONSTRAINT PK_WM PRIMARY KEY(CLASS_ID, DAY_WEEKLY, START_WEEKLY, END_WEEKLY, ROOM_WEEKLY)
);

CREATE TABLE REVIEW_SESSIONS(
  CLASS_ID INT NOT NULL references CLASS(CLASS_ID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DATE_REVIEW VARCHAR(20) NOT NULL,
  START_REVIEW TIME NOT NULL,
  END_REVIEW TIME NOT NULL,
  ROOM_REVIEW VARCHAR(20) NOT NULL,
  CONSTRAINT PK_REVIEW PRIMARY KEY(CLASS_ID, DATE_REVIEW, START_REVIEW, END_REVIEW, ROOM_REVIEW)
);
