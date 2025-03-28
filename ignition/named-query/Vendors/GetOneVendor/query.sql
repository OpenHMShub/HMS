SELECT v.vendorName as VendorName, vb.BusinessDescription, CONCAT(v.street, ' ', v.city, ' ', v.state) as Address, 
v.phone as Phone, v.website as Website, 
CASE WHEN v.timeRetired is NULL THEN 'ACTIVE' 
ELSE 'INACTIVE' END as Status,
v.timeCreated as VendorDateTime
FROM organization.Vendor v,  organization.VendorBusinessDescription vb
WHERE v.BusinessDescriptionID = vb.BusinessDescriptionID
AND v.id =  :vendorId 