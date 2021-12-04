SET SEARCH_PATH TO schema;
DROP TABLE IF EXISTS investigative_q2 CASCADE;

-- Investigative question: Do countries generally gravitate towards renewable or nonrenewable sources of energy
-- for electricity? This question is important because there is a strong consensus that renewable energy is better 
-- for the environment. We wish to explore any tensions which may exist between the growth of a country and which 
-- type of energy it chooses to use. 

-- QUERY 2.1)
-- Find out which resource type is the most popular for electricity production.
select resourceType, sum(electricityPercentage) as totalElectricityPercentage
from ElectricityBySource
group by resourceType 
order by sum(electricityPercentage) desc;

-- QUERY 2.2)
-- Understand the distribution of electricity production using coal. 
select * from electricitybysource where resourceType='coal'
order by electricityPercentage desc;

-- "import" relevant views for following queries 
\i import_views.sql; 

-- QUERY 2.3) 
-- Let's now compute the most popular resource type in another way.
-- We will look country by country determining the most popular, then determining the most popular overall.
-- Note: we will allow ties for most popular 
select mostpopularresource 
from MostPopularPerCountry
group by mostpopularresource
order by count(mostpopularresource) desc;

-- QUERY 2.4 
-- Let's now explore how the most popular source of electricity for each country compares to their GDP.
select * from RelationshipPopResourceGrowth;

