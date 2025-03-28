UPDATE participant.Tasks
SET
	timeRetired = (getdate())
WHERE id =   :row_id  ;