insert into calendar.eventInstances (parentEventID,startDate,endDate,venue,room,note) 
OUTPUT INSERTED.instanceID
VALUES (:eventID,:startDate,:endDate,:venue,:room,'')