SET SEARCH_PATH TO schema;
DROP TABLE IF EXISTS investigative_q1 CASCADE;

-- Investigative question 1: What is the relationship between countries' gross domestic product, human development index, 
-- and electricity accessibility? In other words, is there a positive correlation? This question is important as the answer 
-- can serve as an indicator towards the importance of electricity accessibility towards a country's growth.

-- QUERY 1.1)
-- Compare electricity accessibility to levels of development 
-- Ask: is there a positive correlation between the two? 
SELECT ElectricityAccessibility.country as country, electricityPercentageOverall as electricityPercentage, GDPGrowth, HDIGrowth
FROM ElectricityAccessibility JOIN LevelOfDevelopment ON ElectricityAccessibility.country = LevelOfDevelopment.country
ORDER BY electricityPercentageOverall desc;

-- QUERY 1.2) 
-- Compare electricity accessibility and GDP growth only, ordered by GDPGrowth
SELECT ElectricityAccessibility.country as country, electricityPercentageOverall as electricityPercentage, GDPGrowth
FROM ElectricityAccessibility JOIN LevelOfDevelopment ON ElectricityAccessibility.country = LevelOfDevelopment.country
ORDER BY GDPGrowth desc;

-- QUERY 1.3) 
-- Compare electricity accessibility and HDI growth only, ordered by HDIGrowth
SELECT ElectricityAccessibility.country as country, electricityPercentageOverall as electricityPercentage, HDIGrowth
FROM ElectricityAccessibility JOIN LevelOfDevelopment ON ElectricityAccessibility.country = LevelOfDevelopment.country
ORDER BY HDIGrowth desc;