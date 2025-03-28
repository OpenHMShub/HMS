select CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as 'label', V.id as 'value'
from staff.Volunteer V
left join humans.Human H on V.humanId = H.id
where V.timeRetired is null
order by H.lastName;