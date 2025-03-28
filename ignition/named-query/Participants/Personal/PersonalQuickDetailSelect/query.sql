---Participants/Personal/PersonalQuickDetailSelect---
SELECT 
	CONCAT_WS(' ',h.firstName, h.middleName, h.lastName) as 'name'
	,h.nickname as 'nick_name'
	,h.trimorbid as 'tri_morbid'
	,h.chronicHomeless as 'chronic_homeless'
	,h.phone as 'phone'
	,h.altPhone as 'alt_phone'
	,h.email as 'email'
	,h.communicationTypeId as 'communication_type_id'
	,h.InsuranceTypeID as 'insurance_type_id'
	,hi.TypeName as 'insurance_type'
	,hc.communicationTypeName as 'communication_type'
	
FROM
	[humans].[Human] h
	INNER JOIN [participant].[Participant] p ON	p.humanId = h.id
	LEFT JOIN [humans].[InsuranceType] hi ON h.InsuranceTypeId = hi.id
	LEFT JOIN [humans].[CommunicationType] hc ON h.communicationTypeId = hc.id

WHERE
	p.id = :participant_id