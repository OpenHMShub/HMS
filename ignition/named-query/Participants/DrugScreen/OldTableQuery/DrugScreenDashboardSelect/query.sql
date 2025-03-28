---Participants/DrugScreen/DrugScreenDashboardSelect---

DECLARE 
	@activity_range AS INT = :activity_range

--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
		,@activity_end AS DATE = DATEADD(day, 1 , getdate());

SELECT
	
	d.id,
	d.participantId,
	d.ssn,
	d.name,
	d.firstName,
	d.middleName,
	d.lastName,
	d.nickName,
	FORMAT(d.testDate, 'd', 'us') AS 'testDate',
	FORMAT(d.entryDate, 'd', 'us') AS 'entryDate',
	d.drugScreenReasonId ,
	d.DrugScreenReasonName,
	d.drugScreenTypeId,
	d.drugScreenTypeName,
	d.passed,
	d.comments,
	d.enteredById,
	d.enteredByName,
	d.administerdById,
	d.administeredByName 

FROM
	 
	 participant.DrugScreenDashboard d
	 
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
	AND {search}
	

ORDER BY d.testDate DESC