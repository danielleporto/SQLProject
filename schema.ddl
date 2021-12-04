drop schema if exists schema cascade;
create schema schema;
set search_path to schema;


-- CHANGES MADE TO SCHEMA SINCE PHASE 2: 
-- 1) Changed the search path to be "schema" as opposed to "phase2schema" in order to comply with the naming convention in the Phase 3 handout.
-- 2) Changed the primary key in AbundanceOfResource to (country, resourceType) as opposed to (country, resource). This was a mistake in our
-- previous submission as primary keys can only be variables - "resource" is a user-defined type, and thus not a variable. 

 -- This data type for percentages only allows floats between
 -- 0 and 100 inclusive
create domain percentage as float
    check (value>=0.0 and value<=100.0);

-- This data type allows only for strings that are one of the specified
-- resources
create domain resource as text
    check (value in ('renewable', 'coal', 'oil', 'solar', 'wind'));

-- A row in this table contains a country name, and the percentage of
-- that country's population that has access to electricity
create table ElectricityAccessibility(
    country text primary key,
    electricityPercentageOverall percentage);

-- A row in this table contains a country name, the growth percentage of that
-- country's HDI from 2005 to 2015, and the growth percentage of that country's
-- GDP from 2005 to 2015
create table LevelOfDevelopment(
    country text primary key references ElectricityAccessibility(country),
    GDPGrowth float not null,
    HDIGrowth float not null);

-- A row in this table contains a country name, an electricity resource that
-- is available in that country, and the percentage of the total electricity
-- produced in that country that comes from that resource
create table ElectricityBySource(
    country text references ElectricityAccessibility(country),
    resourceType resource,
    electricityPercentage percentage,
    primary key (country, resourceType));

-- A row in this table contains a country name, a resource that is available in
-- that country, and the abundance of that resource that is available in the
-- country
 create table AbundanceOfResource(
    country text references ElectricityAccessibility(country),
    resourceType resource,
    resourceAbundance float check (resourceAbundance>=0.0),
    primary key (country, resourceType));

-- A row in this table contains the name of a resource and the average cost to
-- produce 1kWh of electricity from that resource
 create table AvgCostOfProduction(
    resourceType resource primary key,
    cost float not null check (cost>=0.0));



