use MyWebsite;
select * from Recipes;
select * from MealTypes;
select * from Cuisines;
select * from Ingredients;

GO

CREATE OR ALTER VIEW TablesTogether 
AS
SELECT r.recipe_id, title, instructions, cooking_time, servings,
image_url, nutrition_info, m.meal_type_id, meal_type_name, c.cuisine_id, cuisine_name, 
ingredient_id, name, quantity, measurement_unit
FROM Recipes r
INNER JOIN MealTypes m ON r.meal_type_id = m.meal_type_id
INNER JOIN Cuisines c ON c.cuisine_id = r.cuisine_id
INNER JOIN Ingredients i ON i.recipe_id = r.recipe_id;

GO

use MyWebsite;
SELECT * FROM TablesTogether;

GO

CREATE OR ALTER VIEW CusininesMealsRecipes 
AS
SELECT r.recipe_id, title,
m.meal_type_id, meal_type_name, c.cuisine_id, cuisine_name
FROM Recipes r
FULL OUTER JOIN MealTypes m ON r.meal_type_id = m.meal_type_id
FULL OUTER JOIN Cuisines c ON c.cuisine_id = r.cuisine_id;

GO

use MyWebsite;
select * from CusininesMealsRecipes;

GO

use MyWebsite;
SELECT title, cuisine_name FROM CusininesMealsRecipes;

GO

use MyWebsite;
SELECT title, meal_type_name FROM CusininesMealsRecipes;

GO

use MyWebsite;
select title from Recipes;

