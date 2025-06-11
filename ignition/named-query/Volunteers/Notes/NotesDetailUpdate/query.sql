UPDATE staff.VolunteerNotes
SET note = :note, noteDate = GETDATE(), userName = :userName
WHERE id = :id
