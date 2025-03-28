
SELECT * FROM(
-- union average table
SELECT -1 as id
      ,'' as month
      ,-1 as day
      ,-1 as year
      ,'Average' as 'Date'
      ,max([date]) as 'originalDate'
      --,sum([generalPopBreakfast])/count([generalPopBreakfast]) as 'generalPopBreakfast'
      ,sum([generalPopLunch])/count([generalPopLunch]) as 'generalPopLunch'
      ,sum([cafeMWF])/count([cafeMWF]) as 'cafeMWF'
      --,sum([weekendSnackBags])/ count([weekendSnackBags])  as 'weekendSnackBags'
      ,sum([snackPacks])/count([snackPacks]) as 'snackPacks'
      ,sum([morningCensus])/count([morningCensus]) as 'morningCensus'
      ,sum([dayCensus])/count([dayCensus]) as 'dayCensus'
      ,sum([showers])/count([showers]) as 'showers'
      ,sum([laundry])/count([laundry]) as 'laundry'
      ,sum([mailCheckRITI])/count([mailCheckRITI]) as 'mailCheckRITI'
      ,sum([morningNews])/count([morningNews]) as 'morningNews'
      ,sum([noOfClasses])/count([noOfClasses]) as 'noOfClasses'
      ,sum([classAttendance])/count([classAttendance]) as 'classAttendance'
      ,sum([inPersonStore])/count([inPersonStore]) as 'inPersonStore'
      ,sum([navigationService])/count([navigationService]) as 'navigationService'
      ,sum([footClinic])/count([footClinic]) as 'footClinic'
      ,-1 as 'isClosed'
      ,-1 as 'isWeekend'
      ,'' as 'notes'
      ,-1 as 'edit'
      ,sum(laundryMissed)/count(laundryMissed) as 'laundryMissed'
      ,sum(mailMissed)/count(mailMissed) as 'mailMissed'
      ,sum(showersMissed)/count(showersMissed) as 'showersMissed'
      ,sum(phoneComputerAccessMissed)/count(phoneComputerAccessMissed) as 'phoneComputerAccessMissed'
      ,sum(recuperativeCareOccupancy) / count(recuperativeCareOccupancy) as 'recuperativeCareFull'
  FROM [participant].[HopeUDashboard]
  WHERE
  		(:dateBefore12Months IS NULL AND :selectedDate IS NULL)
		OR ([date] BETWEEN :dateBefore12Months AND :selectedDate)

UNION
-- union total of Last Month table
SELECT -1 as id
      ,'' as month
      ,-1 as day
      ,-1 as year
      ,'Last Month' as 'Date'
      ,max([date]) as 'originalDate'
     --,sum([generalPopBreakfast]) as 'generalPopBreakfast'
      ,sum([generalPopLunch]) as 'generalPopLunch'
      ,sum([cafeMWF]) as 'cafeMWF'
     --,sum([weekendSnackBags]) as 'weekendSnackBags'
      ,sum([snackPacks]) as 'snackPacks'
      ,sum([morningCensus]) as 'morningCensus'
      ,sum([dayCensus]) as 'dayCensus'
      ,sum([showers]) as 'showers'
      ,sum([laundry]) as 'laundry'
      ,sum([mailCheckRITI]) as 'mailCheckRITI'
      ,sum([morningNews]) as 'morningNews'
      ,sum([noOfClasses]) as 'noOfClasses'
      ,sum([classAttendance]) as 'classAttendance'
      ,sum([inPersonStore]) as 'inPersonStore'
      ,sum([navigationService]) as 'navigationService'
      ,sum([footClinic]) as 'footClinic'
      ,-1 as 'isClosed'
      ,-1 as 'isWeekend'
      ,'' as 'notes'
      ,-1 as 'edit'
      ,sum(laundryMissed) as 'laundryMissed'
      ,sum(mailMissed) as 'mailMissed'
      ,sum(showersMissed) as 'showersMissed'
      ,sum(phoneComputerAccessMissed) as 'phoneComputerAccessMissed'
      ,COUNT(CASE WHEN isRecuperativeCareFull  = 1 THEN 1 END) as 'recuperativeCareFull'
  FROM [participant].[HopeUDashboard]
  WHERE
  	   (:month IS NULL OR [month] = :lastMonth) AND
       (:year IS NULL OR [year] = case when :lastMonth = 'December' then :year - 1 else :year end)

UNION
-- union total of Last Year of same month table
SELECT -1 as id
      ,'' as month
      ,-1 as day
      ,-1 as year
      ,'Last Year' as 'Date'
      ,max([date]) as 'originalDate'
     --,sum([generalPopBreakfast]) as 'generalPopBreakfast'
      ,sum([generalPopLunch]) as 'generalPopLunch'
      ,sum([cafeMWF]) as 'cafeMWF'
     --,sum([weekendSnackBags]) as 'weekendSnackBags'
      ,sum([snackPacks]) as 'snackPacks'
      ,sum([morningCensus]) as 'morningCensus'
      ,sum([dayCensus]) as 'dayCensus'
      ,sum([showers]) as 'showers'
      ,sum([laundry]) as 'laundry'
      ,sum([mailCheckRITI]) as 'mailCheckRITI'
      ,sum([morningNews]) as 'morningNews'
      ,sum([noOfClasses]) as 'noOfClasses'
      ,sum([classAttendance]) as 'classAttendance'
      ,sum([inPersonStore]) as 'inPersonStore'
      ,sum([navigationService]) as 'navigationService'
      ,sum([footClinic]) as 'footClinic'
      ,-1 as 'isClosed'
      ,-1 as 'isWeekend'
      ,'' as 'notes'
      ,-1 as 'edit'
      ,sum(laundryMissed) as 'laundryMissed'
      ,sum(mailMissed) as 'mailMissed'
      ,sum(showersMissed) as 'showersMissed'
      ,sum(phoneComputerAccessMissed) as 'phoneComputerAccessMissed'
      ,COUNT(CASE WHEN isRecuperativeCareFull  = 1 THEN 1 END) as 'recuperativeCareFull'
  FROM [participant].[HopeUDashboard]
  WHERE
  	   (:month IS NULL OR [month] = :month) AND
       (:year IS NULL OR [year] = :year - 1)
       

UNION
-- union total of selected month and year table
SELECT -1 as id
      ,'' as month
      ,-1 as day
      ,-1 as year
      ,'Total' as 'Date'
      ,max([date]) as 'originalDate'
      --,sum([generalPopBreakfast]) as 'generalPopBreakfast'
      ,sum([generalPopLunch]) as 'generalPopLunch'
      ,sum([cafeMWF]) as 'cafeMWF'
      --,sum([weekendSnackBags]) as 'weekendSnackBags'
      ,sum([snackPacks]) as 'snackPacks'
      ,sum([morningCensus]) as 'morningCensus'
      ,sum([dayCensus]) as 'dayCensus'
      ,sum([showers]) as 'showers'
      ,sum([laundry]) as 'laundry'
      ,sum([mailCheckRITI]) as 'mailCheckRITI'
      ,sum([morningNews]) as 'morningNews'
      ,sum([noOfClasses]) as 'noOfClasses'
      ,sum([classAttendance]) as 'classAttendance'
      ,sum([inPersonStore]) as 'inPersonStore'
      ,sum([navigationService]) as 'navigationService'
      ,sum([footClinic]) as 'footClinic'
      ,-1 as 'isClosed'
      ,-1 as 'isWeekend'
      ,'' as notes
      ,-1 as 'edit'
      ,sum(laundryMissed) as 'laundryMissed'
      ,sum(mailMissed) as 'mailMissed'
      ,sum(showersMissed) as 'showersMissed'
      ,sum(phoneComputerAccessMissed) as 'phoneComputerAccessMissed'
      ,COUNT(CASE WHEN isRecuperativeCareFull  = 1 THEN 1 END) as 'recuperativeCareFull'
  FROM [participant].[HopeUDashboard]
  WHERE
  	   (:month IS NULL OR [month] = :month) AND
       (:year IS NULL OR [year] = :year)

UNION
-- union hopeU table
SELECT [id]
      ,[month]
      ,[day]
      ,[year]
      ,Concat([day],'-',LEFT([month], 3)) as 'Date'
      ,[date] as 'originalDate'
      --,[generalPopBreakfast]
      ,[generalPopLunch]
      ,[cafeMWF]
      --,[weekendSnackBags]
      ,[snackPacks]
      ,[morningCensus]
      ,[dayCensus]
      ,[showers]
      ,[laundry]
      ,[mailCheckRITI]
      ,[morningNews]
      ,[noOfClasses]
      ,[classAttendance]
      ,[inPersonStore]
      ,[navigationService]
      ,[footClinic]
      ,[isClosed]
      ,[isWeekend]
      ,ISNULL([notes],'') as notes
      ,[id] as 'edit'
      ,[laundryMissed]
      ,[mailMissed]
      ,[showersMissed] 
      ,[phoneComputerAccessMissed]
      ,isRecuperativeCareFull   as 'recuperativeCareFull'
  FROM [participant].[HopeUDashboard]
  WHERE
  	   (:month IS NULL OR [month] = :month) AND
       (:year IS NULL OR [year] = :year)

) a