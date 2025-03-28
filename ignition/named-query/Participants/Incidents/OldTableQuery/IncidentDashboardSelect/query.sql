---Participants/Incidents/IncidentDashboardSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT
	i.id,
	i.participantId,
	i.name,
	i.firstName,
	i.middleName,
	i.lastName,
	i.nickName,
	i.ssn,
	FORMAT(i.incidentDate, 'd', 'us') AS 'incidentDate',
	i.incidentName,
	i.IncidentLocationTypeID,
	i.incidentLocationTypeName,
	LEFT(i.incidentDescription, 60) as 'incidentDescriptionTrunc',
	i.incidentDescription,
	i.physicalInjury,
	i.propertyDamage,
	i.suspension,
	i.timeCreated


FROM
	 participant.IncidentDashboard i
WHERE
	i.incidentDate between @activity_start and @activity_end
	AND {incidentDate}
	AND {injury}
	AND {damage}
	AND {suspension}  
	AND {locationId} 
	AND {firstName} 
 	AND {middleName}
 	AND {lastName}
 	AND {nickName}  
 	AND {search} 
 	
ORDER BY i.incidentDate DESC