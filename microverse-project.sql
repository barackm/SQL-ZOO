-- What's the capital of France?

SELECT population FROM world
  WHERE name = 'France';

  
SELECT population FROM world
  WHERE name = 'Germany';
  
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;

-- Read the notes about this table. Observe the result of running this SQL command
--  to show the name, continent and population of all countries.

SELECT name, continent, population FROM world;

-- How to use WHERE to filter records. Show the name for the countries that have a population 
-- of at least 200 million. 200 million is 200000000, there are eight zeros

SELECT name
  FROM world
 WHERE population > 200000000;
 
-- Give the name and the per capita GDP for those countries with a population of at least 200 million.

SELECT name, 
  gdp/population 
  FROM world WHERE population >= 200000000;

-- Show the name and population in millions for the countries of the continent
--  'South America'. Divide the population by 1000000 to get population in millions.

SELECT name, 
  population/1000000 
  FROM world WHERE continent = 'South America';
  
-- Show the name and population for France, Germany, Italy

SELECT name, 
  population FROM world WHERE name IN ('France', 'Germany', 'Italy');
  
-- Show the countries which have a name that includes the word 'United'
  
SELECT name 
  FROM world WHERE name LIKE '%United%';
  
--   Two ways to be big: A country is big if it has an area of more than 3 million sq km
--   or it has a population of more than 250 million.
-- Show the countries that are big by area or big by population. Show name, population and area.

SELECT name, 
  population, 
  area 
  FROM world WHERE area > 3000000 OR population > 250000000;
  
-- Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) 
-- or big by population (more than 250 million) but not both. Show name, population and area.

-- Australia has a big area but a small population, it should be included.
-- Indonesia has a big population but a small area, it should be included.
-- China has a big population and big area, it should be excluded.
-- United Kingdom has a small population and a small area, it should be excluded.

SELECT name, 
  population, 
  area
  FROM world WHERE (area > 3000000 AND NOT population > 250000000) 
  OR (population > 250000000 AND NOT area > 3000000);
  
-- Show the name and population in millions and the GDP in billions for the countries 
-- of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
-- For South America show population in millions and GDP in billions both to 2 decimal places.

SELECT name, 
  ROUND(population/1000000,2), 
  ROUND(gdp/1000000000,2) 
  FROM world WHERE continent = 'South America';
  
-- Show the name and per-capita GDP for those countries with a GDP 
-- of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.

SELECT name, 
  ROUND(gdp/population,-3) FROM world WHERE gdp >= 1000000000000;
  
-- Greece has capital Athens.
-- Each of the strings 'Greece', and 'Athens' has 6 characters.
-- Show the name and capital where the name and the capital have the same number of characters.
-- You can use the LENGTH function to find the number of characters in a string
  
SELECT name,
  capital
  FROM world
  WHERE LENGTH(name) = LENGTH(capital);

-- The capital of Sweden is Stockholm. Both words start with the letter 'S'.

-- Show the name and the capital where the first letters of each match. Don't include
--  countries where the name and the capital are the same word.
-- You can use the function LEFT to isolate the first character.
-- You can use <> as the NOT EQUALS operator.

SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital;

-- Equatorial Guinea and Dominican Republic have all of the vowels 
-- (a e i o u) in the name. They don't count because they have more than one word in the name.

-- Find the country that has all the vowels and no spaces in its name.

-- You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
-- The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'

SELECT name
   FROM world
   WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%'
  AND name NOT LIKE '% %';

-- Change the query shown so that it displays Nobel prizes for 1950.

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;
 
 -- Show who won the 1962 prize for Literature.
 
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';
  
-- Show the year and subject that won 'Albert Einstein' his prize.
  
SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein';

-- Give the name of the 'Peace' winners since the year 2000, including 2000.

SELECT winner FROM nobel WHERE subject = 'Peace' AND yr >= 2000;

-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.

SELECT * FROM nobel WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989;

-- Show all details of the presidential winners:

-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama'
                  );
                  
-- Show the winners with first name John
                  
SELECT winner FROM nobel WHERE winner LIKE 'John%';

-- Show the year, subject, and name of Physics winners for 1980 together 
-- with the Chemistry winners for 1984.

SELECT yr, 
 subject, winner 
 FROM nobel WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984);


-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
            
SELECT yr, 
subject, winner 
FROM nobel WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine');


-- Show year, subject, and name of people who won a 'Medicine' prize
--  in an early year (before 1910, not including 1910) together with winners of a 'Literature' 
-- prize in a later year (after 2004, including 2004)

SELECT yr, 
subject, winner 
FROM nobel WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);
  
-- Find all details of the prize won by PETER GRÜNBERG
  
SELECT * FROM nobel WHERE winner = 'PETER GRÜNBERG';

-- Find all details of the prize won by EUGENE O'NEILL

SELECT * FROM nobel WHERE winner = 'EUGENE O\'NEILL';

-- List the winners, year and subject where the winner starts with Sir.
--  Show the the most recent first, then by name order.

SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%'
ORDER BY yr DESC; 

-- Show the 1984 winners and subject ordered by subject and winner name; 
-- but list Chemistry and Physics last.

SELECT winner, subject 
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Chemistry','Physics'),subject, winner;
 
--  List each country name where the population is larger than that of 'Russia'.
-- world(name, continent, area, population, gdp)

 SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');
      
--       
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name 
FROM world WHERE continent = 'Europe' 
AND gdp / population  > (SELECT gdp/population FROM world WHERE name = 'United Kingdom' );

 
--  List the name and continent of countries in the continents containing either 
--  Argentina or Australia. Order by name of the country.
 
SELECT name, continent FROM world WHERE continent IN(
SELECT continent FROM world
WHERE name IN ('Argentina','Australia')
);

-- Which country has a population that is more than 
-- Canada but less than Poland? Show the name and the population.

SELECT name, 
population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') 
AND population < (SELECT population FROM world WHERE name = 'Poland');


-- Percentages of Germany

SELECT name, 
CONCAT(ROUND(population * 100 / (SELECT population FROM world WHERE name = 'Germany')), '%')
 AS percentage FROM world WHERE continent = 'Europe';
 

-- Which countries have a GDP greater than every country in Europe?
--  [Give the name only.] (Some countries may have NULL gdp values)

SELECT name FROM world WHERE gdp >
(SELECT MAX(gdp) AS geater_gdp FROM 
world WHERE continent = 'Europe');

-- Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT continent, name, area
	FROM world x
	WHERE x.area >= ALL (
		SELECT MAX(area) FROM world y
		WHERE x.continent = y.continent);
    
-- List each continent and the name of the country that comes first alphabetically.
    
SELECT continent, name FROM world w
WHERE name = 
(SELECT TOP 1 name FROM world WHERE continent = w.continent );

-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated 
-- with these continents. Show name, continent and population.

SELECT name, continent, population 
FROM world w
WHERE NOT EXISTS (                 
   SELECT *
   FROM world nx
   WHERE nx.continent = w.continent 
   AND nx.population > 25000000    
   );
   
-- Some countries have populations more than three times that of any of their neighbours
-- (in the same continent). Give the countries and continents.
   
SELECT name, continent FROM world w WHERE 
population > 
ALL (SELECT population * 3 FROM world wx WHERE w.continent = wx.continent AND w.name != wx.name
)

-- Show the total population of the world.

SELECT SUM(population)
FROM world

-- List all the continents - just once each.

SELECT DISTINCT continent FROM world

-- Give the total GDP of Africa

SELECT SUM(gdp) AS gdp FROM world WHERE continent = 'Africa' 

-- How many countries have an area of at least 1000000

SELECT COUNT(name) as name FROM world WHERE area >= 1000000

-- What is the total population of ('Estonia', 'Latvia', 'Lithuania')

SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

-- For each continent show the continent and number of countries.

SELECT continent, COUNT(name) FROM world GROUP BY continent

-- For each continent show the continent and number of countries with populations of at least 10 million.

SELECT continent, COUNT(name) FROM world W 
WHERE W.population >= 10000000
GROUP BY continent

-- List the continents that have a total population of at least 100 million.

SELECT continent FROM
(SELECT continent, SUM(population) AS total FROM world
GROUP BY continent  
HAVING total >= 100000000)
AS new_list;


-- The first example shows the goal scored by a player with the last name 'Bender'. 
-- The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
-- Modify it to show the matchid and player name for all goals scored by Germany.
--  To identify German players, check for: teamid = 'GER'

SELECT matchid, player FROM goal g
JOIN eteam t ON g.teamid =  t.id
  WHERE  g.teamid = 'GER';
  
  
-- From the previous query you can see that Lars Bender's
--  scored a goal in game 1012. Now we want to know what teams were playing in that match.
-- Notice in the that the column matchid in the goal table corresponds to the id column in the game table. 
-- We can look up information about game 1012 by finding that row in the game table.
-- Show id, stadium, team1, team2 for just game 1012

  SELECT g.id, g.stadium, g.team1,g.team2
  FROM game g 
WHERE g.id = 1012;


