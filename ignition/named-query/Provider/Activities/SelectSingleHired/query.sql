---Employers/Activities/SelectSingleApplied---*/
Declare @HiredID as int = :hiredID ;
Declare @ParticipantID as int
Declare @Name as varchar(MAX)

SET @ParticipantID = (
	SELECT
	[organization].[ApplicantStatus].participantId
	FROM
	[organization].[ApplicantStatus]
	WHERE [organization].[ApplicantStatus].id = @HiredID
	)

SET @Name = (
	SELECT
	--	[participant].[Participant].id as 'participantID',
		CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName)
	FROM
		[participant].[Participant]
		INNER JOIN [humans].[Human] on [participant].[Participant].humanId = [humans].[Human].id
	WHERE [participant].[Participant].id =  @ParticipantID 
	)
	
SELECT
	@Name as 'participant'
,	[organization].[ApplicantStatus].position as 'position'
,	[organization].[ApplicantStatus].hiredComment as 'comment'
FROM 
	[organization].[ApplicantStatus]
Where [organization].[ApplicantStatus].id = @HiredID
