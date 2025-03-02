CREATE DATABASE MyWebsite

GO

USE MyWebsite;
CREATE TABLE Login ( ID int primary key identity ( 1,1 ) , username varchar(100) not null , password varchar(100) not null , Profile_Picture VARBINARY(MAX) );

GO

INSERT INTO Login ( username, password )
VALUES 
    ('Admin', '0000'), 
    ('Mayaz', 'mayazpassword'), 
    ('Sara', 'sarapassword'), 
    ('Israa', 'israapassword'), 
    ('Jad', 'jadpassword'), 
    ('Haneen', 'haneenpassword');

GO

use MyWebsite;
SELECT * FROM Login;

GO

use MyWebsite;
DELETE FROM Login;
DROP TABLE Login;

GO

use MyWebsite;
EXEC sp_help 'Login';

GO

use MyWebsite;

-- Create Cuisines Table
CREATE TABLE Cuisines (
    cuisine_id INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    cuisine_name NVARCHAR(100) NOT NULL
);

-- Create Meal Types Table
CREATE TABLE MealTypes (
    meal_type_id INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    meal_type_name NVARCHAR(100) NOT NULL
);

-- Create Recipes Table
CREATE TABLE Recipes (
    recipe_id INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    title NVARCHAR(255) unique NOT NULL,
    instructions NVARCHAR(MAX) NOT NULL, -- Use NVARCHAR(MAX) for long text
    cooking_time INT NOT NULL, -- in minutes
    servings INT NOT NULL,
    cuisine_id INT,
    meal_type_id INT,
    image_url NVARCHAR(255),
    nutrition_info NVARCHAR(MAX),
    FOREIGN KEY (cuisine_id) REFERENCES Cuisines(cuisine_id),
    FOREIGN KEY (meal_type_id) REFERENCES MealTypes(meal_type_id)
);

-- Create Ingredients Table
CREATE TABLE Ingredients (
    ingredient_id INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    name NVARCHAR(100) NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL, -- Allows for decimal quantities
    measurement_unit NVARCHAR(50) NOT NULL,
    recipe_id INT,
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
);

GO

INSERT INTO MealTypes (meal_type_name) VALUES
('Breakfast'),
('Lunch'),
('Dinner'),
('Snack'),
('Brunch'),
('Dessert'),
('Appetizer'),
('Side Dish'),
('Main Course'),
('Beverage');

INSERT INTO Cuisines (cuisine_name) VALUES
('Italian'),
('Mexican'),
('Chinese'),
('Indian'),
('French'),
('Japanese'),
('Thai'),
('Spanish'),
('American'),
('Greek'),
('Korean'),
('Lebanese'),
('Brazilian'),
('Caribbean'),
('Turkish'),
('Middle Eastern'),
('Russian'),
('Moroccan'),
('Filipino'),
('German'),
('British'),
('Mediterranean');

GO

