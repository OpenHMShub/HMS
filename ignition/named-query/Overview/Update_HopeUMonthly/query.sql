DECLARE
	@month varchar(200),
	@year int,
	@startDate datetime,
	@stateID int,
	@bithCertificate int,
	@travlersAid int,
	@legalClinic int,
	@housedESG int,
	@busPassesTotal int,
	@day31 int,
	@day7 int,
	@allday int,
	@ride1 int
	
SELECT @month = :month
SELECT @year = :year
SELECT @startDate = :startDate -- datefromparts(@year, MONTH(concat(@month,' ',1,' ',@year)), 1)
SELECT @stateID = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%Assist With Obtaining ID Card%'
SELECT @bithCertificate = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%Assist with obtaining birth certificate%'
SELECT @travlersAid = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%Travelers Aid%'
SELECT @legalClinic = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%Legal Clinic%'
SELECT @housedESG = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%ESG-Rental Assistance%'
SELECT @busPassesTotal = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND (serviceName like '%All Day%' OR serviceName like '%31-Day%' OR serviceName like '%7 Day%' OR serviceName like '%1 Way%' OR serviceName like '%one Way%')
SELECT @day31 = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%31-Day%'
SELECT @day7 = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%7 Day%'
SELECT @allday = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND serviceName like '%All Day%'
SELECT @ride1 = count(participantId) FROM participant.ServicesDashboard WHERE (CAST(serviceDate AS DATE) BETWEEN CAST(:startDate AS DATE) AND CAST(:endDate AS DATE)) AND (serviceName like '%1 Way%' OR serviceName like '%one Way%')
-- check if record already exist for selected month
if exists(SELECT * FROM participant.HopeUDashboardMonthlyData WHERE month = :month AND year = :year)            
-- if yes then update record   
BEGIN         
 UPDATE 
 	participant.HopeUDashboardMonthlyData
 SET 
 	[stateID] = @stateID
  ,[bithCertificate] = @bithCertificate
  ,[travlersAid] = @travlersAid
  ,[legalClinic] = @legalClinic
  ,[housedESG] = @housedESG
  ,[busPassesTotal] = @busPassesTotal
  ,[day_31] = @day31
  ,[day_7] = @day7
  ,[all_Day] = @allday
  ,[ride_1] = @ride1
 WHERE 
 	month = :month AND year = :year  
End                  
else  
-- else insert record           
BEGIN  
	INSERT INTO 
		participant.HopeUDashboardMonthlyData
	VALUES
		(@month,@year,@startDate,@stateID,@bithCertificate,@travlersAid,@legalClinic,NULL,@housedESG,@busPassesTotal,@day31,@day7,@allday,@ride1)  
End 