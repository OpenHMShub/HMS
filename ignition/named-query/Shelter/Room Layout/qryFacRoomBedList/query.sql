Select f.facilityName, r.* from lodging.room r inner join
lodging.facility f on f.id = r.facilityId 
where facilityId = :Facility 