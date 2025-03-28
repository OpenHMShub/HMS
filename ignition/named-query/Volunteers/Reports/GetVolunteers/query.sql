SELECT h.id, concat(h.firstname,' ', h.lastname) as Name, h.dob 
from humans.human h 
JOIN staff.volunteer v on v.humanid = h.id
order by 2 ASC