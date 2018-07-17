/*
SQL Intensive Capstone - Warkby Parker
Kwun Lai July 2018
*/

/*
Quiz Funnel - 1
*/
SELECT * FROM survey LIMIT 10;
/*
Query selects first 10 entries of the ‘survey’ database and displays it
*/


/*
Quiz Funnel - 2
*/
SELECT 
question AS 'Question',
COUNT(user_id) AS '# Answered' 
FROM survey
GROUP BY 1;

/*
Query selects column question, capitalizes it for style, and counts distinct user_ids and renames the column AS “# Answered” for readability. Then it sorts the columns by ‘question’.
*/


/*
Home-Try-On Funnel - 1
*/
SELECT * FROM quiz LIMIT 5;
SELECT * FROM home_try_on LIMIT 5;
SELECT * FROM purchase LIMIT 5;
/*
This query selects first 5 rows of the quiz, home_try_on and purchase tables.
*/


/*
Home-Try-On Funnel - 2
*/
SELECT DISTINCT q.user_id,
   CASE
      WHEN h.user_id IS NOT NULL THEN 'True'
      ELSE 'False'
   END AS 'is_home_try_on',
   h.number_of_pairs,
   CASE
   	  WHEN p.user_id IS NOT NULL THEN 'True'
      ELSE 'False'
   END AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
LIMIT 10;
/*
Case statement used to enhance 'readability'. Instead of 1 and 0, we have true or false
*/

/*
Home-Try-On Funnel - 3 - Conversion Rates
*/
WITH warby_funnel_t AS (
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
)
SELECT 
COUNT(*) AS 'Users',
SUM(is_home_try_on) AS 'Total Home Try On',
SUM(is_purchase) AS 'Purchased'
FROM warby_funnel_t;

WITH warby_funnel_3 AS (
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
WHERE h.number_of_pairs = '3 pairs'
)
SELECT 
COUNT(*) AS 'Users',
SUM(is_home_try_on) AS '3 Pairs Home Try On',
SUM(is_purchase) AS 'Purchased'
FROM warby_funnel_3;

WITH warby_funnel_5 AS (
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
WHERE h.number_of_pairs = '5 pairs'
)
SELECT 
COUNT(*) AS 'Users',
SUM(is_home_try_on) AS '5 Pairs Home Try On',
SUM(is_purchase) AS 'Purchased'
FROM warby_funnel_5;
/*
We can compare conversion rates with the 3 queries above. They compare total, 3 pairs and 5 pairs along with how many users made a purchase at the end.
*/

/*
Home-Try-On Funnel - 4 - Popularity (Quiz)
*/

SELECT 
   style, 
   fit, 
   shape, 
   color, 
   COUNT(user_id) 
FROM quiz
GROUP BY 1,2,3,4;
/*
Simple query just outputs all columns and groups them together
*/

/*
Home-Try-On Funnel - 5 - Purchase
*/

SELECT 
   product_id, 
   style, 
   model_name, 
   color, 
   price, 
   COUNT(user_id) 
FROM purchase
GROUP BY 1,2,3,4,5;
/*
Simple query just outputs all columns and groups them together
*/
