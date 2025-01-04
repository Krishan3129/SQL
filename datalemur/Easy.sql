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





-- Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
-- Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

-- Assumption:

-- No two users have sent the same number of messages in August 2022.
-- messages Table:
-- Column Name	Type
-- message_id	integer
-- sender_id	integer
-- receiver_id	integer
-- content	varchar
-- sent_date	datetime
-- messages Example Input:
-- message_id	sender_id	receiver_id	content	sent_date
-- 901	3601	4500	You up?	08/03/2022 00:00:00
-- 902	4500	3601	Only if you're buying	08/03/2022 00:00:00
-- 743	3601	8752	Let's take this offline	06/14/2022 00:00:00
-- 922	3601	4500	Get on the call	08/10/2022 00:00:00
-- Example Output:
-- sender_id	message_count
-- 3601	2
-- 4500	1



SELECT sender_id, count(message_id) as messages_count
FROM messages
WHERE sent_date BETWEEN '08-01-2022' AND '08-31-2022'
group by sender_id
order by count(message_id) desc
limit 2





-- Assume you're given a table containing job postings from various companies on the LinkedIn platform. 
-- Write a query to retrieve the count of companies that have posted duplicate job listings.

-- Definition:

-- Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
-- job_listings Table:
-- Column Name	Type
-- job_id	integer
-- company_id	integer
-- title	string
-- description	string
-- job_listings Example Input:
-- job_id	company_id	title	description
-- 248	827	Business Analyst	Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.
-- 149	845	Business Analyst	Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.
-- 945	345	Data Analyst	Data analyst reviews data to identify key insights into a business's customers and ways the data can be used to solve problems.
-- 164	345	Data Analyst	Data analyst reviews data to identify key insights into a business's customers and ways the data can be used to solve problems.
-- 172	244	Data Engineer	Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.
-- Example Output:
-- duplicate_companies
-- 1


SELECT COUNT(company_id) - COUNT(DISTINCT(company_id,title,description)) 
AS co_w_duplicate_jobs
FROM job_listings;


-- or

SELECT
  COUNT(a.company_id) as duplicate_companies
FROM 
(
SELECT company_id
FROM job_listings
GROUP BY company_id, title, description
HAVING count(*) > 1
) as a



-- Given a positive integer n
-- n, the Collatz sequence for n 
-- n is generated by repeatedly applying the following operations:

-- If n is even, then n=n/2
-- If n is odd, then n=3∗n+1
-- Repeat the above steps until n becomes 1.

def collatzSteps(n):
  count = 0
  while n != 1:
    if n%2 == 0:
      n = n/2
      count += 1
    else:
      n = 3*n + 1
      count += 1
  
  return count


-- Write a function to get the intersection of two lists.

-- For example, if A = [1, 2, 3, 4, 5], and B = [0, 1, 3, 7] then you should return [1, 3].
def intersection(a, b):
  intersect = []
  for i in a:
    for j in b:
      if i == j:
        intersect.append(i)
  return intersect

-- Write a function fizz_buzz_sum to find the sum of all multiples of 3 or 5 below a target value.

-- For example, if the target value was 10, the multiples of 3 or 5 below 10 are 3, 5, 6, and 9.

-- Because 3+5+6+9=23, our function would return 23.
def fizz_buzz_sum(target):
  sum = 0
  for i in range(target):
    if i%3 == 0 or i%5 == 0:
      sum += i
  return sum


-- Given a number n, write a formula that returns n!.

def factorial(n):
    if n==0:
        return 1
    return n * factorial(n-1)

-- or

def factorial(n):
  i = 1
  result = 1
  while i <= n:
    result = result * i
    i += 1
  return result

-- Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. 
-- The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. Sort the output first by month and then by product ID.

-- P.S. If you've read the Ace the Data Science Interview, and liked it, consider writing us a review?

-- reviews Table:
-- Column Name	Type
-- review_id	integer
-- user_id	integer
-- submit_date	datetime
-- product_id	integer
-- stars	integer (1-5)

SELECT extract(MONTH from submit_date) as month, product_id, round(avg(stars),2)
FROM reviews
group by 1,2
order by 1,2

-- Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

-- Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. 
-- Output the city name and the corresponding number of completed trade orders.

-- trades Table:
-- Column Name	Type
-- order_id	integer
-- user_id	integer
-- quantity	integer
-- status	string ('Completed', 'Cancelled')
-- date	timestamp
-- price	decimal (5, 2)

-- users Table:
-- Column Name	Type
-- user_id	integer
-- city	string
-- email	string
-- signup_date	datetime
    
SELECT US.city, Count(*) as total_orders
FROM trades T
Left JOIN users US
ON T.user_id = US.user_id
where T.status ='Completed'
GROUP BY US.city
order by total_orders desc
limit 3


-- Given an list of integers called input, return True if any value appears at least twice in the array. 
-- Return False if every element in the input list is distinct.

-- For example, if the input list was [1,3,5,7,1], then return True because the number 1 shows up twice.

-- However, if the input was [1,3,5,7] then return False, because every element of the list is distinct.


def contains_duplicate(input):
  for i in range(len(input)-1):
    for j in range(i+1, len(input)):
      if (input[i] == input[j]):
        return True
  return False 

-- or

def contains_duplicate(input)-> bool:
  new_list = list(set(input))
  if new_list == input:
    return False
  else:
    return True




-- Given an array containing exactly three unique points, each represented as coordinate pairs (x, y) with no duplicates, 
-- determine whether these points lie on the same straight line. Return True if they do, and False otherwise.

def on_straight_line(points):
  
  a, b = points[0]
  m, n = points[1]
  x, y = points[2]
	
  if (n-b) * (x-m) == (y-n) * (m-a):
    return True
	  
  else:
    return False

-- our team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued each month.

-- Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest issuance cards and the lowest issuance. Arrange the results based on the largest disparity.

-- monthly_cards_issued Table:
-- Column Name	Type
-- card_name	string
-- issued_amount	integer
-- issue_month	integer
-- issue_year	integer

SELECT card_name, MAX(issued_amount)-MIN(issued_amount) as difference
FROM monthly_cards_issued
group by card_name
order by difference DESC




SELECT
  ROUND(100.0 * 
    SUM(CASE WHEN call_category IS NULL OR call_category = 'n/a'
      THEN 1
      ELSE 0
      END)
    /COUNT(*), 1) AS uncategorised_call_pct
FROM callers



-- Assume you have an events table on Facebook app analytics. 
-- Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.

-- Definition and note:

-- Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
-- To avoid integer division, multiply the CTR by 100.0, not 100.\


SELECT 
  app_id,
 ROUND(100.0 *
    sum(case WHEN event_type = 'click' then 1 ELSE 0 END) / 
    sum(case WHEN event_type = 'impression' then 1 ELSE 0 END),2) as ctr
FROM events
WHERE timestamp BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY app_id;

-- Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. 
-- New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

-- Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

-- Definition:

-- action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.
-- emails Table:
-- Column Name	Type
-- email_id	integer
-- user_id	integer
-- signup_date	datetime

-- texts Table:
-- Column Name	Type
-- text_id	integer
-- email_id	integer
-- signup_action	string ('Confirmed', 'Not confirmed')
-- action_date	datetime

SELECT e.user_id
FROM emails e
left JOIN texts t
ON e.email_id = t.email_id
group by e.user_id
having count(t.email_id)=2
