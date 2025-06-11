UPDATE staff.Volunteer
SET volunteerGroupId=:groupId,isLeader=1
WHERE id=:volunteerId;