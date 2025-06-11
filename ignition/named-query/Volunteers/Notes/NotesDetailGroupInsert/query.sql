INSERT INTO staff.VolunteerNotes (category, note, timeCreated, noteDate, userName, groupId) 
VALUES (0, :note, GETDATE(), GETDATE(), :userName, :groupId)