SELECT

		count(sch.id) as 'bedsActual'
		 FROM shelter.LocationSeasonal ls
		 LEFT JOIN shelter.ScheduleParticipant sch ON ls.seasonId = sch.seasonId AND sch.locationId = ls.locationId
		 where ls.seasonId = :seasonId  and ls.locationId =  :locationId
		 and sch.timeRetired is NULL