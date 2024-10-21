USE PD_311_DDL;
GO

CREATE TABLE Schedule
(
	lesson_id		BIGINT		PRIMARY KEY IDENTITY(1,1),
	[date]			DATE		NOT NULL,
	[time]			TIME		NOT NULL,
	[group]			INT			CONSTRAINT FK_Schedule_Groups		REFERENCES Groups(group_id),
	[discipline]	SMALLINT	CONSTRAINT FK_Schedule_Disciplines	REFERENCES Disciplines(discipline_id),
	teacher			INT			CONSTRAINT FK_Schedule_Teachers		REFERENCES Teachers(teacher_id),
	[subject]		NVARCHAR(256),
	spent			BIT			NOT NULL
);
GO

CREATE TABLE Grades
(
	student			INT			NOT NULL,
	lesson			BIGINT		NOT NULL,
	PRIMARY KEY	(student, lesson),
	CONSTRAINT FK_Grades_Students	FOREIGN KEY (student) REFERENCES Students(student_id),
	CONSTRAINT FK_Grades_Schedule	FOREIGN KEY (lesson)  REFERENCES Schedule(lesson_id),
	grade_1			TINYINT		CONSTRAINT CK_Lesson_Grade_1 CHECK (grade_1 > 0 AND grade_1 <= 12),
	grade_2			TINYINT		CONSTRAINT CK_Lesson_Grade_2 CHECK (grade_2 > 0 AND grade_2 <= 12)
);

CREATE TABLE Exams
(
	student			INT			NOT NULL,
	lesson			BIGINT		NOT NULL,
	PRIMARY KEY	(student, lesson),
	CONSTRAINT FK_Exams_Students	FOREIGN KEY (student) REFERENCES Students(student_id),
	CONSTRAINT FK_Exams_Schedule	FOREIGN KEY (lesson)  REFERENCES Schedule(lesson_id),
	grade			TINYINT		CONSTRAINT CK_Exam_Grade  CHECK (grade >= 0 AND grade <= 12)
);