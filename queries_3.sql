SET SEARCH_PATH TO schema;
DROP TABLE IF EXISTS investigative_q2 CASCADE;

-- Investigative question 3: What are the possible reasons for a countries' gravitation towards a particular source of 
-- energy for electricity? For instance, does a country’s availability to a resource (e.g. oil, coal, wind, sunlight) 
-- impact this? What about the costs of production? Or perhaps how developed they are? This question relies on the 
-- results of Investigate Question 2 and aims to understand them. 


-- "import" relevant views for following queries 
\i import_views.sql; 

-- QUERY 3.1) 
-- First, determine which countries reported on oil abundance 
select country, resourceAbundance as oilAbundance
from AbundanceOfResource
where resourceType = 'oil';

-- Identify the countries with abundant oil, have oil as their most popular resource.
create view CountriesWithTopOilAbundance as 
select AbundanceOfResource.country as country, mostpopularresource, resourceAbundance as oilAbundance
from AbundanceOfResource join MostPopularPerCountry on AbundanceOfResource.country = MostPopularPerCountry.country
where resourceType = 'oil'
order by resourceAbundance desc;

-- QUERY 3.2) 
select * from CountriesWithTopOilAbundance;

-- For the countries who have an abundant amount of oil and whose most popular resource is coal, how abundant is coal? 
create view CoalAbundance as
select country, resourceAbundance as coalAbundance
from AbundanceOfResource
where resourceType = 'coal'
order by coalAbundance desc;

-- QUERY 3.3) 
-- We see in this query that US, Austrailia, Canada, New Zealand have the highest amount of coal reserves. 
select * from CoalAbundance;

-- QUERY 3.4) 
-- For the countries with highest oil abundance, compare their abundance of oil with their abundance of coal.
select CountriesWithTopOilAbundance.country as country, oilAbundance, resourceAbundance as coalAbundance
from CountriesWithTopOilAbundance join AbundanceOfResource on CountriesWithTopOilAbundance.country = AbundanceOfResource.country
where resourceType = 'coal' and mostpopularresource = 'coal';

-- QUERY 3.5) 
-- Discover which form of resource is the cheapest. 
select * from AvgCostOfProduction
order by cost;

-- How do these countries with top oil abundance perform economically to other countries? Are they better off? 
-- First, for the countries with abundant oil, find their GDP. 
create view CountriesWithTopOilAbundanceGDP as 
select CountriesWithTopOilAbundance.country as country, GDPgrowth
from CountriesWithTopOilAbundance join LevelOfDevelopment on CountriesWithTopOilAbundance.country = LevelOfDevelopment.country
order by GDPgrowth desc;

-- QUERY 3.6) 
-- Now find which countries have a higher GDP growth than the countries which have top oil abundance. 
select country, mostpopularresource, GDPgrowth
from RelationshipPopResourceGrowth RPRG
where GDPgrowth >= ALL (
	select GDPgrowth
	from CountriesWithTopOilAbundanceGDP CWTOA
	where CWTOA.country != RPRG.country);

-- Let's try to understand how Ethiopia has thrived economically despite mainly living off of renewables.
-- Discover which countries have the most abundant amount of wind. 
create view WindAbundance as
select country, resourceAbundance as windAbundance
from AbundanceOfResource
where resourceType = 'wind'
order by resourceAbundance desc;

-- QUERY 3.7) 
select * from WindAbundance;

-- QUERY 3.8) 
-- for countries whose wind abundance >= 6, which use renewables as their main resource? 
select WindAbundance.country as country, mostpopularresource, windAbundance
from WindAbundance join MostPopularPerCountry on WindAbundance.country = MostPopularPerCountry.country
where windAbundance >= 6
order by windAbundance desc;

-- Discover which countries have a lot of sunlight.  
create view SunlightAbundance as
select country, resourceAbundance as sunlightAbundance
from AbundanceOfResource
where resourceType = 'solar'
order by sunlightAbundance desc;

-- QUERY 3.9) 
-- For the countries whose sunlight abundance >= 3000, which use renewables as their main resource? 
select SunlightAbundance.country as country, mostpopularresource, sunlightAbundance
from SunlightAbundance join MostPopularPerCountry on SunlightAbundance.country = MostPopularPerCountry.country
where sunlightAbundance >= 3000
order by sunlightAbundance desc;
