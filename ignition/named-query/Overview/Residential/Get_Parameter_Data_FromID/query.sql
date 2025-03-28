SELECT is_manual as edit, id ,parameter_display_value , parameter , july_value, aug_value, 
sept_value, oct_value, nov_value, dec_value,  jan_value, feb_value,   march_value ,  april_value, may_value , june_value,
july_value + aug_value + sept_value + oct_value + nov_value + dec_value + jan_value + feb_value + march_value + april_value + may_value + june_value as totalValue
FROM    participant.ResidentialDashboard 
WHERE id = :id