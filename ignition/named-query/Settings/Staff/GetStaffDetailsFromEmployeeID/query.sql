select h.email , CONCAT (h.firstname, ' ' , h.lastname) as name
from humans.Human h, Staff.Employee e
WHERE h.id = e.humanId and e.id =  :staffId 