INSERT INTO Recipes (title, instructions, cooking_time, servings, cuisine_id, meal_type_id, image_url, nutrition_info) VALUES
('Pancakes', 'Mix batter and cook on a griddle.', 20, 4, 9, 1, '/Recipes/Pancakes.jpeg', 'Calories: 350'), -- Breakfast
('Quesadilla', 'Fill tortillas with cheese and cook on a skillet.', 15, 2, 2, 2, '/Recipes/Beef Quesadilla.jpeg', 'Calories: 400'), -- Lunch
('Kung Pao Chicken', 'Stir-fry chicken with peanuts, chili peppers, and vegetables.', 30, 4, 3, 3, '/Recipes/Kung Pao Chicken.jpeg', 'Calories: 450'), -- Dinner
('Chicken Biryani', 'Cook rice with spices and marinated chicken.', 60, 6, 4, 3, '/Recipes/Biriyani.jpeg', 'Calories: 500'), -- Dinner
('Coq au Vin', 'Cook chicken in red wine with mushrooms and onions.', 90, 4, 5, 3, '/Recipes/Coq Au Vin.jpeg', 'Calories: 600'), -- Dinner
('Sushi Rolls', 'Prepare rice, roll with fish, avocado, and seaweed.', 45, 2, 6, 3, '/Recipes/Sushi Rolls.jpeg', 'Calories: 250'), -- Dinner
('Pad Thai', 'Stir-fry noodles with shrimp, tofu, and peanuts.', 30, 4, 7, 3, '/Recipes/Pad thai.jpeg', 'Calories: 400'), -- Dinner
('Paella', 'Cook rice with seafood, chicken, and spices.', 75, 6, 8, 3, '/Recipes/Seafood Paella.jpeg', 'Calories: 600'), -- Dinner
('Cheeseburger', 'Grill beef patties, add cheese, and serve with buns.', 25, 1, 9, 3, '/Recipes/Chicken Burger.jpeg', 'Calories: 700'), -- Dinner
('Greek Salad', 'Mix cucumbers, tomatoes, olives, and feta cheese.', 15, 2, 10, 4, '/Recipes/Greek Salad.jpeg', 'Calories: 250'), -- Snack
('Kimchi', 'Ferment cabbage with chili pepper and garlic.', 7, 1, 11, 8, '/Recipes/Kimchi.jpeg', 'Calories: 50'), -- Dessert
('Tom Yum Soup', 'Simmer shrimp and vegetables in a spicy broth.', 30, 4, 7, 3, 'Recipes/Spicy Tom Yum Soup.jpeg', 'Calories: 200'), -- Dinner
('Spanish Tortilla', 'Cook potatoes and onions in eggs to make a Spanish omelette.', 40, 4, 8, 1, '/Recipes/Spanish Tortilla.png', 'Calories: 350'), -- Breakfast
('Ratatouille', 'Stew vegetables with herbs and olive oil.', 50, 4, 5, 8, '/Recipes/Ratatouille.jpeg', 'Calories: 200'), -- Side Dish
('Pasta Primavera', 'Toss pasta with fresh vegetables and olive oil.', 30, 4, 1, 3, '/Recipes/Pasta Primavera.jpeg', 'Calories: 400'), -- Dinner
('Shakshuka', 'Poach eggs in a spiced tomato and pepper sauce.', 30, 4, 16, 1, '/Recipes/Shakshuka.jpeg', 'Calories: 350'), -- Breakfast
('Fish and Chips', 'Fry fish and serve with crispy potatoes.', 40, 4, 21, 3, '/Recipes/Fish and Chips.jpeg', 'Calories: 500'), -- Dinner
('Falafel', 'Form chickpea balls and deep fry.', 45, 4, 16, 4, '/Recipes/Falafel.jpeg', 'Calories: 300'), -- Snack
('Steak Frites', 'Grill steak and serve with French fries.', 40, 2, 5, 3, '/Recipes/Steak.jpeg', 'Calories: 700'), -- Dinner
('Beef Tacos', 'Fill tacos with seasoned ground beef and toppings.', 25, 4, 2, 2, '/Recipes/Beef Tacos.jpeg', 'Calories: 400'), -- Lunch
('Lebanese Hummus', 'Blend chickpeas, tahini, lemon, and garlic.', 15, 4, 12, 7, '/Recipes/Lebanese Hummus.jpeg', 'Calories: 150'), -- Appetizer
('Brazilian Feijoada', 'Simmer black beans with pork and beef.', 120, 6, 13, 3, '/Recipes/Brazilian Feijoada.jpeg', 'Calories: 700'), -- Dinner
('Caribbean Jerk Chicken', 'Marinate chicken with spices and grill.', 60, 4, 14, 3, '/Recipes/Caribbean Jerk Chicken.jpeg', 'Calories: 500'), -- Dinner
('Baklava', 'Layer filo dough with nuts and honey, then bake.', 60, 8, 15, 6, '/Recipes/Baklava.jpeg"', 'Calories: 400'), -- Dessert
('Turkish Kebab', 'Grill skewered meat and serve with flatbread.', 45, 4, 15, 3, '/Recipes/Kebap.jpeg', 'Calories: 600'), -- Dinner
('Borscht', 'Simmer beets, cabbage, and meat in a broth.', 60, 6, 17, 3, '/Recipes/Borscht.jpeg', 'Calories: 250'), -- Dinner
('Moroccan Couscous', 'Stew vegetables and meat with couscous.', 50, 6, 18, 9, '/Recipes/Couscous.jpeg', 'Calories: 350'), -- Main Course
('Adobo', 'Simmer chicken or pork with vinegar, soy sauce, and spices.', 60, 4, 19, 3, '/Recipes/Adobo.jpeg', 'Calories: 500'), -- Dinner
('Bratwurst', 'Grill sausages and serve with mustard and sauerkraut.', 30, 2, 20, 2, '/Recipes/Bratwurst.jpeg', 'Calories: 600'), -- Lunch
('Sauerbraten', 'Slow-cook beef in a vinegary marinade.', 120, 6, 20, 3, '/Recipes/Sauerbraten.jpeg', 'Calories: 700'); -- Dinner

