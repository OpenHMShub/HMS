SELECT x.id, x.action, x.actionDate, x.actionBy, x.participantId, 
CONCAT(d.FirstName, ' ', d.middleName, ' ' , d.lastName) as participantName , 
CASE WHEN ( x.actionBY IS NULL or x.actionBy = -1) THEN COALESCE(x.userName, '')
ELSE CONCAT(h.firstname, ' ', h.lastName) END as staffName,
COALESCE( x.actionFields, '') as actionFields
FROM
  participant.RegistrationLog x JOIN participant.Dashboard d ON x.participantId = d.id 
LEFT JOIN staff.Employee staff ON x.actionBy = staff.id
LEFT JOIN humans.Human h ON h.id = staff.humanId
WHERE :startDate <= x.actionDate and :endDate >= x.actionDate
AND ( :action IS NULL OR :action = '' OR x.action = :action)
AND ( :staffId IS NULL OR x.actionBy = :staffId )
AND ( 
:searchText IS NULL 
OR :searchText = '' 
OR ( h.firstName like :searchText)
OR ( h.lastName like :searchText)
OR ( x.action like :searchText)
OR ( d.firstName like :searchText)
OR ( d.lastName like :searchText)

)
ORDER BY x.actionDate desc
