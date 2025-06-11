/*---Participants/Activities/SelectSingleIncident---*/
Declare @IncidentID as int = :IncidentID;

SELECT
	[participant].[IncidentLocationType].incidentLocationTypeName as Location
,	'' as LocationDescription
,	[participant].[IncidentLog].incidentDescription as Incident
,	CASE WHEN isnull([participant].[IncidentLog].physicalInjury,0) = 0 THEN 'No' ELSE 'Yes' end as PhysicalInjury
,	CASE WHEN isnull([participant].[IncidentLog].propertyDamage,0) = 0 THEN 'No' ELSE 'Yes' end as PropertyDamage
,	CASE WHEN isnull([participant].[IncidentLog].barParticipant,0) = 0 THEN 'No' ELSE 'Yes' end as Suspension
FROM [participant].[IncidentLog]
LEFT JOIN [participant].[IncidentLocationType]
ON [participant].[IncidentLog].IncidentLocationTypeID = [participant].[IncidentLocationType].id
Where [participant].[IncidentLog].id = @IncidentID