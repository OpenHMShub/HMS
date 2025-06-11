SELECT TOP 1
[position]
,[Participant Name]
,[Participant Status]
,[statusTimeCreated]
,[Notes]
FROM organization.EmployerAction_FV
WHERE Employer = :employerID