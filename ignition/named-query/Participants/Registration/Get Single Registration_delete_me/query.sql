---Participants/Registration/Get Single Registration---
Select 
	[humans].[Human].id
,	[humans].[Human].firstName
,	[humans].[Human].middleName
,	[humans].[Human].lastName
,	[humans].[Human].nickname
,	[humans].[Human].dob
,	[humans].[Human].dobQuality
,	[humans].[Human].gender
,	[humans].[Human].ethnicity
,	[humans].[Human].race
,	[humans].[Human].disability
,	[humans].[Human].veteran
,	[humans].[Human].familyId
,	[humans].[Human].hohRelationship
,	[humans].[Human].phone
--,	FORMAT(Convert(bigint,[humans].[Human].phone), '(###) ###-####') as phone
,	[humans].[Human].email
,	[humans].[Human].emergencyContactName
,	[humans].[Human].emergencyContactPhone
--,	FORMAT(Convert(bigint,[humans].[Human].emergencyContactPhone), '(###) ###-####') as emergencyContactPhone
,	[humans].[Human].timeCreated
,	[humans].[Human].timeDeceased
,	[humans].[Human].timeRetired
,	[humans].SSN.id as ssnId
,	[humans].SSN.humanId
,	[humans].[SSN].ssn
--,	FORMAT(Convert(int,[humans].[SSN].ssn), '###-##-####') as ssn
,	[humans].SSN.ssnQuality
from [participant].Participant
Left Join [humans].Human
On [participant].Participant.humanId = [humans].Human.id
Left Join [humans].SSN
On [humans].Human.id = [humans].SSN.humanId
Where [participant].Participant.id = :participantID