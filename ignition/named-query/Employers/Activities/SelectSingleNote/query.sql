/*---Employers/Activities/SelectSingleNote---*/
Declare @NoteID as int =  :NoteID ;

SELECT
	[organization].[EmployerNotes].note
FROM [organization].[EmployerNotes]
Where [organization].[EmployerNotes].id = @NoteID