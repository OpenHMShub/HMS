---Participants/DrugScreen/DrugScreenDashboardSelect---

DECLARE 
	@activity_range AS INT = :activity_range

--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
		,@activity_end AS DATE = DATEADD(day, 1 , getdate());

SELECT
	
	d.id,
	d.participantId,
	d.isActive,
	d.ssn,
	d.name,
	d.firstName,
	d.middleName,
	d.lastName,
	d.nickName,
	--d.testDate,
	--d.entryDate,
	(SELECT [participant].[DrugScreenLog].timeCreated FROM [participant].[DrugScreenLog] WHERE [participant].[DrugScreenLog].participantId = d.participantId AND [participant].[DrugScreenLog].id = d.id) AS 'entryDate',
	(SELECT [participant].[DrugScreenLog].TestDate FROM [participant].[DrugScreenLog] WHERE [participant].[DrugScreenLog].participantId = d.participantId AND [participant].[DrugScreenLog].id = d.id) AS 'testDate',
	d.drugScreenReasonId ,
	d.DrugScreenReasonName,
	d.drugScreenTypeId,
	d.drugScreenTypeName,
	d.passed,
	d.comments,
	d.enteredById,
	d.enteredByName,
	d.administerdById,
	d.administeredByName,
	p.veteranId,
	p.veteran

FROM
	 
	 participant.DrugScreenDashboard d
	 LEFT JOIN
		(select id, veteranId, veteran from participant.Dashboard) p ON d.participantId = p.id
	 
WHERE
	d.testDate between @activity_start and @activity_end
	AND {testDate} 
	AND {administeredById}
	AND {drugScreenResonId}
	AND {drugScreenTypeId}
	AND {passed}  
	AND {firstname}
	AND {middlename}
	AND {lastname}
	AND {nickname} 
	AND {veteran}
	AND {search}
	

ORDER BY d.testDate DESC