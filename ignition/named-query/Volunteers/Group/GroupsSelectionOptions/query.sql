select G.volunteerGroupName as 'label', G.id as 'value'
from staff.VolunteerGroup G
where G.timeRetired is NULL
ORDER by G.volunteerGroupName;