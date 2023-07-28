/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [data_id]
      ,[state]
      ,[LGA]
      ,[location]
      ,[source]
      ,[fatalities]
  FROM [nigeria crisis and conflict].[dbo].[nigeria conflicts]
  order by 1
  SELECT [data_id]
      ,[event_date]
      ,[event_type]
      ,[party/parties involved]
      ,[rioters/protesters]
  FROM [nigeria crisis and conflict].[dbo].[nigeria crisis]
  order by 1
  select *
  from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id

--state with the highest Crisis in descending order

select state, count(fatalities) as CountOfCrisis
from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  --order by fatalities
  group by state, fatalities
  order by count(fatalities) desc

  --percentage rating of fatalities
  
  select state, count(fatalities) as CountOfCrisis, sum(fatalities) as NumberOfFatalities, sum(fatalities)/18533 *100 as FatalityRatingPercentage
from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  group by state
  order by count(fatalities) desc

    --crisis/event type with more fatalities

  select event_type, COUNT(fatalities) as CountOfCrisis, sum(fatalities) as NumberOfFatalities
  from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  group by event_type

   --most brutal crisis/event type and chances of making it out safe

  select event_type, COUNT(fatalities) as CountOfCrisis, sum(fatalities) as NumberOfFatalities, count(fatalities)/sum(fatalities)*100 as ChancesOfMakingItOutSafe
  from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  group by event_type
  having sum(fatalities) > 0
  order by count(fatalities)

  -- days with the most casualty

  select event_date, event_type, COUNT(fatalities) as countofcrisis, sum(fatalities) as numberoffatalities
  from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  group by event_type, event_date
  order by sum(fatalities) desc

  --month with the most casualty

  select MONTH(event_date) as months, COUNT(fatalities) as countofcrisis, sum(fatalities) as numberoffatalities
  from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  group by month(event_date)
  order by sum(fatalities) desc

  --event types and total fatalities caused by parties involved in crisis

  select event_type, [party/parties involved], sum(fatalities) as TotalFatalities
  from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  group by event_type, [party/parties involved]

  --total fatalities by parties involved in different LGA

  select LGA, [party/parties involved], count(fatalities) as countoffatalities, sum(fatalities) as TotalFatalities
  from [nigeria crisis and conflict]..[nigeria crisis]
  join [nigeria crisis and conflict]..[nigeria conflicts]
  on [nigeria conflicts].data_id = [nigeria crisis].data_id
  group by LGA, [party/parties involved]
  --having [party/parties involved] like 'police forces of nigeria (2015-)'