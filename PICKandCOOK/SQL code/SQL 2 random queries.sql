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
select recipe_id, title from Recipes
order by recipe_id;

GO
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

use MyWebsite;
select distinct title from TablesTogether
where meal_type_name = 'Breakfast';

GO

use MyWebsite;
select distinct title from TablesTogether
where meal_type_name = 'Lunch';

GO

use MyWebsite;
select distinct title from TablesTogether
where meal_type_name = 'Dinner';

GO

use MyWebsite;
select * from MealPlans;

GO

USE MyWebsite;
CREATE TABLE DietaryRestrictions ( res_id int primary key identity(1,1) not null, restriction_title varchar(50), recipe_id int foreign key references Recipes(recipe_id));

GO

INSERT INTO DietaryRestrictions (restriction_title, recipe_id) VALUES
('Vegetarian', 1),
('Gluten-Free', 1),
('Dairy-Free', 1),
('Nut-Free', 1),
('Low-Carb', 1),
('Vegetarian', 2),
('Gluten-Free', 2),
('Dairy-Free', 2),
('Nut-Free', 2),
('Low-Carb', 2),
('Gluten-Free', 3),
('Dairy-Free', 3),
('Nut-Free', 3),
('Low-Carb', 3),
('Dairy-Free', 4),
('Nut-Free', 4),
('Low-Carb', 4),
('Gluten-Free', 5),
('Dairy-Free', 5),
('Nut-Free', 5),
('Gluten-Free', 6),
('Dairy-Free', 6),
('Nut-Free', 6),
('Gluten-Free', 7),
('Dairy-Free', 7),
('Nut-Free', 7),
('Gluten-Free', 8),
('Dairy-Free', 8),
('Gluten-Free', 9),
('Nut-Free', 9),
('Low-Carb', 9),
('Gluten-Free', 10),
('Dairy-Free', 10),
('Nut-Free', 10),
('Vegan', 11),
('Gluten-Free', 11),
('Dairy-Free', 11),
('Nut-Free', 11),
('Gluten-Free', 12),
('Dairy-Free', 12),
('Nut-Free', 12),
('Vegetarian', 13),
('Gluten-Free', 13),
('Dairy-Free', 13),
('Nut-Free', 13),
('Vegan', 14),
('Gluten-Free', 14),
('Dairy-Free', 14),
('Nut-Free', 14),
('Vegetarian', 15),
('Gluten-Free', 15),
('Dairy-Free', 15),
('Nut-Free', 15),
('Vegetarian', 16),
('Gluten-Free', 16),
('Dairy-Free', 16),
('Nut-Free', 16),
('Gluten-Free', 17),
('Dairy-Free', 17),
('Nut-Free', 17),
('Low-Carb', 17),
('Vegan', 18),
('Gluten-Free', 18),
('Dairy-Free', 18),
('Nut-Free', 18),
('Gluten-Free', 19),
('Dairy-Free', 19),
('Nut-Free', 19),
('Low-Carb', 19),
('Gluten-Free', 20),
('Dairy-Free', 20),
('Nut-Free', 20),
('Low-Carb', 20),
('Vegan', 21),
('Gluten-Free', 21),
('Dairy-Free', 21),
('Nut-Free', 21),
('Gluten-Free', 22),
('Dairy-Free', 22),
('Nut-Free', 22),
('Gluten-Free', 23),
('Dairy-Free', 23),
('Nut-Free', 23),
('Vegetarian', 24),
('Gluten-Free', 24),
('Dairy-Free', 24),
('Nut-Free', 24),
('Gluten-Free', 25),
('Dairy-Free', 25),
('Nut-Free', 25),
('Gluten-Free', 26),
('Dairy-Free', 26),
('Nut-Free', 26),
('Vegan', 27),
('Gluten-Free', 27),
('Dairy-Free', 27),
('Nut-Free', 27),
('Gluten-Free', 28),
('Dairy-Free', 28),
('Nut-Free', 28),
('Gluten-Free', 29),
('Dairy-Free', 29),
('Nut-Free', 29),
('Gluten-Free', 30),
('Dairy-Free', 30),
('Nut-Free', 30),
('Vegan', 31),
('Gluten-Free', 31),
('Dairy-Free', 31),
('Nut-Free', 31),
('Gluten-Free', 32),
('Dairy-Free', 32),
('Nut-Free', 32),
('Vegan', 33),
('Gluten-Free', 33),
('Dairy-Free', 33),
('Nut-Free', 33),
('Vegan', 34),
('Gluten-Free', 34),
('Dairy-Free', 34),
('Nut-Free', 34),
('Vegan', 35),
('Gluten-Free', 35),
('Dairy-Free', 35),
('Nut-Free', 35),
('Vegan', 36),
('Gluten-Free', 36),
('Dairy-Free', 36),
('Nut-Free', 36),
('Vegetarian', 37),
('Gluten-Free', 37),
('Dairy-Free', 37),
('Nut-Free', 37),
('Vegetarian', 38),
('Gluten-Free', 38),
('Dairy-Free', 38),
('Nut-Free', 38),
('Vegetarian', 39),
('Gluten-Free', 39),
('Dairy-Free', 39),
('Nut-Free', 39),
('Vegan', 40),
('Gluten-Free', 40),
('Dairy-Free', 40),
('Nut-Free', 40),
('Gluten-Free', 41),
('Dairy-Free', 41),
('Nut-Free', 41),
('Low-Carb', 41),
('Vegan', 42),
('Gluten-Free', 42),
('Dairy-Free', 42),
('Nut-Free', 42);

