SELECT id as 'value' , providerTypeName as 'label'
FROM organization.providerType
WHERE timeRetired is null and providerTypeName not in ('Insurance','Presenter-Volunteer')
order by providerTypeName