SELECT COALESCE(serviceName , '') as serviceName
FROM
interaction.Service
WHERE id =  :serviceId 