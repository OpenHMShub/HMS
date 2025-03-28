SELECT id as 'value' , programName as 'label'
FROM interaction.Program
WHERE timeRetired is null AND programName != 'Permanent Supportive Housing'
order by programName