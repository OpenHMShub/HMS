IF :waitListName = 'All' 
BEGIN
SELECT distinct f.id as 'value' , f.facilityName as 'label'
FROM lodging.Facility f, lodging.FacilityAssociatedPrograms fp
WHERE f.timeRetired is null and f.id = fp.facilityId and fp.associatedProgramId in 
(
SELECT distinct wlp.programId 
FROM shelter.WaitList w, shelter.WaitListPrograms wlp 
where w.WaitListProgramId = wlp.id and w.dateremoved is null
)
END
ELSE
BEGIN
SELECT distinct f.id as 'value' , f.facilityName as 'label'
FROM lodging.Facility f, lodging.FacilityAssociatedPrograms fp
WHERE f.timeRetired is null and f.id = fp.facilityId and fp.associatedProgramId in 
(
SELECT distinct wlp.programId
FROM shelter.WaitList w, shelter.WaitListPrograms wlp, shelter.WaitListView wlv
where wlv.waitlist_id = w.id and w.WaitListProgramId = wlp.id and w.dateremoved is null and wlv.program_name = :waitListName
)

END