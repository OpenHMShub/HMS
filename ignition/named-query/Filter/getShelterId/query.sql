SELECT
	id as 'id',
	facilityName as 'Facility Name'
FROM
	lodging.Facility
where timeRetired IS NULL
Order BY facilityName