INSERT INTO Recipes (title, instructions, cooking_time, servings, cuisine_id, meal_type_id, image_url, nutrition_info) VALUES
('Avocado Toast', 'Toast the bread, mash the avocado, and spread it on the toast. Season with salt, pepper, and optional toppings.', 10, 2, 9, 5, '/Recipes/Avocado Toast.jpeg', 'Calories: 250'),
('Eggs Benedict', 'Toast English muffins, poach eggs, and top with Canadian bacon and hollandaise sauce.', 20, 2, 9, 5, '/Recipes/Eggs Benedict.jpeg', 'Calories: 450'),
('Berry Smoothie Bowl', 'Blend frozen berries, banana, yogurt, and milk. Pour into a bowl and add toppings.', 10, 1, 9, 5, '/Recipes/Berry Smoothie Bowl.jpeg', 'Calories: 300'),
('Iced Matcha Latte', 'Whisk matcha with hot water, then mix with milk and sweetener over ice.', 5, 1, 6, 10, '/Recipes/Iced Matcha Latte.jpeg', 'Calories: 100'),
('Cucumber Mint Cooler', 'Blend cucumber, mint, lime juice, and honey. Strain and mix with sparkling water.', 10, 4, 22, 10, '/Recipes/Cucumber Mint Lime Cooler.jpeg', 'Calories: 50');

-- Insert Appetizer Recipes
INSERT INTO Recipes (title, instructions, cooking_time, servings, cuisine_id, meal_type_id, image_url, nutrition_info) VALUES
('Bruschetta with Tomato and Basil', 'Toast slices of baguette. In a bowl, mix diced tomatoes, chopped basil, minced garlic, olive oil, balsamic vinegar, salt, and pepper. Top the toasted bread with the mixture.', 5, 4, 1, 7, '/Recipes/Bruschetta.png', 'Calories: 150'),
('Stuffed Mushrooms', 'Preheat the oven to 375°F (190°C). In a bowl, mix softened cream cheese, minced garlic, grated Parmesan, breadcrumbs, chopped parsley, olive oil, salt, and pepper. Stuff the mushroom caps with the mixture and bake for 20 minutes.', 20, 6, 1, 7, '/Recipes/Stuffed Mushrooms.jpeg', 'Calories: 200'),
('Mango Lassi', 'Blend yogurt, mango, milk, honey, and cardamom until smooth. Serve chilled.', 5, 2, 4, 10, '/Recipes/Mango Lassi.jpeg', 'Calories: 150');

-- Insert Dessert Recipe: Chocolate Chip Cookies
INSERT INTO Recipes (title, instructions, cooking_time, servings, cuisine_id, meal_type_id, image_url, nutrition_info) VALUES
('Chocolate Chip Cookies', 'Preheat oven to 375°F (190°C). Mix butter, sugar, eggs, flour, baking powder, salt, and chocolate chips. Drop by spoonfuls onto a baking sheet and bake for 10-12 minutes.', 10, 12, 9, 6, '/Recipes/Chocolate Chip Cookies.jpeg', 'Calories: 120');

-- Insert Snack Recipe: Spicy Roasted Chickpeas
INSERT INTO Recipes (title, instructions, cooking_time, servings, cuisine_id, meal_type_id, image_url, nutrition_info) VALUES
('Spicy Roasted Chickpeas', 'Preheat oven to 400°F (200°C). Mix chickpeas, olive oil, salt, and spices. Spread on a baking sheet and roast for 30-40 minutes.', 30, 4, 16, 4, '/Recipes/Roasted Chickpeas.jpeg', 'Calories: 100');

-- Insert Main Course Recipe: Chicken Alfredo Pasta
INSERT INTO Recipes (title, instructions, cooking_time, servings, cuisine_id, meal_type_id, image_url, nutrition_info) VALUES
('Chicken Alfredo Pasta', 'Cook fettuccine according to package instructions. In a skillet, heat olive oil and cook chicken until golden. Remove chicken and add garlic, then heavy cream. Stir in Parmesan cheese until smooth. Slice chicken and serve over pasta with sauce.', 20, 4, 1, 9, '/Recipes/Chicken Alfredo Pasta.jpeg', 'Calories: 600');

-- Insert Main Course Recipe: Vegetable Stir-Fry
INSERT INTO Recipes (title, instructions, cooking_time, servings, cuisine_id, meal_type_id, image_url, nutrition_info) VALUES
('Vegetable Stir-Fry', 'In a large skillet, heat olive oil. Add garlic and ginger, then mixed vegetables. Stir-fry until tender. Add soy sauce and cook for another minute. Serve over cooked rice and garnish with sesame seeds and green onions.', 15, 4, 3, 9, '/Recipes/Vegetable Stir-Fry.jpeg', 'Calories: 300');

