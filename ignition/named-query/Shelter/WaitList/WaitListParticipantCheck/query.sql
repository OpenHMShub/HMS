SELECT
	w.[waitlist_id] as 'waitlist_id'
FROM  
	[shelter].[WaitListView] w
WHERE
	w.[participant_id] =  :participant_id 
	AND
	w.[waitlist_program_id ] =  :waitList_program_id 