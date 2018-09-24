SELECT * FROM tblCourse;
SELECT * FROM tblStudent;
SELECT * FROM tblSemester;
SELECT * FROM tblInstructor;
SELECT * FROM tblCourseDetail;


DROP TABLE tblCourse;
DROP TABLE tblStudent;
DROP TABLE tblSemester;
DROP TABLE tblInstructor;
DROP TABLE tblCourseDetail;


CREATE TABLE tblCourse (
	CourseID NUMBER (38),
	CourseCode VARCHAR (6) NOT NULL,
	CONSTRAINT cse_CourseID_PK PRIMARY KEY(CourseID),
	CONSTRAINT cse_CourseID_CK CHECK (CourseID > 0),
	CONSTRAINT cse_CourseCode_UK UNIQUE (CourseCode)
);

CREATE TABLE tblStudent (
	StudentID NUMBER (38),
	StudentNumber VARCHAR (11) NOT NULL,
	StudentFname VARCHAR (20),
	StudentLname VARCHAR (20) NOT NULL,
	CONSTRAINT stu_StudentID_PK PRIMARY KEY (StudentID),
	CONSTRAINT stu_StudentID_CK CHECK (StudentID > 0),
	CONSTRAINT stu_StudentNumber_UK UNIQUE (StudentNumber)
);

CREATE TABLE tblInstructor (
	InstructorID NUMBER (38),
	InstructorNumber VARCHAR (15) NOT NULL,
	InstructorFname VARCHAR (25),
	InstructorLname VARCHAR (25) NOT NULL,
	CONSTRAINT inst_InstructorID_PK PRIMARY KEY (InstructorID),
	CONSTRAINT inst_InstructorID_CK CHECK (InstructorID > 0),
	CONSTRAINT inst_InstructorNumber_UK UNIQUE (InstructorNumber)
);

CREATE TABLE tblSemester(
	SemesterID NUMBER (38),
	SemesterCode VARCHAR (11) NOT NULL,
	SemesterYear NUMBER (4) NOT NULL,
	SemesterSeason VARCHAR (6) NOT NULL,
	CONSTRAINT sem_SemesterID_PK PRIMARY KEY (SemesterID),
	CONSTRAINT sem_SemesterID_CK CHECK (SemesterID > 0),
	CONSTRAINT sem_SemesterCode_UK UNIQUE (SemesterCode),
	CONSTRAINT sem_SemesterYear_CK CHECK (SemesterYear > 2000),
	CONSTRAINT sem_SemesterYear_UK UNIQUE (SemesterYear),
	CONSTRAINT sem_SemesterSeason_CK CHECK (SemesterSeason IN ('Fall','Winter','Summer'))
);

CREATE TABLE tblCourseDetail(
	CourseID NUMBER (38),
	StudentID NUMBER (38),
	SemesterID NUMBER (38),
	InstructorID Number (38),
	CourseGrade VARCHAR (2) NOT NULL,
	CourseFinalGrade NUMBER (5,2) NOT NULL,
	CONSTRAINT det_PK PRIMARY KEY (CourseID, StudentID, SemesterID, InstructorID),
	CONSTRAINT det_CourseID_FK FOREIGN KEY (CourseID)
	REFERENCES tblCourse(CourseID),
	CONSTRAINT det_StudentID_FK FOREIGN KEY (StudentID)
	REFERENCES tblStudent(StudentID),
	CONSTRAINT det_SemesterID_FK FOREIGN KEY (SemesterID)
	REFERENCES tblSemester(SemesterID),
	CONSTRAINT det_InstructorID_FK FOREIGN KEY (InstructorID)
	REFERENCES tblInstructor(InstructorID),
	CONSTRAINT det_CourseGrade_CK CHECK (CourseGrade IN ('F','D','D+','C','C+','B','B+','A','A+')),
	CONSTRAINT det_CourseFinalGrade_CK CHECK (CourseFinalGrade BETWEEN 0 AND 100)
);

ALTER TABLE tblCourse
ADD CourseDesc VARCHAR (35) NOT NULL;

ALTER TABLE tblSemester DROP UNIQUE (SemesterYear);

ALTER TABLE tblCourseDetail RENAME COLUMN CourseGrade to CourseLetterGrade;

ALTER TABLE tblCourseDetail RENAME CONSTRAINT det_CourseGrade_ck to det_CourseLetterGrade;

ALTER TABLE tblStudent 
    MODIFY(StudentFname VARCHAR(25), StudentLname VARCHAR(25));