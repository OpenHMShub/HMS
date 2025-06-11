/*---Participants/Preview/Select Last Shelter---*/
Declare @participantID as int = :participantID;

with shelters as (
SELECT
	'reservation' as shelter_type,
	r.facility_name as 'facility',
	r.room_name as 'room',
	r.bed_name as 'bed',
	r.start_date as 'start',
	r.end_date as 'end'
from
	 participant.CurrentReservations r
where 
	r.participant_id = @participantID
union	
SELECT
	'active' as shelter_type,
	s.facility_name as 'facility',
	s.room_name as 'room',
	s.bed_name as 'bed',
	s.last_check_in as 'start',
	s.last_check_out as 'end'
from
	 participant.CurrentShelter s
where 
	s.participant_id = @participantID
)
Select top 1 * from shelters
order by start desc