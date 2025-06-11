select --row_number() over (order by roomName) as tabs,
roomName from lodging.room where facilityID =  :FacID 