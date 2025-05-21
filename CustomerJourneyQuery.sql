-- customer journey

select *
from customer_journey;


-- use cte to identify and tag duplicate records
With DuplicateRecords as (													--creates a cte called DuplicateRecords
	select JourneyID, CustomerID,ProductID, VisitDate, Stage, Action, Duration, 
		ROW_NUMBER() Over(													-- use row_number to assign all rows with a number grouped by CustomerID, ProductID, VisitDate, Stage, Action using a partition
			partition by CustomerID, ProductID, VisitDate, Stage, Action    -- if a row is unique it will have a 1, if it has greater than a 1 it is a duplicte row
			order by JourneyID
		) as row_num
	from customer_journey
)

select *						--select all rows from the cte where the row_num partition is greater than 1, meaning it is a duplicate of another row
from DuplicateRecords
where row_num > 1
order by JourneyID

-- create outer query to select the final clean data, some durations are null and we will use the average duration to fill those instead
select JourneyID, CustomerID,ProductID, VisitDate, Stage, Action,
	coalesce(Duration, avg_duration) as Duration					-- replaces any nulls in duration with the avg_duration that is created later
from(																-- subquery to process and clean the data
	select JourneyID, CustomerID,ProductID, VisitDate, 
	UPPER(Stage) as Stage,											-- change stage to uppercase
	Action, Duration, 
	avg(Duration) over (partition by VisitDate) as avg_duration,	-- get the average duration for each visit
	row_number() over (												-- assign rows a unique numnber within group defined by CustomerID, ProductID, VisitDate, UPPER(Stage), Action
		partition by CustomerID, ProductID, VisitDate, UPPER(Stage), Action
		order by JourneyID
		) as row_num
		from customer_journey
	) as subquery
	where row_num = 1;		-- only keeps the first instance of that row