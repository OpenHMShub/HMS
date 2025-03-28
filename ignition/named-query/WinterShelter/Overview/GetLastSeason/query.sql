
SELECT s.id,s.Seasons FROM shelter.Seasons s WHERE s.Seasons like '%' + LEFT((SELECT Seasons FROM shelter.Seasons where id = :seasonId),4)