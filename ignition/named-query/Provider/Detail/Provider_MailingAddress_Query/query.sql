SELECT concat(street,', ',city,', ',state,' ',zipcode)
FROM organization.Provider
Where organization.Provider.id =:trackID;