-- The FROM clause says to merge data from the goal table with that from the game table. 
-- The ON says how to figure out which rows in game go with which rows in goal - the matchid
--  from goal must match id from game. (If we wanted to be more clear/specific we could say
-- ON (game.id=goal.matchid)
-- The code below shows the player (from the goal) and stadium name (from the game table)
--  for every goal scored.
-- Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
  FROM game  
JOIN goal ON matchid = id 
WHERE teamid = 'GER';

-- Use the same JOIN as in the previous question.
-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'


SELECT team1, team2, player FROM game
JOIN goal ON matchid = id
WHERE player LIKE 'Mario%';

-- The table eteam gives details of every national team including the coach.
--  You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10


SELECT player, teamid,coach, gtime
  FROM goal 
JOIN eteam ON teamid=id
 WHERE gtime<=10;
 
-- To JOIN game with eteam you could use either
-- game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
-- Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
--  
 
 SELECT mdate, teamname FROM game 
JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos';

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player FROM goal 
JOIN game ON id = matchid
WHERE stadium = 'National Stadium, Warsaw';

-- The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.



SELECT DISTINCT player
  FROM game 
JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid != 'GER' ;


-- Show teamname and the total number of goals scored.
    
SELECT teamname, COUNT(teamid)
  FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
 ORDER BY teamname;
 
 -- Show the stadium and the number of goals scored in each stadium.
 
 SELECT stadium, COUNT(teamid) FROM game
JOIN goal on matchid = id
GROUP BY stadium;

-- For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid, mdate, COUNT(player) FROM game
JOIN goal on id = matchid
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate;

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(mdate) FROM game 
JOIN goal on id = matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

-- Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1,
--  otherwise there is a 0.
--  You could SUM this column to get a count of the goals scored by team1. 
--  Sort your result by mdate, matchid, team1 and team2.

SELECT mdate, team1,
SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
team2,
SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game
LEFT JOIN goal ON id = matchid
GROUP BY mdate,team1,team2, matchid
ORDER BY mdate, matchid, team1, team2;

-- ****** More JOIN operations  ******


-- List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962;

-- Give year of 'Citizen Kane'.

SELECT yr FROM movie
WHERE title = 'Citizen Kane';


-- List all of the Star Trek movies, include the id, 
-- title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- What id number does the actor 'Glenn Close' have?

SELECT id FROM actor
WHERE name = 'Glenn Close';

-- What is the id of the film 'Casablanca'

SELECT id FROM movie WHERE title = 'Casablanca';

-- Obtain the cast list for 'Casablanca'.
-- what is a cast list?
-- Use movieid=11768, (or whatever value you got from the previous question)

SELECT name FROM casting
JOIN movie m ON movieid = m.id
JOIN actor a ON a.id = actorid 
WHERE movieid = 11768;

-- Obtain the cast list for the film 'Alien'

SELECT name FROM casting
JOIN movie m ON movieid = m.id
JOIN actor a ON a.id = actorid 
WHERE title ='Alien';

-- List the films in which 'Harrison Ford' has appeared

SELECT title FROM movie
JOIN casting c ON c.movieid = id
JOIN actor a ON a.id = actorid
WHERE name = 'Harrison Ford';

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. 
-- [Note: the ord field of casting gives the position of the actor.
--  If ord=1 then this actor is in the starring role]

SELECT title FROM movie
JOIN casting c ON c.movieid = id
JOIN actor a ON a.id = actorid
WHERE name = 'Harrison Ford' AND c.ord <> 1;


-- List the films together with the leading star for all 1962 films.

SELECT title, a.name
FROM movie
JOIN casting ON movieid = id
JOIN actor a ON a.id = actorid
WHERE yr = 1962 AND ord = 1;


-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made
--  each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;


-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
-- Did you get "Little Miss Marker twice"?

SELECT m.title, a.name
FROM movie m
JOIN casting c ON c.movieid = m.id
JOIN actor a ON a.id = actorid
WHERE  'Julie Andrews' IN (
   SELECT name FROM 
   actor aa
   JOIN casting cc ON cc.actorid = aa.id
   WHERE cc.movieid = m.id
)
AND ord = 1;

-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.


SELECT name FROM actor JOIN casting ON actor.id = actorid WHERE ord = 1 GROUP BY name
  HAVING COUNT(movieid) >= 15;
  
-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.  

SELECT title,
 COUNT(actorid) FROM movie JOIN casting ON movie.id = movieid WHERE yr = 1978
  GROUP BY title ORDER BY COUNT(actorid) DESC, title;
  
-- List all the people who have worked with 'Art Garfunkel'.


SELECT name FROM actor JOIN casting ON actor.id = actorid
WHERE movieid IN
  (SELECT id FROM movie WHERE title IN
    (SELECT title FROM movie JOIN casting ON movie.id = movieid WHERE actorid IN
      (SELECT id FROM actor WHERE name = 'Art Garfunkel')))
  AND name != 'Art Garfunkel';


-- **** Using Null *** 


-- List the teachers who have NULL for their department.
-- Why we cannot use =

SELECT t.name FROM teacher t 
WHERE t.dept IS NULL;

-- Note the INNER JOIN misses the teachers with no department and the departments with no teacher.


SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id);
           
-- Use a different JOIN so that all teachers are listed.
           
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id);


-- Use a different JOIN so that all departments are listed.


SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id);
           
         
-- Use COALESCE to print the mobile number. 
-- Use the number '07986 444 2266' if there is no number given.
--  Show teacher name and mobile number or '07986 444 2266'
       
SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher;

-- Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. 
-- Use the string 'None' where there is no department.

SELECT t.name, COALESCE(dept.name, 'None')
FROM teacher t
LEFT JOIN dept ON t.dept = dept.id