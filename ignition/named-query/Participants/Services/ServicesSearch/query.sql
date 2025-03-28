---Participants/Services/ServicesDetailSelect---
SELECT
	p.programName AS 'program_name',
	s.ServiceTypeid  as 'type_id',
	st.serviceTypeName as 'service_type',
	s.serviceName AS 'service_name',
	s.id AS 'service_id',
	p.id AS 'program_id'
FROM
	[interaction].[service] s, [interaction].[program] p, [interaction].[serviceType] st, [interaction].[ProgramService] ps
	
WHERE 	
s.id = ps.serviceId AND s.serviceTypeId = st.id AND ps.programId = p.id
AND s.timeRetired IS NULL  AND st.timeRetired IS NULL and p.timeRetired IS NULL
AND s.serviceName LIKE  {searchText} 
order by p.programName
	
