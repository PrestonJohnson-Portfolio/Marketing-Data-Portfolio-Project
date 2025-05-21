--customers and geography

select * 
from customers

select * 
from geography

--want to combine the two tables because there is no reason to have both
select c.CustomerID, c.CustomerName, c.Email, c.Gender, C.Age,   
case												--case to make age categories
when age <= 30 then 'Young'
when age between 30 and 50 then 'Middle Age'
else 'Old'
end as AgeCategory, g.Country,g.City     
from customers c 
left join geography g				    --left join just adds the two geography columns on to the end of the left table
on c.GeographyID = g.GeographyID;
