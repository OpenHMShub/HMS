SELECT COUNT(v.id)
FROM organization.Vendor v,  organization.VendorBusinessDescription vb
WHERE v.BusinessDescriptionID = vb.BusinessDescriptionID
AND v.timeRetired is NULL
AND ( :city IS NULL OR  :city = '' OR (v.city = :city))
AND ( :businessId IS NULL OR  :businessId = -1 OR (v.BusinessDescriptionID = :businessId))
AND ( v.city LIKE  {searchText} OR 
v.state LIKE  {searchText} OR
v.street LIKE  {searchText} OR
v.vendorName LIKE  {searchText} OR  
v.website LIKE  {searchText} OR  
v.email LIKE  {searchText} OR 
vb.BusinessDescription LIKE {searchText}
)