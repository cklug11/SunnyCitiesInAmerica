In this project, I analyzed a dataset from kaggle.com and created an interactive dashboard in Tableau Public.

The dataset I used contained the average percentage of sunny daylight hours per month and per year for over 100 U.S. cities. I wanted to create a dashboard that would allow users 
to look up cities in the U.S. and see the odds of experiencing a sunny day while on vacation. This could help people plan when and where they want to travel.

Here is the datset I used: https://www.kaggle.com/datasets/thedevastator/annual-percent-of-possible-sunshine-by-us-city/data , I also included this dataset in this repository.

After inspecting the data, I found some big problems.
1. The dataset contained duplicate information. Initially, the dataset had 316 rows,but after all the duplicate information was deleted, the dataset had 158 rows.
2. Some columns were missing data. I knew I only wanted to include data from cities that had information for every month of the year,but I wanted to sort out that information in MySQL.
When I first tried to load the new dataset (with all duplicates removed) into MySQL, it automatically excluded cities(aka rows) that did not have every column (month) filled with data.
To ensure that all rows were included when I loaded the dataset into MySQl, I replaced empty column values with "Null".

I included my "Fixed" dataset file in this repository.

In MySQL, I transformed the data,so I could create a dashbaord in Tableau Public:
1. I separated the city_state column into 2 individual columns, city & state. Then dropped the city_state column from the table.
2. I renamed the "ANN" column to yearly_average
3. Then I removed all cities that had Null columns values, and I also removed another irrelevant column
4. I created a view that showed each city and state and its yearly percentage of sunny daylight hours
5. I created another view that contained each city and state and every month's percentage of sunny daylight hours. In the original dataset, every month had a column, but I reformatted that information into
6. one "Month" column so I could create better visualizations in Tableau Public.

7. In Tableau Public, I created a dashboard where you could select a U.S. city from a dropdown menu or by clicking on it via the map. When no city is selected, the map is fully zoomed out.
8. When a city is selected, the map zooms in on the city's location. The select city's yearly percentage of sunny daylight hours populates and a line graph that shows every month and its corresponding average percentage of sunny daylight hours pops up.

Here is a link to my interactive Tableau Public dashboard: https://public.tableau.com/views/SunnyCities/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
I also included a screenshots of the dashboard with a city selected and when no city is selected.

I enjoyed this project and got to practice my SQl and Tableau Public skills!
