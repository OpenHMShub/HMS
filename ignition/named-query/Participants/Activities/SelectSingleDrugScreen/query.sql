/*---Participants/Activities/SelectSingleDrugScreen---*/
Declare @DrugScreenLogID as int = :DrugScreenLogID;

SELECT
	[organization].[Provider].[providerName] as AdministeredBy
,	[participant].[DrugScreenReason].DrugScreenReasonName as Reason
,	[participant].[DrugScreenType].drugScreenTypeName as TestType
,	[participant].[DrugScreenLog].score as Score
,	[participant].[DrugScreenLog].gradeLevel as Grade
,	[participant].[DrugScreenLog].passed as Passed
,	[participant].[DrugScreenLog].comments as Comment
FROM [participant].[DrugScreenLog]
LEFT JOIN [participant].[DrugScreenType] 
on [participant].[DrugScreenLog].drugScreenTypeId = [participant].[DrugScreenType].id
LEFT JOIN [participant].[DrugScreenReason] 
on [participant].[DrugScreenLog].drugscreenreasonid = [participant].[DrugScreenReason].id
LEFT JOIN [organization].[Provider] 
on [participant].[DrugScreenLog].[providerId] = [organization].[Provider].[id]

WHERE [participant].[DrugScreenLog].id = @DrugScreenLogID
