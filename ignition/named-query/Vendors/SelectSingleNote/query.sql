/*---Employers/Activities/SelectSingleNote---*/
Declare @NoteID as int =  :NoteID ;

SELECT
	[organization].[VendorNotes].note
FROM [organization].[VendorNotes]
Where [organization].[VendorNotes].id = @NoteID