UPDATE lodging.BedLog SET eventEnd = :checkOutDate, exitDestinationId = :exitDestinationId, exit_ProviderId = :exit_ProviderId  WHERE id = :id

DELETE FROM participant.Enrollments
WHERE particpantId =  (SELECT participantId FROM lodging.BedLog WHERE id = :id)
AND programId in (SELECT r.ProgramId from lodging.bedLog b, lodging.Reservation r where b.reservationId = r.id and b.id = :id 
				AND r.ProgramId NOT in (select id FROM interaction.Program where programName in ('Campus Store','Guest House','Hope University','Paticipant Mail Service')))

UPDATE [participant].[ProgramsHistory]
SET ExitDate = GETDATE()
WHERE ExitDate IS NULL 
AND ParticipantID = (SELECT participantId FROM lodging.BedLog WHERE id = :id)
AND ProgramID IN (SELECT r.ProgramId from lodging.bedLog b, lodging.Reservation r where b.reservationId = r.id and b.id = :id
				AND r.ProgramId NOT in (select id FROM interaction.Program where programName in ('Campus Store','Guest House','Hope University','Paticipant Mail Service')))


