---Participants/Incidents/IncidentDashboardSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT
	i.id,
	i.participantId,
	i.isActive,
	i.name,
	i.firstName,
	i.middleName,
	i.lastName,
	isNull(i.nickName,'') as 'nickName',
	i.ssn,
	--i.incidentDate,
	(SELECT [participant].[IncidentLog].incidentDate FROM [participant].[IncidentLog] WHERE [participant].[IncidentLog].ParticipantID= i.participantId AND [participant].[IncidentLog].id = i.id) as 'incidentDate',
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