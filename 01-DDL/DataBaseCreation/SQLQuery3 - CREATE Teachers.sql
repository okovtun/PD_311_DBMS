USE PD_311_DDL;

CREATE TABLE Teachers
(
	teacher_id		INT PRIMARY KEY IDENTITY(1,1),
	last_name		NVARCHAR(150)	NOT NULL,
	first_name		NVARCHAR(150)	NOT NULL,
	middle_name		NVARCHAR(150),
	birth_date		DATE			NOT NULL,
	works_sice		DATE			NOT NULL,
	rate			MONEY			NOT NULL
);