GO

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Pancakes
('Flour', 2.00, 'cups', 1), 
('Milk', 1.50, 'cups', 1),
('Eggs', 2.00, 'large', 1);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Quesadilla
('Cheese', 1.00, 'cup', 2), 
('Tortillas', 4.00, 'pieces', 2);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Kung Pao Chicken
('Chicken', 1.00, 'cup', 3), 
('Peanuts', 0.50, 'cup', 3),
('Chili Peppers', 2.00, 'pieces', 3),
('Vegetables', 1.00, 'cup', 3);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Chicken Biryani
('Chicken', 1.50, 'lbs', 4), 
('Basmati Rice', 2.00, 'cups', 4),
('Onion', 1.00, 'large', 4),
('Tomato', 2.00, 'medium', 4),
('Yogurt', 1.00, 'cup', 4),
('Spices (cumin, coriander, garam masala)', 2.00, 'tablespoons', 4),
('Garlic', 4.00, 'cloves', 4),
('Ginger', 1.00, 'inch', 4),
('Cilantro', 0.50, 'cup', 4);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Coq au Vin
('Chicken', 4.00, 'pieces', 5),
('Red Wine', 2.00, 'cups', 5),
('Mushrooms', 1.00, 'cup', 5),
('Onion', 1.00, 'large', 5),
('Carrot', 2.00, 'medium', 5),
('Garlic', 4.00, 'cloves', 5),
('Bacon', 4.00, 'slices', 5),
('Thyme', 1.00, 'teaspoon', 5),
('Bay Leaf', 1.00, 'piece', 5);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Sushi Rolls
('Sushi Rice', 1.50, 'cups', 6),
('Rice Vinegar', 2.00, 'tablespoons', 6),
('Nori Sheets', 4.00, 'pieces', 6),
('Fresh Fish', 0.50, 'lbs', 6),
('Avocado', 1.00, 'medium', 6),
('Cucumber', 1.00, 'medium', 6),
('Soy Sauce', 0.00, 'for serving', 6); -- Note: Soy Sauce is typically served on the side

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Pad Thai
('Rice Noodles', 1.00, 'cup', 7),
('Shrimp', 1.00, 'cup', 7),
('Tofu', 1.00, 'cup', 7),
('Peanuts', 0.50, 'cup', 7),
('Vegetable Oil', 2.00, 'tablespoons', 7),
('Garlic', 2.00, 'cloves', 7),
('Ginger', 1.00, 'inch', 7),
('Soy Sauce', 2.00, 'tablespoons', 7),
('Fish Sauce', 1.00, 'tablespoon', 7),
('Lime Juice', 1.00, 'tablespoon', 7),
('Salt', 1.00, 'teaspoon', 7),
('Sugar', 1.00, 'teaspoon', 7),
('Bean Sprouts', 1.00, 'cup', 7),
('Scallions', 0.50, 'cup', 7);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Paella
('Uncooked Rice', 2.00, 'cups', 8),
('Chicken', 1.50, 'lbs', 8),
('Shrimp', 1.00, 'cup', 8),
('Mussels', 1.00, 'cup', 8),
('Clams', 1.00, 'cup', 8),
('Chorizo', 1.00, 'cup', 8),
('Smoked Paprika', 1.00, 'teaspoon', 8),
('Saffron', 0.50, 'teaspoon', 8),
('Garlic', 4.00, 'cloves', 8),
('Onion', 1.00, 'large', 8),
('Tomatoes', 2.00, 'cups', 8),
('Olive Oil', 2.00, 'tablespoons', 8),
('Salt', 1.00, 'teaspoon', 8),
('Black Pepper', 1.00, 'teaspoon', 8);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Cheeseburger
('Ground Beef', 1.00, 'lb', 9),
('Buns', 4.00, 'pieces', 9),
('Cheese', 4.00, 'slices', 9),
('Lettuce', 2.00, 'cups', 9),
('Tomatoes', 2.00, 'cups', 9),
('Onions', 1.00, 'large', 9),
('Pickles', 1.00, 'cup', 9),
('Mayonnaise', 2.00, 'tablespoons', 9),
('Ketchup', 2.00, 'tablespoons', 9),
('Mustard', 1.00, 'tablespoon', 9),
('Salt', 1.00, 'teaspoon', 9),
('Black Pepper', 1.00, 'teaspoon', 9);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Greek Salad
('Cucumbers', 2.00, 'medium', 10),
('Tomatoes', 2.00, 'medium', 10),
('Olives', 1.00, 'cup', 10),
('Feta Cheese', 1.00, 'cup', 10),
('Red Onion', 1.00, 'medium', 10),
('Red Bell Pepper', 1.00, 'medium', 10),
('Kalamata Olives', 1.00, 'cup', 10),
('Feta Cheese Crumbles', 1.00, 'cup', 10),
('Olive Oil', 2.00, 'tablespoons', 10),
('Lemon Juice', 2.00, 'tablespoons', 10),
('Salt', 1.00, 'teaspoon', 10),
('Black Pepper', 1.00, 'teaspoon', 10);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Kimchi
('Napa Cabbage', 2.00, 'cups', 11),
('Korean Chili Flakes (gochugaru)', 2.00, 'tablespoons', 11),
('Garlic', 4.00, 'cloves', 11),
('Ginger', 2.00, 'inches', 11),
('Fish Sauce', 2.00, 'tablespoons', 11),
('Rice Vinegar', 2.00, 'tablespoons', 11),
('Salt', 1.00, 'teaspoon', 11),
('Black Pepper', 1.00, 'teaspoon', 11),
('Scallions', 1.00, 'cup', 11),
('Cilantro', 1.00, 'cup', 11);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Tom Yum Soup
('Shrimp', 1.00, 'cup', 12),
('Lemongrass', 2.00, 'stalks', 12),
('Galangal', 2.00, 'inches', 12),
('Kaffir Lime Leaves', 4.00, 'leaves', 12),
('Mushrooms', 1.00, 'cup', 12),
('Tomatoes', 2.00, 'cups', 12),
('Fish Sauce', 2.00, 'tablespoons', 12),
('Lime Juice', 2.00, 'tablespoons', 12),
('Palm Sugar', 1.00, 'tablespoon', 12),
('Salt', 1.00, 'teaspoon', 12),
('Black Pepper', 1.00, 'teaspoon', 12),
('Thai Chili Peppers', 2.00, 'peppers', 12);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Spanish Tortilla
('Potatoes', 4.00, 'medium', 13),
('Onions', 1.00, 'large', 13),
('Eggs', 6.00, 'large', 13),
('Olive Oil', 4.00, 'tablespoons', 13),
('Salt', 1.00, 'teaspoon', 13),
('Black Pepper', 1.00, 'teaspoon', 13);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Ratatouille
('Zucchini', 1.00, 'medium', 14),
('Eggplant', 1.00, 'medium', 14),
('Bell Peppers', 2.00, 'medium', 14),
('Tomatoes', 2.00, 'medium', 14),
('Onion', 1.00, 'large', 14),
('Garlic', 3.00, 'cloves', 14),
('Olive Oil', 3.00, 'tablespoons', 14),
('Thyme', 1.00, 'teaspoon', 14),
('Basil', 1.00, 'teaspoon', 14),
('Salt', 1.00, 'teaspoon', 14),
('Black Pepper', 1.00, 'teaspoon', 14);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Pasta Primavera
('Pasta', 300.00, 'grams', 15),
('Bell Peppers', 1.00, 'medium', 15),
('Zucchini', 1.00, 'medium', 15),
('Carrots', 2.00, 'medium', 15),
('Cherry Tomatoes', 1.00, 'cup', 15),
('Olive Oil', 3.00, 'tablespoons', 15),
('Garlic', 2.00, 'cloves', 15),
('Parmesan Cheese', 0.50, 'cup', 15), -- Optional
('Salt', 1.00, 'teaspoon', 15),
('Black Pepper', 1.00, 'teaspoon', 15);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Shakshuka
('Eggs', 4.00, 'large', 16),
('Tomatoes', 4.00, 'medium', 16),
('Bell Peppers', 1.00, 'medium', 16),
('Onion', 1.00, 'medium', 16),
('Garlic', 3.00, 'cloves', 16),
('Olive Oil', 2.00, 'tablespoons', 16),
('Cumin', 1.00, 'teaspoon', 16),
('Paprika', 1.00, 'teaspoon', 16),
('Salt', 1.00, 'teaspoon', 16),
('Black Pepper', 1.00, 'teaspoon', 16),
('Fresh Parsley', 0.50, 'cup', 16); -- For garnish

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Fish and Chips
('White Fish Fillets', 500.00, 'grams', 17),
('Potatoes', 4.00, 'medium', 17),
('Flour', 1.00, 'cup', 17),
('Beer or Sparkling Water', 1.00, 'cup', 17),
('Baking Powder', 1.00, 'teaspoon', 17),
('Salt', 1.00, 'teaspoon', 17),
('Black Pepper', 1.00, 'teaspoon', 17),
('Oil', 0.00, 'for frying', 17); -- Note: Quantity for oil can be variable

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Falafel
('Chickpeas', 1.00, 'cup', 18),
('Onion', 1.00, 'medium', 18),
('Garlic', 3.00, 'cloves', 18),
('Fresh Parsley', 0.50, 'cup', 18),
('Cumin', 1.00, 'teaspoon', 18),
('Coriander', 1.00, 'teaspoon', 18),
('Baking Powder', 1.00, 'teaspoon', 18),
('Salt', 1.00, 'teaspoon', 18),
('Black Pepper', 1.00, 'teaspoon', 18),
('Oil', 0.00, 'for frying', 18); -- Note: Quantity for oil can be variable

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Steak Frites
('Steak', 500.00, 'grams', 19),
('Potatoes', 4.00, 'medium', 19),
('Olive Oil', 2.00, 'tablespoons', 19),
('Salt', 1.00, 'teaspoon', 19),
('Black Pepper', 1.00, 'teaspoon', 19),
('Fresh Herbs', 0.50, 'cup', 19); -- For garnish

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Beef Tacos
('Ground Beef', 500.00, 'grams', 20),
('Taco Shells', 8.00, 'pieces', 20),
('Onion', 1.00, 'medium', 20),
('Garlic', 2.00, 'cloves', 20),
('Taco Seasoning', 2.00, 'tablespoons', 20),
('Lettuce', 1.00, 'cup', 20),
('Tomatoes', 2.00, 'medium', 20),
('Cheese', 1.00, 'cup', 20), -- Shredded
('Sour Cream', 0.00, 'for serving', 20), -- Note: Quantity can be variable
('Salsa', 0.00, 'for serving', 20); -- Note: Quantity can be variable

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Lebanese Hummus
('Chickpeas', 1.00, 'can', 21), -- 400 grams, drained
('Tahini', 0.25, 'cup', 21),
('Lemon Juice', 2.00, 'tablespoons', 21),
('Garlic', 2.00, 'cloves', 21),
('Olive Oil', 2.00, 'tablespoons', 21),
('Salt', 1.00, 'teaspoon', 21),
('Cumin', 0.50, 'teaspoon', 21),
('Water', 0.00, 'as needed', 21), -- Note: Quantity can be variable
('Paprika', 0.00, 'for garnish', 21); -- Note: Quantity can be variable

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Brazilian Feijoada
('Black Beans', 2.00, 'cups', 22),
('Pork Shoulder', 500.00, 'grams', 22),
('Beef', 500.00, 'grams', 22),
('Chorizo Sausage', 200.00, 'grams', 22),
('Onion', 1.00, 'large', 22),
('Garlic', 4.00, 'cloves', 22),
('Bay Leaves', 2.00, 'pieces', 22),
('Smoked Paprika', 1.00, 'teaspoon', 22),
('Salt', 1.00, 'teaspoon', 22),
('Black Pepper', 1.00, 'teaspoon', 22),
('Fresh Cilantro', 0.50, 'cup', 22); -- For garnish

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Caribbean Jerk Chicken
('Chicken', 1000.00, 'grams', 23), -- 1 kg
('Jerk Marinade', 1.00, 'cup', 23),
('Green Onions', 4.00, 'pieces', 23),
('Garlic', 4.00, 'cloves', 23),
('Ginger', 1.00, 'inch', 23),
('Lime Juice', 2.00, 'tablespoons', 23),
('Olive Oil', 2.00, 'tablespoons', 23),
('Salt', 1.00, 'teaspoon', 23),
('Black Pepper', 1.00, 'teaspoon', 23);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Baklava
('Filo Dough', 1.00, 'package', 24), -- About 500 grams
('Walnuts', 2.00, 'cups', 24),
('Almonds', 1.00, 'cup', 24),
('Sugar', 1.00, 'cup', 24),
('Butter', 1.00, 'cup', 24),
('Cinnamon', 1.00, 'teaspoon', 24),
('Honey', 1.00, 'cup', 24),
('Water', 1.00, 'cup', 24),
('Vanilla Extract', 1.00, 'teaspoon', 24);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Turkish Kebab
('Ground Lamb or Beef', 500.00, 'grams', 25),
('Onion', 1.00, 'medium', 25),
('Garlic', 3.00, 'cloves', 25),
('Parsley', 0.25, 'cup', 25),
('Cumin', 1.00, 'teaspoon', 25),
('Paprika', 1.00, 'teaspoon', 25),
('Salt', 1.00, 'teaspoon', 25),
('Black Pepper', 1.00, 'teaspoon', 25),
('Skewers', 8.00, 'pieces', 25),
('Flatbread', 0.00, 'for serving', 25); -- Note: Quantity can be variable

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Borscht
('Beets', 3.00, 'medium', 26),
('Cabbage', 0.50, 'head', 26),
('Carrots', 2.00, 'medium', 26),
('Onion', 1.00, 'medium', 26),
('Garlic', 2.00, 'cloves', 26),
('Beef', 300.00, 'grams', 26),
('Vegetable Broth', 4.00, 'cups', 26),
('Tomato Paste', 2.00, 'tablespoons', 26),
('Vinegar', 1.00, 'tablespoon', 26),
('Salt', 1.00, 'teaspoon', 26),
('Black Pepper', 1.00, 'teaspoon', 26),
('Fresh Dill', 0.50, 'cup', 26); -- For garnish

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Moroccan Couscous
('Couscous', 2.00, 'cups', 27),
('Chicken or Lamb', 500.00, 'grams', 27),
('Carrots', 2.00, 'medium', 27),
('Zucchini', 1.00, 'medium', 27),
('Onion', 1.00, 'medium', 27),
('Garlic', 3.00, 'cloves', 27),
('Chickpeas', 1.00, 'can', 27), -- 400 grams, drained
('Spices (cumin, coriander, cinnamon)', 2.00, 'teaspoons', 27),
('Olive Oil', 2.00, 'tablespoons', 27),
('Salt', 1.00, 'teaspoon', 27),
('Black Pepper', 1.00, 'teaspoon', 27),
('Fresh Cilantro', 0.50, 'cup', 27); -- For garnish

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Adobo
('Chicken or Pork', 1000.00, 'grams', 28), -- 1 kg
('Soy Sauce', 0.50, 'cup', 28),
('Vinegar', 0.50, 'cup', 28),
('Garlic', 6.00, 'cloves', 28),
('Onion', 1.00, 'medium', 28),
('Bay Leaves', 2.00, 'pieces', 28),
('Black Pepper', 1.00, 'teaspoon', 28),
('Water', 1.00, 'cup', 28);

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Bratwurst
('Bratwurst Sausages', 4.00, 'pieces', 29),
('Mustard', 0.00, 'for serving', 29), -- Note: Quantity can be variable
('Sauerkraut', 1.00, 'cup', 29),
('Potatoes', 4.00, 'medium', 29), -- Optional side
('Olive Oil', 2.00, 'tablespoons', 29), -- For cooking potatoes
('Salt', 1.00, 'teaspoon', 29), -- For potatoes
('Black Pepper', 1.00, 'teaspoon', 29); -- For potatoes

INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
-- Ingredients for Sauerbraten
('Beef Roast', 1000.00, 'grams', 30), -- 1 kg
('Vinegar', 1.00, 'cup', 30),
('Water', 1.00, 'cup', 30),
('Onion', 1.00, 'large', 30),
('Carrots', 2.00, 'medium', 30),
('Celery', 2.00, 'stalks', 30),
('Garlic', 4.00, 'cloves', 30),
('Bay Leaves', 2.00, 'pieces', 30),
('Black Peppercorns', 1.00, 'teaspoon', 30),
('Sugar', 1.00, 'tablespoon', 30),
('Salt', 1.00, 'teaspoon', 30),
('Oil', 0.00, 'for browning', 30); -- Note: Quantity can be variable

-- Ingredients for Avocado Toast
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
('Whole-grain bread', 2, 'slices', 31),
('Ripe avocado', 1, 'whole', 31),
('Salt', 1, 'to taste', 31),
('Pepper', 1, 'to taste', 31),
('Red pepper flakes', 1, 'to taste', 31),
('Lemon juice', 1, 'to taste', 31);

-- Ingredients for Eggs Benedict
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
('English muffins', 2, 'whole', 32),
('Poached eggs', 4, 'whole', 32),
('Canadian bacon', 4, 'slices', 32),
('Hollandaise sauce', 0.5, 'cup', 32),
('Fresh chives', 1, 'to taste', 32);

