-- Question 1
-- Assume you are given the table below on Uber transactions made by users. 
-- Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

-- transactions Table:
-- Column Name	Type
-- user_id	integer
-- spend	decimal
-- transaction_date	timestamp

select user_id, spend, transaction_date
from transactions
where (user_id, transaction_date) in
(select user_id, max(transaction_date) transaction_date
from transactions
group by 1
having count(user_id) = 3)
