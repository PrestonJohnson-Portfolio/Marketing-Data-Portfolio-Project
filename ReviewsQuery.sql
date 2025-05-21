--customer reviews

select * 
from customer_reviews

-- no need from extra spaces in the reviews, cleans them up
select ReviewID, CustomerID, ProductID, ReviewDate, Rating, 
replace(ReviewText,'  ',' ') as ReviewText --replaces double spaces with single and renames it the same
from customer_reviews