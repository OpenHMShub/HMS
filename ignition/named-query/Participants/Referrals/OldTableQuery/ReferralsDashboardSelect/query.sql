/*Participants/Referrals/ReferralsDashboardSelect*/

DECLARE 
	@activity_range AS INT = :activity_range

--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
		,@activity_end AS DATE = DATEADD(day, 1 , getdate());

SELECT
	r.id
	,r.participantId
    ,r.name
    ,r.FirstName
    ,r.MiddleName
    ,r.LastName
    ,r.NickName
    ,FORMAT(r.[birthDate], 'd', 'us') AS 'birthDate'
    ,r.age
    ,FORMAT(r.[referralDate], 'd', 'us') AS 'referralDate'
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

FROM 
	participant.ReferralDashboard  r

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
 	{programid} AND
 	{search}
  
ORDER BY 'referralDate' DESC;