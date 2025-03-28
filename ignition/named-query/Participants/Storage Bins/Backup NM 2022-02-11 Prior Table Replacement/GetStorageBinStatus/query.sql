WITH rankedMessages AS (
	SELECT m.*, ROW_NUMBER() OVER (PARTITION BY Bin, Column1 ORDER BY ActionDate DESC, id DESC) AS rn
	FROM participant.StorageBin_History m
)
SELECT 
r.id AS id,
r.Action AS action,
r.ActionDate AS actionDate,
r.Column1 AS col,
r.Bin AS bin,
r.ParticipantId AS participantId,
p.first_name AS pfname,
p.middle_name AS pmname,
p.last_name AS plname,
r.StaffEmployee AS employeeId,
e.firstName AS efname,
e.middleName AS emname,
e.lastName AS elname
FROM rankedMessages r 
LEFT JOIN humans.GroupMembership p ON (r.ParticipantId = p.participant_id)
LEFT JOIN humans.human e ON (r.StaffEmployee = e.id)
WHERE rn = 1
ORDER BY col ASC, bin ASC, id DESC
