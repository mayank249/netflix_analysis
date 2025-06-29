/*use netflix ;
drop table netflix1;
CREATE TABLE netflix1
(
    show_id      VARCHAR(5),
    type_         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description_  VARCHAR(550)
);*/



#1. Count the number of Movies vs TV Shows
/*SELECT type_, COUNT(*) AS count
FROM netflix1
GROUP BY type_;*/
 
 #2. Find the most common rating for movies and TV shows
 /*SELECT type_, rating, COUNT(*) AS count
FROM netflix1
GROUP BY 1,2;*/

#3 List all movies released in a specific year (e.g., 2020)
/*select
 distinct release_year , title , type_
from netflix1 
where type_ = 'movie' and release_year = '2020'*/

#4  Find the top 5 countries with the most content on Netflix
/*SELECT 
  SUBSTRING_INDEX(country, ',', 1) AS primary_country, -- USA,India, JAPAN
  COUNT(*) AS total_titles
FROM netflix1
WHERE country IS NOT NULL AND country != '' -- can also use country <> ''
GROUP BY primary_country
ORDER BY total_titles DESC
LIMIT 5;*/

#5 5. Identify the longest movie
/*SELECT 
    *
FROM netflix1
WHERE type_ = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
limit 1;*/

#6. Find content added in the last 5 years
/*select title , type_ , release_year
from netflix1
where release_year between 2017 and 2021;*/

#7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
/*select type_ , title , 
SUBSTRING_INDEX(director, ',', 1) AS primary_country
from netflix1
where director = 'Rajiv Chilaka'*/

#8. List all TV shows with more than 5 seasons
/*select title , duration , CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) as duration 
from netflix1
where CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)  > 5 and type_ = 'TV Show' and type_ is not null */

#9 Count the number of content items in each genre
/*WITH RECURSIVE genre_split AS (
  SELECT 
    show_id,
    title,
    TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
    SUBSTRING(listed_in, LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2) AS rest
  FROM netflix1
  WHERE listed_in IS NOT NULL

  UNION ALL

  SELECT
    show_id,
    title,
    TRIM(SUBSTRING_INDEX(rest, ',', 1)),
    SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ',', 1)) + 2)
  FROM genre_split
  WHERE rest != ''
)

SELECT 
  genre,
  COUNT(*) AS content_count
FROM genre_split
GROUP BY genre
ORDER BY content_count DESC;*/

/*10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

SELECT 
    release_year,
    COUNT(*) AS total_content
FROM netflix1
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC
LIMIT 5;*/

/*11. List all movies that are documentaries
select type_ , count(*)
from netflix1
where type_ = 'Movie' and listed_in = 'documentaries'*/

/*12. Find all content without a director
select *
from netflix1
where director is null or director =''*/

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

/*select title , casts
from netflix1
where 
casts like '%Salman Khan%'*/

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

/*WITH RECURSIVE actor_split AS (
  SELECT 
    show_id,
    TRIM(SUBSTRING_INDEX(cast, ',', 1)) AS actor,
    SUBSTRING(cast, LENGTH(SUBSTRING_INDEX(cast, ',', 1)) + 2) AS rest
  FROM netflix1
  WHERE type = 'Movie' AND country LIKE '%India%' AND cast IS NOT NULL

  UNION ALL

  SELECT
    show_id,
    TRIM(SUBSTRING_INDEX(rest, ',', 1)),
    SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ',', 1)) + 2)
  FROM actor_split
  WHERE rest IS NOT NULL AND rest != ''
)

SELECT 
  actor,
  COUNT(*) AS movie_count
FROM netflix1
GROUP BY casts
ORDER BY movie_count DESC
LIMIT 10;*/

/* 15 Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.


SELECT 
  CASE
    WHEN LOWER(description_) LIKE '%kill%' OR LOWER(description_) LIKE '%violence%' THEN 'Bad'
    ELSE 'Good'
  END AS content_category,
  COUNT(*) AS total_items
FROM netflix1
GROUP BY content_category;*/