-- Ingredients for Berry Smoothie Bowl
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES
('Frozen mixed berries', 1, 'cup', 33),
('Banana', 1, 'whole', 33),
('Greek yogurt', 0.5, 'cup', 33),
('Almond milk', 0.5, 'cup', 33),
('Granola', 1, 'as desired', 33),
('Fresh berries', 1, 'as desired', 33),
('Sliced banana', 1, 'as desired', 33),
('Nuts', 1, 'as desired', 33),
('Seeds', 1, 'as desired', 33);

-- Ingredients for Iced Matcha Latte 
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Matcha powder', 1, 'teaspoon', 34),
('Hot water', 2, 'oz', 34),
('Milk', 6, 'oz', 34),
('Sweetener', 1, 'tablespoon', 34),
('Ice', 1, 'cup', 34);

-- Ingredients for Cucumber Mint Cooler
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Cucumber', 1, 'medium', 35),
('Fresh mint leaves', 10, 'leaves', 35),
('Lime juice', 2, 'tablespoons', 35),
('Honey', 1, 'tablespoon', 35),
('Sparkling water', 1, 'cup', 35);

-- Ingredients for Bruschetta with Tomato and Basil 
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Baguette', 1, 'sliced', 36),
('Tomatoes', 2, 'cups', 36),
('Fresh basil leaves', 1/2, 'cup', 36),
('Garlic', 2, 'cloves', 36),
('Olive oil', 2, 'tablespoons', 36),
('Balsamic vinegar', 1, 'tablespoon', 36),
('Salt', 1, 'to taste', 36),
('Pepper', 1, 'to taste', 36);

