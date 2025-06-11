SELECT 
	F.id,
	eventFacilitators.facilitatorID,
	CASE
		WHEN isNull(H.middleName, '') = '' THEN CONCAT(H.firstName, ' ', H.lastName)
		ELSE CONCAT(H.firstName, ' ', H.middleName, ' ', H.lastName)
	END as name
FROM
	calendar.eventInstanceFacilitators as eventFacilitators
	LEFT JOIN staff.Facilitator as F ON F.id = eventFacilitators.facilitatorID
	LEFT JOIN staff.Employee as E ON E.id = F.employeeId
	LEFT JOIN humans.Human as H ON H.id = E.humanId
WHERE
	eventFacilitators.instanceID = :instanceID