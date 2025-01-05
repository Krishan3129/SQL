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

-- or

SELECT t.user_id, t.spend, t.transaction_date
FROM
(
  select user_id, spend, transaction_date,
  row_number() over (PARTITION by user_id order by transaction_date) as trans_no
  from transactions
) t
where t.trans_no = 3



-- Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. 
-- Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

-- It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.

-- employee Schema:
-- column_name	type	description
-- employee_id	integer	The unique ID of the employee.
-- name	string	The name of the employee.
-- salary	integer	The salary of the employee.
-- department_id	integer	The department ID of the employee.
-- manager_id	integer	The manager ID of the employee.

SELECT salary
FROM employee
order by salary DESC
OFFSET 1
limit 1

-- or

select max(salary) 
from employee 
where salary not in (select max(salary) from employee)



