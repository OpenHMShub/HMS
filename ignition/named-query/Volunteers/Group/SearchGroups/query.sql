SELECT top 100 
	G.id, G.volunteerGroupName as "name", G.volunteerGroupDescription as "description",
	(
		SELECT CONCAT(H.firstName,' ',H.middleName,' ',H.lastName)
		FROM staff.Volunteer V
		Inner join humans.Human H on V.humanId = H.id
		WHERE V.volunteerGroupId = G.id and V.isLeader = 1
	) as "leader",
	Count(V.volunteerGroupId) as "Member Count"
	FROM staff.VolunteerGroup G
	Left join staff.Volunteer V on G.id = V.volunteerGroupId
	WHERE not G.timeRetired IS not NULL
	and (G.volunteerGroupName LIKE CONCAT('%', :name, '%') OR g.volunteerGroupName IS NULL)
	AND (G.volunteerGroupDescription LIKE CONCAT('%', :description, '%') OR G.volunteerGroupDescription IS NULL)
	Group by G.volunteerGroupName, G.id, G.volunteerGroupDescription
	