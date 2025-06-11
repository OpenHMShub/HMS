/*---Employers/Activities/SelectSingleNote---*/
Declare @NoteID as int =  :NoteID ;

SELECT
	[organization].[ProviderNotes].note
FROM [organization].[ProviderNotes]
Where [organization].[ProviderNotes].id = @NoteID