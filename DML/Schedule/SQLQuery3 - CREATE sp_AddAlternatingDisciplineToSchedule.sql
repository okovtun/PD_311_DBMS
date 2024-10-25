USE PD_311;
GO

--DROP PROCEDURE		sp_AddAlternatingDisciplineToSchedule;
--GO

CREATE PROCEDURE	sp_AddAlternatingDisciplineToSchedule
@group_name			NVARCHAR(50),
@discipline_name	NVARCHAR(256),
@start_date			DATE,
@start_time			TIME,
@teacher_last_name	NVARCHAR(150),
@constant_day		INT,
@alternate_day		INT
AS
BEGIN
	DECLARE @group		AS	INT			= (SELECT group_id		FROM Groups			WHERE group_name = @group_name);
	DECLARE @discipline	AS	SMALLINT	= (SELECT discipline_id FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	DECLARE @number_of_lessons	
						AS	SMALLINT	= (SELECT number_of_lessons FROM Disciplines	WHERE discipline_name LIKE @discipline_name);
	DECLARE @date		AS	DATE		= @start_date;
	DECLARE @teacher	AS	INT			= (SELECT teacher_id	FROM Teachers		WHERE last_name = @teacher_last_name);

	DECLARE @ca_interval INT = ABS(@constant_day - @alternate_day);
	DECLARE @alternate_present AS BIT = 0;
	DECLARE @lesson_number AS SMALLINT  = 0;

	PRINT (@group);
	PRINT (@discipline);
	PRINT (@number_of_lessons);
	PRINT (@date);
	PRINT (@teacher);
	PRINT (@ca_interval);

	WHILE @lesson_number < @number_of_lessons
	BEGIN
			PRINT (@lesson_number);
			PRINT (@date);
			PRINT (DATENAME(WEEKDAY, @date));
			PRINT ('------------------------');
			DECLARE @prelast_day AS DATE;
			IF(DATEPART(WEEKDAY, @date) = @constant_day)
			BEGIN
				IF(@constant_day < @alternate_day)
				BEGIN
					DECLARE @prelast_date AS DATE = (SELECT MAX([date]) FROM Schedule WHERE [date]<@date AND discipline=@discipline);
					SET @date = DATEADD(DAY, IIF(DATEPART(WEEKDAY, @prelast_date) = @constant_day, @ca_interval, 7),@date);
				END
				ELSE
				BEGIN
					SET @prelast_date = (SELECT MAX([date]) FROM Schedule WHERE [date]<@date AND DATEPART(WEEKDAY, [date]) = @alternate_day);
					SET @date = DATEADD(DAY, IIF(DATEDIFF(DAY, @prelast_date, @date) > 8, 7 - @ca_interval, 7), @date);
				END
				--SET @date = DATEADD(DAY, @ca_interval, @date);
				--SET @alternate_present = 0;
			END
			ELSE
			BEGIN
				SET @date = DATEADD(DAY, 7, @date);
				SET @alternate_present = 1;
			END
			SET @lesson_number = @lesson_number+2;
	END
END