-- Ingredients for Stuffed Mushrooms
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Button mushrooms', 1, 'pound', 37),
('Cream cheese', 8, 'ounces', 37),
('Garlic', 2, 'cloves', 37),
('Parmesan cheese', 1/4, 'cup', 37),
('Breadcrumbs', 1/2, 'cup', 37),
('Fresh parsley', 2, 'tablespoons', 37),
('Olive oil', 1, 'tablespoon', 37),
('Salt', 1, 'to taste', 37),
('Pepper', 1, 'to taste', 37);

-- Insert the Ingredients for Mango Lassi
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Yogurt', 1, 'cup', 38),
('Mango', 1, 'cup', 38),
('Milk', 1/2, 'cup', 38),
('Honey', 2, 'tablespoons', 38),
('Cardamom', 1/4, 'teaspoon', 38);

-- Insert Ingredients for Chocolate Chip Cookies 
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Butter', 1, 'cup', 39),
('Sugar', 3/4, 'cup', 39),
('Eggs', 2, 'eggs', 39),
('Flour', 2.25 , 'cups', 39),
('Baking powder', 1, 'teaspoon', 39),
('Salt', 1/2, 'teaspoon', 39),
('Chocolate chips', 2, 'cups', 39);

-- Insert Ingredients for Spicy Roasted Chickpeas (Recipe ID: 40)
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Chickpeas', 1, 'can (15 ounces)', 40),
('Olive oil', 2, 'tablespoons', 40),
('Salt', 1/2, 'teaspoon', 40),
('Cumin', 1/2, 'teaspoon', 40),
('Paprika', 1/4, 'teaspoon', 40),
('Cayenne pepper', 1/4, 'teaspoon', 40);

