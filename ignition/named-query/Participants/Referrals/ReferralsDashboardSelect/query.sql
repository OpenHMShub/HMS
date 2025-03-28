/*Participants/Referrals/ReferralsDashboardSelect*/

DECLARE 
	@activity_range AS INT = :activity_range

--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
		,@activity_end AS DATE = DATEADD(day, 1 , getdate());
SELECT *, CASE WHEN checkOutDate is not NULL THEN exitDestinationInnerQ ELSE '' END AS exitDestination
FROM(
SELECT
	r.id
	,r.participantId
	,r.isActive
    ,r.name
    ,r.FirstName
    ,r.MiddleName
    ,r.LastName
    ,isNull(r.NickName,'') as 'NickName'
    ,r.[birthDate]
    ,r.age
    ,r.[referralDate]
	--,(SELECT TOP 1 timeCreated FROM [participant].[Referral] pr WHERE pr.participantId = r.participantId AND pr.ProgramId = r.ProgramId AND pr.Type_Id=r.referralTypeId) AS 'referralDate'
	,r.providerTypeId
	,r.providerType
	,r.providerId
	,r.providerName
	,r.referralTypeId
	,r.referralType
	,r.statusId
	,r.referralStatus
	,r.ProgramId
	,ISNULL(r.programName,'') AS 'programName'
	,(SELECT RIGHT(hh.SSN, 4) FROM [participant].[Participant] pp, [humans].[Human] hh WHERE pp.id = r.participantId AND pp.humanId = hh.id) as 'SSN'
	,ISNULL(r.ReasonForEntry,'') as 'ReasonForEntry'
	,ISNULL((SELECT TOP 1 timeCreated FROM participant.ReferralLog where ReferralId = r.id order by timeCreated desc),(SELECT timeCreated FROM [participant].[Referral] pr WHERE pr.id = r.id)) AS 'latestReferalDate'
	,ISNULL((SELECT TOP 1 Comment FROM participant.ReferralLog where ReferralId = r.id order by timeCreated desc),'') AS 'latestReferalComment'
	, r.checkinDate
	, (SELECT TOP 1 eventEnd FROM lodging.BedLog WHERE participantId = r.participantId AND eventStart = r.checkinDate order by eventEnd desc) as 'checkOutDate'
	,p.veteranId
	,p.veteran
	,COALESCE(res.exitDestination, '') as exitDestinationInnerQ
FROM 
	participant.ReferralDashboard  r
	LEFT JOIN
		(select id, veteranId, veteran from participant.Dashboard) p ON r.participantId = p.id
		
		
LEFT JOIN 
	(
		SELECT distinct res.participantId, res.programId, res.providerId,
		CASE WHEN bl.exitDestinationId IS NOT NULL THEN (SELECT destinationName from lodging.ExitDestination WHERE id = bl.exitDestinationId) ELSE '' 
		END AS exitDestination, res.timeCreated, res.referralId 
		FROM
		lodging.reservation res RIGHT JOIN lodging.bedLog bl ON res.bedId = bl.bedId and res.participantId = bl.participantId and bl.eventStart > res.timeCreated and bl.reservationId = res.id 
		WHERE res.reserVationEnd IS NOT NULL 
	) res ON res.participantId = r.ParticipantId AND res.programId = r.ProgramId and res.providerId = r.ProviderId AND (res.referralId is NULL OR  res.referralId = r.id )

WHERE
	r.referralDate between @activity_start and @activity_end AND
	{firstname} AND
 	{middlename} AND
 	{lastname} AND
 	{nickname} AND
 	{minage} AND
 	{maxage} AND
 	{birthdate} AND
 	{referraldate} AND
 	{referraltype} AND
 	{referralstatus} AND
 	{providertypeid} AND
 	{providerid} AND
 	{veteran} AND
 	{programid} ) x
-- 	AND {search}
WHERE {search}
ORDER BY 'referralDate' DESC;