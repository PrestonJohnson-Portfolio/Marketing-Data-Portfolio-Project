-- Preston Johnson
--Marketing Analytics Portfolio Project

--select *
--from products

-- categorize all the products prices as low, medium, or high to make assumptions easier later
select ProductID, ProductName,Price,		--left out category column becuase it was redundant
case
	when price < 50 then 'Low'
	when Price between 50 and 200 then 'Medium'
	else 'High'
end as PriceCategory

from products;