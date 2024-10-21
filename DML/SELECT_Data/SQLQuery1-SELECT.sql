USE PD_311;
GO

SELECT  
		--last_name	AS N'Фамилия',
		--first_name	AS N'Имя',
		--middle_name AS N'Отчество',
		--------------------------------------------------------------
		--last_name + ' ' + first_name + ' ' + middle_name AS N'Ф.И.О.',
		--[Ф.И.О.] = last_name + ' ' + first_name + ' ' + middle_name,
		[Ф.И.О.] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
		birth_date	AS N'Дата рождения'
FROM	Teachers
--WHERE	birth_date > '1990-01-01'
--WHERE	first_name = N'Марина'
ORDER BY birth_date DESC  --ASC	(ASCENDING)  - Сортировка по возрастанию
						  --DESC(DESCENDING) - Сортировка по убыванию

--SELECT field1, field2, ..., fieldN
--FROM Table1, Table2, ....., TableN;