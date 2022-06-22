CREATE DATABASE cooking_recipes
GO

USE cooking_recipes
GO

CREATE SCHEMA sh
GO

CREATE TABLE sh.ingredients(
 id int IDENTITY(1,1) PRIMARY KEY,
 ingredient_name nvarchar(60) NOT NULL UNIQUE,
 kcal_per_100grams float NOT NULL
)
GO

CREATE TABLE sh.recipes(
 id int IDENTITY(1,1) PRIMARY KEY,
 recipe_name nvarchar(100) NOT NULL UNIQUE,
)
GO

CREATE TABLE sh.recipe_ingredients(
 id int IDENTITY(1,1) PRIMARY KEY,
 ingredient_id int REFERENCES sh.ingredients,
 recipe_id int REFERENCES sh.recipes,
 amount_in_grams float NOT NULL,
 CONSTRAINT RI_unique UNIQUE NONCLUSTERED (recipe_id, ingredient_id)
)

SELECT TOP 3 i.ingredient_name, i.kcal_per_100grams
FROM sh.ingredients i
INNER JOIN sh.recipe_ingredients ri 
on ri.ingredient_id = i.id
GROUP BY i.ingredient_name, i.kcal_per_100grams
ORDER BY COUNT(i.ingredient_name)