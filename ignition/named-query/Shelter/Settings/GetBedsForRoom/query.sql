SELECT id,  bedName
FROM lodging.Bed
WHERE roomId = :roomId and timeRetired IS NULL
order by bedName