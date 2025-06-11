Select 
	organization.EmployerNew.id as orgId,
  	[Status], 
	[Employer Name] as orgName,  
	[Business Description] as businessDesc,
  	organization.EmployerNew.Qualifiers,
	organization.EmployerNew.street,
  	organization.EmployerNew.city,  
  	organization.EmployerNew.state,  
  	organization.EmployerNew.zipCode, 
  	organization.EmployerNew.website,
  	organization.EmployerNew.phone,
  	organization.EmployerNew.email,
   	organization.EmployerNew.timeCreated
 
from organization.EmployerNew

Where organization.EmployerNew.id = :orgID