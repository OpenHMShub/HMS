SELECT distinct p.id, p.programName
FROM interaction.program p, lodging.FacilityAssociatedPrograms f
WHERE f.facilityId = :facilityId 
AND f.associatedProgramId = p.id AND f.timeRetired is NULL
ORDER by p.id