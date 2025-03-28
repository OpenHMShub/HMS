---Settings/Staff/UpdateStaffHuman---
Update 
	humans.Human 
Set 
	 firstName = :firstName, 
	 middleName = :middleName,
	 lastName = :lastName, 
	 suffix = :suffix, 
	 dob = :dob,
	 genderId = :genderId, 
	 phone = :phone, 
	 altPhone = :altPhone, 
	 email = :email, 
	 timeRetired = :timeRetired 
Where
	id = :humanId 