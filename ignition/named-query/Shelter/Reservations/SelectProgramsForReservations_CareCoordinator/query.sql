SELECT id as 'value' , programName as 'label'
FROM interaction.Program
WHERE timeRetired is null AND programName = 'Guest House'
order by programName