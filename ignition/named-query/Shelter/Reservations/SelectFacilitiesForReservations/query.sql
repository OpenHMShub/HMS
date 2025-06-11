SELECT id as 'value' , facilityName as 'label'
FROM lodging.Facility
WHERE timeRetired is null
order by facilityName