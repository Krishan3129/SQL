-- Question 1
-- Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. 
-- Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

-- In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

-- tweets Table:
-- Column Name	Type
-- tweet_id	integer
-- user_id	integer
-- msg	string
-- tweet_date	timestamp
-- tweets Example Input:
-- tweet_id	user_id	msg	tweet_date
-- 214252	111	Am considering taking Tesla private at $420. Funding secured.	12/30/2021 00:00:00
-- 739252	111	Despite the constant negative press covfefe	01/01/2022 00:00:00
-- 846402	111	Following @NickSinghTech on Twitter changed my life!	02/14/2022 00:00:00
-- 241425	254	If the salary is so competitive why won’t you tell me what it is?	03/01/2022 00:00:00
-- 231574	148	I no longer have a manager. I can't be managed	03/23/2022 00:00:00
-- Example Output:
-- tweet_bucket	users_num
-- 1	2
-- 2	1
-- Explanation:
-- Based on the example output, there are two users who posted only one tweet in 2022, and one user who posted two tweets in 2022. 
-- The query groups the users by the number of tweets they posted and displays the number of users in each group.

select tweet_bucket, count(*) as users_num 
FROM 
    (SELECT user_id, count(*) as tweet_bucket FROM tweets 
    where tweet_date Between '01/01/2022'  and '12/31/2022'
    group by user_id) as a 
group by tweet_bucket order by 1 ;



-- Question 2
-- Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. 
-- You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

-- Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

-- Assumption:

-- There are no duplicates in the candidates table.
-- candidates Table:
-- Column Name	Type
-- candidate_id	integer
-- skill	varchar
-- candidates Example Input:
-- candidate_id	skill
-- 123	Python
-- 123	Tableau
-- 123	PostgreSQL
-- 234	R
-- 234	PowerBI
-- 234	SQL Server
-- 345	Python
-- 345	Tableau
-- Example Output:
-- candidate_id
-- 123
-- Explanation
-- Candidate 123 is displayed because they have Python, Tableau, and PostgreSQL skills. 
-- 345 isn't included in the output because they're missing one of the required skills: PostgreSQL.

SELECT candidate_id 
FROM candidates
where skill IN ('Python','Tableau','PostgreSQL')
group by candidate_id 
having count(skill)=3



-- Question 3
-- Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

-- Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

-- pages Table:
-- Column Name	Type
-- page_id	integer
-- page_name	varchar
-- pages Example Input:
-- page_id	page_name
-- 20001	SQL Solutions
-- 20045	Brain Exercises
-- 20701	Tips for Data Analysts
-- page_likes Table:
-- Column Name	Type
-- user_id	integer
-- page_id	integer
-- liked_date	datetime
-- page_likes Example Input:
-- user_id	page_id	liked_date
-- 111	20001	04/08/2022 00:00:00
-- 121	20045	03/12/2022 00:00:00
-- 156	20001	07/25/2022 00:00:00
-- Example Output:
-- page_id
-- 20701

SELECT a.page_id
FROM pages a
left JOIN page_likes b
ON a.page_id = b.page_id
WHERE b.liked_date is NULL
ORDER by a.page_id ASC


-- Tesla is investigating production bottlenecks and they need your help to extract the relevant data. 
-- Write a query to determine which parts have begun the assembly process but are not yet finished.

-- Assumptions:

-- parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
-- An unfinished part is one that lacks a finish_date.
-- This question is straightforward, so let's approach it with simplicity in both thinking and solution.

-- Effective April 11th 2023, the problem statement and assumptions were updated to enhance clarity.

-- parts_assembly Table
-- Column Name	Type
-- part	string
-- finish_date	datetime
-- assembly_step	integer
-- parts_assembly Example Input
-- part	finish_date	assembly_step
-- battery	01/22/2022 00:00:00	1
-- battery	02/22/2022 00:00:00	2
-- battery	03/22/2022 00:00:00	3
-- bumper	01/22/2022 00:00:00	1
-- bumper	02/22/2022 00:00:00	2
-- bumper		3
-- bumper		4
-- Example Output
-- part	assembly_step
-- bumper	3
-- bumper	4

SELECT part, assembly_step 
FROM parts_assembly
where finish_date is NULL


-- Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

-- Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. 
-- Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

-- Effective 15 April 2023, the solution has been updated with a more concise and easy-to-understand approach.

-- viewership Table
-- Column Name	Type
-- user_id	integer
-- device_type	string ('laptop', 'tablet', 'phone')
-- view_time	timestamp
-- viewership Example Input
-- user_id	device_type	view_time
-- 123	tablet	01/02/2022 00:00:00
-- 125	laptop	01/07/2022 00:00:00
-- 128	laptop	02/09/2022 00:00:00
-- 129	phone	02/09/2022 00:00:00
-- 145	tablet	02/24/2022 00:00:00
-- Example Output
-- laptop_views	mobile_views
-- 2	3
    
SELECT 
(SELECT
COUNT(user_id) 
FROM viewership
WHERE device_type='laptop') as laptop_views,

COUNT(user_id) as mobile_views 
FROM viewership
WHERE device_type in ('tablet', 'phone');



-- OR 


    
SELECT 
Sum (CASE When device_type='laptop' then 1 else 0 END) as laptop_views,
Sum (CASE When device_type IN ('phone','tablet') then 1 else 0 END) as mobile_views
FROM viewership;




-- Given a table of Facebook posts, for each user who posted at least twice in 2021, 
-- write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. 
-- Output the user and number of the days between each user's first and last post.

-- p.s. If you've read the Ace the Data Science Interview and liked it, consider writing us a review?

-- posts Table:
-- Column Name	Type
-- user_id	integer
-- post_id	integer
-- post_content	text
-- post_date	timestamp
-- posts Example Input:
-- user_id	post_id	post_content	post_date
-- 151652	599415	Need a hug	07/10/2021 12:00:00
-- 661093	624356	Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that's gonna fly by. I miss my girlfriend	07/29/2021 13:00:00
-- 004239	784254	Happy 4th of July!	07/04/2021 11:00:00
-- 661093	442560	Just going to cry myself to sleep after watching Marley and Me.	07/08/2021 14:00:00
-- 151652	111766	I'm so done with covid - need travelling ASAP!	07/12/2021 19:00:00
-- Example Output:
-- user_id	days_between
-- 151652	2
-- 661093	21

SELECT user_id, EXTRACT(day from (max(post_date)-min(post_date))) as days_between
FROM posts
where post_date between '01/01/2021' and '12/31/2021'
GROUP by user_id
having count(post_date)>1
