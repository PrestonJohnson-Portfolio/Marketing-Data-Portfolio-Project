-- engagement data

select *
from engagement_data

--normalization of engagement data

select EngagementID, ContentID, CampaignID, ProductID,											
UPPER(Replace(ContentType,'SocialMedia','Social Media')) as ContentType,			-- Change all ContenetType data to uppercase, then fix how social media is written
left(ViewsClicksCombined, charindex('-',ViewsClicksCombined)-1) as Views,			-- extracts the views part from ViewsClicksCombined, stops at -				
right(ViewsClicksCombined,len(ViewsClicksCombined)- charindex('-',ViewsClicksCombined)) as Clicks,	-- gets clicks from ViewsClicksCombined
Likes,
format(convert(date,EngagementDate),'MM-dd-yyyy') as EngagementDate				-- fixes the formatting of the date
from engagement_data
where ContentType <> 'NewsLetter'												-- does not include newsletter because it will not be relevant