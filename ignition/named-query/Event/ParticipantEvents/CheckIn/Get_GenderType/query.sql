SELECT
	id
	,CASE WHEN genderAccepted = 'Men Only' THEN 'Male'
	WHEN genderAccepted = 'Women Only' THEN 'Female'
	WHEN genderAccepted = 'Men or Women on Different Nights' THEN 'Male or Female'
	WHEN genderAccepted = 'Men & Women Together' THEN 'Male and Female' END AS gender
FROM
	shelter.Gender 
ORDER BY genderAccepted