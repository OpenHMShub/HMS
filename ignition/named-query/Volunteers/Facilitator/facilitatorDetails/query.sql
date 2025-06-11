SELECT F.id, H.firstName, H.lastName, H.phone, H.email, E.jobTitle, H.employer, H.id as "humanId",
	(Select top 1 P.placeName
		from (
			SELECT
		    ROW_NUMBER() OVER (ORDER BY P.placeName ASC) AS rownumber,
		    P.placeName, P.facilitatorId
		  	FROM staff.Places P
		  	Where P.facilitatorId = F.id
		) P
		where P.rownumber > 0
	) as "assignmentOne",
	(Select top 1 P.placeName
		from (
			SELECT
		    ROW_NUMBER() OVER (ORDER BY P.placeName ASC) AS rownumber,
		    P.placeName, P.facilitatorId
		  	FROM staff.Places P
		  	Where P.facilitatorId = F.id
		) P
		where P.rownumber > 1
	) as "assignmentTwo",
	(Select top 1 P.placeName
		from (
			SELECT
		    ROW_NUMBER() OVER (ORDER BY P.placeName ASC) AS rownumber,
		    P.placeName, P.facilitatorId
		  	FROM staff.Places P
		  	Where P.facilitatorId = F.id
		) P
		where P.rownumber > 2
	) as "assignmentThree",
	(Select top 1 P.placeName
		from (
			SELECT
		    ROW_NUMBER() OVER (ORDER BY P.placeName ASC) AS rownumber,
		    P.placeName, P.facilitatorId
		  	FROM staff.Places P
		  	Where P.facilitatorId = F.id
		) P
		where P.rownumber > 3
	) as "assignmentFour"
FROM staff.Facilitator F
Inner join staff.Employee E on F.employeeId = E.id
Inner join humans.Human H on E.humanId = H.id
Where F.id = :id;