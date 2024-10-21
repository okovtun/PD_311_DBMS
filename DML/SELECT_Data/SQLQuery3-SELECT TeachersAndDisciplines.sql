USE PD_311;
GO

SELECT
		[Ф.И.О.] = FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
		[Дисциплина] = discipline_name
FROM	Teachers, Disciplines, TeachersDisciplinesRelation
WHERE	teacher = teacher_id
AND		discipline = discipline_id
AND		discipline_name LIKE '%SQL%';
--ORDER BY [Дисциплина] DESC;