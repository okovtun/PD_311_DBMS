USE PD_311_DDL;	--Выбираем Базу данных

CREATE TABLE Directions
(
	direction_id	SMALLINT		PRIMARY KEY,
	direction_name	NVARCHAR(150)	NOT NULL
);

CREATE TABLE Groups
(
	group_id		INT				PRIMARY KEY,
	group_name		NVARCHAR(16)	NOT NULL,
	direction		SMALLINT		NOT NULL
	CONSTRAINT	FK_Groups_Directions FOREIGN KEY REFERENCES Directions(direction_id)
);

CREATE TABLE Students
(
	student_id		INT PRIMARY KEY IDENTITY(1,1),
	last_name		NVARCHAR(150) NOT NULL,
	first_name		NVARCHAR(150) NOT NULL,
	middle_name		NVARCHAR(150),
	birth_date		DATE NOT NULL,
	[group]			INT
	CONSTRAINT FK_Students_Groups FOREIGN KEY REFERENCES Groups(group_id)
);