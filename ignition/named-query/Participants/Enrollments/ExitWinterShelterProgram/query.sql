DELETE FROM participant.Enrollments
WHERE programId = (SELECT id FROM interaction.Program where programName = 'Winter Shelter')


UPDATE [participant].[ProgramsHistory]
SET ExitDate = GETDATE()
WHERE ExitDate IS NULL AND ProgramID = (SELECT id FROM interaction.Program where programName = 'Winter Shelter')

