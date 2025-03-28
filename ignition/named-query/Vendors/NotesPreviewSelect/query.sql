Declare @vendor_id as int =  :vendor_id ;

SELECT TOP 1
	organization.VendorNotes.note as note,
	organization.VendorNotes.userName as 'user',
	CONVERT(VARCHAR(10), organization.VendorNotes.timeCreated, 101) as Date,
  	CONVERT(VARCHAR(10), CAST(organization.VendorNotes.timeCreated AS TIME), 108) as Time
FROM
	organization.VendorNotes
WHERE 	
	organization.VendorNotes.vendorId =  @vendor_id 
ORDER BY organization.VendorNotes.timeCreated DESC
