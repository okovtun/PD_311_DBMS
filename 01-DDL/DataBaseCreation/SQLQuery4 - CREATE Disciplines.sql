USE PD_311_DDL;

CREATE TABLE ReportTypes
(
	report_type_id		TINYINT PRIMARY KEY,
	report_type_name	NVARCHAR(50) NOT NULL
);

CREATE TABLE Disciplines
(
	discipline_id		SMALLINT		PRIMARY KEY,
	discipline_name		NVARCHAR(256)	NOT NULL,
	number_of_lessons	SMALLINT		NOT NULL,
	report_type			TINYINT
	CONSTRAINT	FK_Disciplines_ReportTypes FOREIGN KEY REFERENCES ReportTypes(report_type_id)
);

CREATE TABLE DependentDisciplines
(
	target_discipline		SMALLINT,
	dependent_discipline	SMALLINT,
	PRIMARY KEY(target_discipline, dependent_discipline),
	CONSTRAINT FK_DependentFromDiscipline_Disciplines	FOREIGN KEY (target_discipline)		REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_DependentDiscipline_Disciplines		FOREIGN KEY (dependent_discipline)	REFERENCES Disciplines(discipline_id)
);

CREATE TABLE RequiredDisciplines
(
	target_discipline		SMALLINT,
	required_discipline		SMALLINT,
	PRIMARY KEY(target_discipline, required_discipline),
	CONSTRAINT FK_RequiredForDiscipline_Disciplines		FOREIGN KEY (target_discipline)		REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_RequiredDiscipline_Disciplines		FOREIGN KEY (required_discipline)	REFERENCES Disciplines(discipline_id)
);

CREATE TABLE DirectionsDisciplinesRelation
(
	direction		SMALLINT,
	discipline		SMALLINT,
	PRIMARY KEY		(direction, discipline),
	CONSTRAINT	FK_DDR_Direction	FOREIGN KEY (direction) REFERENCES Directions(direction_id),
	CONSTRAINT	FK_DDR_Discipline	FOREIGN KEY (discipline)REFERENCES Disciplines(discipline_id)
);

CREATE TABLE TeacherDisciplinesRelation
(
	teacher			INT,
	discipline		SMALLINT,
	PRIMARY KEY (teacher, discipline),
	CONSTRAINT	FK_TDR_Teacher		FOREIGN KEY (teacher)	REFERENCES Teachers(teacher_id),
	CONSTRAINT	FK_TDR_Discipline	FOREIGN KEY	(discipline)REFERENCES Disciplines(discipline_id)
);

CREATE TABLE CompleteDisciplines
(
	[group]			INT,
	discipline		SMALLINT,
	PRIMARY KEY	([group], discipline),
	CONSTRAINT	FK_CompleteDiscipline_Droups	FOREIGN KEY ([group])	REFERENCES Groups(group_id),
	CONSTRAINT	FK_CompleteDiscipline_for_Group	FOREIGN KEY (discipline)REFERENCES Disciplines(discipline_id)
);