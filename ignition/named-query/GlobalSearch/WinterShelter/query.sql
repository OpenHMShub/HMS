DECLARE
@stringLimit INT = 10 --Used to truncate strings for use in Dashboard (Change Here!!!)

SELECT
    id,
    options,
    Congregation_Name AS 'Name',
    Address AS 'Address',
    City,
    Zip_Code AS 'Zipcode',
    Phone_Number AS 'Phone',
    Phone_Number_we_can_use_to_reach_you_during_evening_hours AS 'Evening Phone',
    Office_Email AS 'Email',
    Preferred_Method_of_Communication AS 'Preferred Communication',
    CASE 
    	WHEN LEN(Comments)>=@stringLimit
    	THEN LEFT(Comments, @stringLimit) + '...' 
    	ELSE Comments END Comments,
    CASE 
    	WHEN LEN(Comments2)>=@stringLimit
    	THEN LEFT(Comments2, @stringLimit) + '...' 
    	ELSE Comments2 END Comments2,
    Coordinator_fName + ' ' + Coordinator_lName AS 'Coordinator',
    cCity,
    cZip_Code AS 'cZipcode',
    CASE 
    	WHEN LEN(cComments)>=@stringLimit
    	THEN LEFT(cComments, @stringLimit) + '...' 
    	ELSE cComments END cComments,
    cPrimary_Phone_Number AS 'cPhone',
    cEmail_Address AS 'cEmail',
    cHome_Address AS 'cAddress',
    Back_Up_Coordinator_fName + ' ' + Back_Up_Coordinator_lName AS 'Backup Coordinator1',
    Back_Up_Coordinator_fName2 + ' ' + Back_Up_Coordinator_lName2 AS 'Backup Coordinator2',
    bcCity,
    bcZip_Code AS 'bcZipcode',
    bcEmail_Address AS 'bcEmail',
    bcHome_Address AS 'bcAddress',
    bcPrimary_Phone_Number AS 'bcPhone',
    bcPreferred_Method_Of_Communication 'bcPreferred Communication',
    CASE 
    	WHEN LEN(Minister_Pastor_Congregation_Leader)>=@stringLimit
    	THEN LEFT(Minister_Pastor_Congregation_Leader, @stringLimit) + '...' 
    	ELSE Minister_Pastor_Congregation_Leader END AS 'Congregation Leader',
    CASE 
    	WHEN LEN(Night_s_of_the_Week_Hosting)>=@stringLimit
    	THEN LEFT(Night_s_of_the_Week_Hosting, @stringLimit) + '...' 
    	ELSE Night_s_of_the_Week_Hosting END AS 'Nights Hosted',
    Days_To_Host,
    Number_of_Days,
    Number_of_Guests,
    Phone_Number_we_can_use_to_reach_you_during_evening_hours AS 'Evening Phone',
    CASE 
    	WHEN LEN(Gender_of_Guests)>=@stringLimit
    	THEN LEFT(Gender_of_Guests, @stringLimit) + '...' 
    	ELSE Gender_of_Guests END AS 'Gender of Guests',
    Are_guests_required_to_climb_stairs AS 'Stairs',
    CASE 
    	WHEN LEN(List_other_congregations_organizations_that_work_with_your_congregation_to_host_Room_In_The_Inn)>=@stringLimit
    	THEN LEFT(List_other_congregations_organizations_that_work_with_your_congregation_to_host_Room_In_The_Inn, @stringLimit) + '...' 
    	ELSE List_other_congregations_organizations_that_work_with_your_congregation_to_host_Room_In_The_Inn END AS 'Partner Congregations in Hosting',
    Can_you_accommodate_a_guest_who_uses_a_wheelchair AS "Wheelchair Access",
    Is_a_designated_outdoor_smoking_area_provided AS 'Designated Smoking Area?',
    We_are_open_to_hosting_families_with_children AS 'Can Host Families',
    We_would_like_to_receive_a_reminder_call_in_the_week_before_our_scheduled_date_s_to_host AS "Reminder Call",
    CASE 
    	WHEN LEN(Our_congregation_might_be_able_to_do_more_host_more_guests_or_nights_if_we_had)>=@stringLimit
    	THEN LEFT(Our_congregation_might_be_able_to_do_more_host_more_guests_or_nights_if_we_had, @stringLimit) + '...' 
    	ELSE Our_congregation_might_be_able_to_do_more_host_more_guests_or_nights_if_we_had END AS 'Could do more if',      
    Our_congregation_is_able_to_host_extra_nights_on_short_notice_in_the_event_of_extreme_weather AS 'Extreme Weather',
    CASE 
    	WHEN LEN(Special_Services_Offered_Check_all_that_apply)>=@stringLimit
    	THEN LEFT(Special_Services_Offered_Check_all_that_apply, @stringLimit) + '...' 
    	ELSE Special_Services_Offered_Check_all_that_apply END AS 'Special Services',    
    CASE 
    	WHEN LEN(Comments_about_Dates_Selected)>=@stringLimit
    	THEN LEFT(Comments_about_Dates_Selected, @stringLimit) + '...' 
    	ELSE Comments_about_Dates_Selected END AS 'Date Comments',
    CASE 
    	WHEN LEN(Comments_for_the_Room_In_The_Inn_Staff)>=@stringLimit
    	THEN LEFT(Comments_for_the_Room_In_The_Inn_Staff, @stringLimit) + '...' 
    	ELSE Comments_for_the_Room_In_The_Inn_Staff END AS 'Comments for RITI',
    Submission_Date AS 'Submission Date',
    _2020_Projected AS '2020 Projected',
    Delimeter

FROM shelter.Totaltable
WHERE Submission_Date IS NOT NULL
ORDER BY Congregation_Name ASC