-- Insert Ingredients for Chicken Alfredo Pasta (Recipe ID: 41)
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Fettuccine pasta', 12, 'ounces', 41),
('Chicken breast', 2, 'pieces', 41),
('Olive oil', 2, 'tablespoons', 41),
('Garlic', 3, 'cloves', 41),
('Heavy cream', 1, 'cup', 41),
('Parmesan cheese', 1, 'cup', 41),
('Salt', 1, 'to taste', 41),
('Black pepper', 1, 'to taste', 41),
('Parsley', 2, 'tablespoons', 41);

-- Insert Ingredients for Vegetable Stir-Fry (Recipe ID: 42)
INSERT INTO Ingredients (name, quantity, measurement_unit, recipe_id) VALUES 
('Mixed vegetables', 4, 'cups', 42),
('Soy sauce', 1/4, 'cup', 42),
('Olive oil', 2, 'tablespoons', 42),
('Garlic', 2, 'cloves', 42),
('Ginger', 1, 'tablespoon', 42),
('Rice', 2, 'cups', 42),
('Sesame seeds', 1, 'tablespoon', 42),
('Green onions', 2, 'pieces', 42);

GO

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

GO








GO

use MyWebsite;
DELETE FROM Ingredients;
DELETE FROM Recipes;
DELETE FROM Cuisines;
DELETE FROM MealTypes;

DROP TABLE Ingredients;
DROP TABLE Recipes; 
DROP TABLE Cuisines;
DROP TABLE MealTypes;

GO

use MyWebsite;
CREATE TABLE Messages ( firstName varchar(20), lastName varchar(20), email varchar(100), message Nvarchar(max) );

GO

use MyWebsite;
SELECT * from Messages;

GO

Delete from Messages;
Drop table Messages;


