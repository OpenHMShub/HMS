---Settings/Congregations/UpdateCongregationProviderInfo---
Update 
	organization.Provider 
Set  
	street = :address1
	,street2 = :address2 
	,city = :city 
	,state = 'TN'
	,zipCode = :zipCode 
	,phone = :phone
	,providerName = :providerName
Where
	id = :providerId 