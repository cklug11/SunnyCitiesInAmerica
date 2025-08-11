USE SunnyCities;

-- Had to delete half of the data from the original csv file because the data was duplicated
-- On original data import via the Table Data Import Wizard, some rows of data were not being imported because they had some empty columns,
-- I was able to get every row of data imported by going back into the csv file and putting "Null" in any empty spots.

-- Simplify table name and get rid of the need to use backticks
RENAME TABLE `average percent of possible sunshine by us city`
TO  possible_sunshine_percentage_by_us_city;

SELECT * FROM possible_sunshine_percentage_by_us_city;

-- Remove unnecessary columns
ALTER TABLE possible_sunshine_percentage_by_us_city
DROP COLUMN `Unnamed: 14`,
DROP COLUMN  `index`;

-- Rename Column for better readability
ALTER TABLE possible_sunshine_percentage_by_us_city
RENAME COLUMN ANN TO Yearly_Average,
RENAME COLUMN city TO city_state;
-- Did not do
-- Separate City Column(which was holding city and state information) into 2 columns, one column for city and one column for state
-- First, Must creat a state column

ALTER TABLE possible_sunshine_percentage_by_us_city
ADD COLUMN city VARCHAR(100),
ADD COLUMN state VARCHAR(50);

SET SQL_SAFE_UPDATES = 0;

UPDATE possible_sunshine_percentage_by_us_city
SET
	city = TRIM(SUBSTRING_INDEX(city_state,',',1)),
    state = TRIM(SUBSTRING_INDEX(city_state,',',-1));
    
SET SQL_SAFE_UPDATES = 1;

-- Drop the now unnecessary column-city_state
ALTER TABLE possible_sunshine_percentage_by_us_city
DROP COLUMN city_state;


-- Look for Any Null Values
Select * 
from possible_sunshine_percentage_by_us_city
WHERE Yearly_Average IS NULL;

-- Found Several cities that had missing monthly data so I am removing them from this table

SET SQL_SAFE_UPDATES = 0;
DELETE FROM possible_sunshine_percentage_by_us_city
WHERE Yearly_Average IS NULL;
SET SQL_SAFE_UPDATES = 1;

-- Yearly Average by city

DROP VIEW IF EXISTS city_yearly_average;

CREATE VIEW city_yearly_average AS
SELECT city,state, yearly_average
FROM possible_sunshine_percentage_by_us_city;
SELECT * FROM city_yearly_average;

-- Create A View that has a monthly column
DROP VIEW IF EXISTS city_monthly_averages;
CREATE VIEW city_monthly_averages AS
SELECT city,state,'Jan' as month, Jan AS Avg_Monthly_Sunshine_Percentage FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Feb', FEB FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Mar', MAR FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Apr', APR FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'May', MAY FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Jun', JUN FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Jul', JUL FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Aug', AUG FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Sep', SEP FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Oct', OCT FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Nov', NOV FROM possible_sunshine_percentage_by_us_city
UNION ALL
SELECT city,state,'Dec', `DEC` FROM possible_sunshine_percentage_by_us_city;

SELECT * FROM city_monthly_averages;

