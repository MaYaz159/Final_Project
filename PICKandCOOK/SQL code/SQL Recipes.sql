USE MyWebsite;
select * from TablesTogether;

GO

use MyWebsite;
select distinct meal_type_name from TablesTogether;

GO

use MyWebsite;
select * from MealTypes;

GO

use MyWebsite;
select distinct cuisine_name from TablesTogether;

GO

use MyWebsite;
SELECT title, cuisine_name , meal_type_name 
from CusininesMealsRecipes
order by cuisine_name;

GO

use MyWebsite;
select distinct title, instructions, cooking_time, servings, nutrition_info, image_url from TablesTogether;

GO


