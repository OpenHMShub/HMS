INSERT INTO staff.VolunteerNotes (category, note, timeCreated, noteDate, userName, volunteerId) 
VALUES (0, :note, GETDATE(), GETDATE(), :userName, :volunteerId)