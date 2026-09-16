create table employee
(
employee_id int,
employee_name varchar(20),
department varchar(20),
state varchar(20),
salary int,
age int,
bonus int
)

delete from employee

select * from employee

bulk insert employee from "C:\Users\dell\OneDrive\Desktop\OfficeData.csv"
with
(
format='CSV',
firstrow=2
)

alter table employee
alter column employee_name varchar(50)

with ranked as
(
select employee_id,employee_name,salary,
dense_rank() over(order by salary desc) as rnk
from employee
)
select * from ranked
where rnk=2

WITH ranked AS (
    SELECT employee_id,
           employee_name,
           salary,
           ROW_NUMBER() OVER (
               PARTITION BY employee_id
               ORDER BY employee_id
           ) AS rn
    FROM employee
)
select *
FROM ranked
WHERE rn > 1;

SELECT employee_id, employee_name, salary, COUNT(*) AS cnt
FROM employee
GROUP BY employee_id, employee_name, salary
HAVING COUNT(*) > 1;

delete from employee

WITH ranked AS (
    SELECT employee_id,
           employee_name,
           salary,
          row_number() OVER (
               PARTITION BY employee_id
               ORDER BY employee_id
           ) AS rn
    FROM employee
)
delete FROM ranked
WHERE rn > 1;

select * from employee

with ranked as(
select *,
row_number() over(partition by department order by salary desc) as rn,
rank() over(partition by department order by salary desc) as rnk,
dense_rank() over(partition by department order by salary desc) as densernk
from employee
)
select * from ranked
where rn <=5

SELECT top 5 employee_id, employee_name, salary
FROM employee
ORDER BY salary DESC;

WITH ranked AS (
    SELECT employee_id,
           employee_name,
           salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employee
)
SELECT distinct *
FROM ranked
WHERE rnk = 10;

select department, sum(salary) as total_exp
from employee
group by department

select * from employee

alter table employee
add joined_date date

WITH join_month AS (
    SELECT employee_id,
           employee_name,
           joined_date,
           DENSE_RANK() OVER (ORDER BY joined_date desc) AS L6M
    FROM employee
)
SELECT *
FROM join_month
WHERE L6M <=6

SELECT employee_id,
       employee_name,
       joined_date
FROM employee
WHERE joined_date >= DATEADD(MONTH, -6, GETDATE());

SELECT GETDATE() AS CurrentDateTime;

select count(*) as total_emp, department 
from employee
group by department