
-- The below views are used in queries_2.sql and queries_3.sql

create view MostPopularPerCountry as 
select country, resourceType as mostpopularresource
from ElectricityBySource EBS 
where electricityPercentage >= ALL (
    select electricityPercentage
    from ElectricityBySource
    where country = EBS.country and resourceType != EBS.resourceType);

create view RelationshipPopResourceGrowth as
select LevelOfDevelopment.country as country,mostpopularresource, GDPgrowth, HDIgrowth
from LevelOfDevelopment join MostPopularPerCountry on LevelOfDevelopment.country = MostPopularPerCountry.country
order by GDPgrowth desc;

