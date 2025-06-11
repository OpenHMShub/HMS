SELECT id as 'value' , programName as 'label'
FROM interaction.Program
WHERE timeRetired is null
order by programName