GO

use MyWebsite;
select * from DietaryRestrictions;

GO 

CREATE OR ALTER VIEW TablesAllTogether 
AS
	SELECT r.recipe_id, title, instructions, cooking_time, servings, restriction_title,
	image_url, nutrition_info, m.meal_type_id, meal_type_name, c.cuisine_id, cuisine_name, 
	ingredient_id, name, quantity, measurement_unit
	FROM Recipes r
	INNER JOIN MealTypes m ON r.meal_type_id = m.meal_type_id
	INNER JOIN Cuisines c ON c.cuisine_id = r.cuisine_id
	INNER JOIN Ingredients i ON i.recipe_id = r.recipe_id
	INNER JOIN DietaryRestrictions d ON d.recipe_id = r.recipe_id;

GO

use MyWebsite;
SELECT * from TablesAllTogether;

GO

use MyWebsite;
CREATE TABLE MealPlans (
	username varchar(50) not null, 
	meal_plan_id INT PRIMARY KEY IDENTITY(1,1),
    breakfast_recipe_id INT,
    lunch_recipe_id INT,
    dinner_recipe_id INT,
    dietary_restrictions NVARCHAR(MAX),
    date_created DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (breakfast_recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (lunch_recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (dinner_recipe_id) REFERENCES Recipes(recipe_id)
);

GO

CREATE OR ALTER VIEW MealPlannerTable
AS
SELECT 
    m.meal_plan_id,
    r1.recipe_id AS breakfast_recipe_id,
    r1.title AS breakfast_recipe_title,
    r2.recipe_id AS lunch_recipe_id,
    r2.title AS lunch_recipe_title,
    r3.recipe_id AS dinner_recipe_id,
    r3.title AS dinner_recipe_title,
    m.dietary_restrictions,
    m.date_created
FROM MealPlans m
INNER JOIN Recipes r1 ON m.breakfast_recipe_id = r1.recipe_id
INNER JOIN Recipes r2 ON m.lunch_recipe_id = r2.recipe_id
INNER JOIN Recipes r3 ON m.dinner_recipe_id = r3.recipe_id;

GO

use MyWebsite;
Select * from MealPlannerTable;

GO

use MyWebsite;
select distinct restriction_title from DietaryRestrictions;

GO

use MyWebsite;
select distinct restriction_title, title from TablesAllTogether;

GO

use MyWebsite;
select image_url from Recipes where title = @dropdownlist1.selectedvalue;

GO

use MyWebsite;
Delete from MealPlans;
drop table MealPlans;

GO

use MyWebsite;
select * from MealPlans;

GO

SELECT TOP 7 * 
FROM MealPlans 
WHERE username = 'malak' 
ORDER BY meal_plan_id;

GO

use MyWebsite;
CREATE TABLE NbrofMealPlans ( Plan_id int primary key identity(1,1), username varchar(50) not null);

GO

use MyWebsite;
select * from NbrofMealPlans;

GO

CREATE OR ALTER VIEW PlannerMeal
AS
select Plan_id, n.username , meal_plan_id, 
breakfast_recipe_id, lunch_recipe_id, dinner_recipe_id, dietary_restrictions,
date_created
from NbrofMealPlans n inner join MealPlans m
on n.username = m.username;

GO

SELECT Plan_id, username , meal_plan_id, 
breakfast_recipe_id, lunch_recipe_id, dinner_recipe_id FROM PlannerMeal
where username = 'Admin1111'
group by Plan_id,  username , meal_plan_id, 
breakfast_recipe_id, lunch_recipe_id, dinner_recipe_id;

GO

select * from PlannerMeal;

GO

USE MyWebsite;
DELETE FROM NbrofMealPlans;
DROP TABLE NbrofMealPlans;

GO

use MyWebsite;
Delete from IngredientPrice;
DROP TABLE IngredientPrice;

GO

use MyWebsite;
select distinct name from Ingredients
order by name;

GO

USE MyWebsite;

-- Create IngredientPrice table and insert distinct names with random prices
SELECT name, 
    ROUND(CAST((RAND(CHECKSUM(NEWID())) * 100) AS MONEY), 2) AS price
INTO IngredientPrice
FROM IngredientsNames;

GO

select distinct name 
into IngredientsNames
from Ingredients
order by name;

GO

use MyWebsite;
select * from IngredientsNames;

GO

use MyWebsite;
select * from IngredientPrice;

GO

exec sp_help IngredientPrice;

GO

select sum(price) as Total_Price from IngredientPrice
where name in ( 'Almond milk', 'Bacon', 'Chicken');

GO

use MyWebsite;
CREATE TABLE Delivery (del_id int primary key identity(1,1), username varchar(50) not null, total_price money not null check (total_price <> 0) );

GO

select * from Delivery;

GO

