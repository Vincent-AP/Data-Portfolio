--- PREVIEW THE TABLE CONTENTS---
SELECT * from employees;
SELECT * from shops;
Select * from locations;
select * from suppliers;

--- Searching for salary data ---
Select first_name , last_name , coffeeshop_id , 
salary from employees;

--- Select the top 5 paid employees from CommonGrounds ---
select e.first_name , e.last_name ,s.coffeeshop_name, e.salary 
from employees e left join shops s on e.coffeeshop_id
=s.coffeeshop_id 
where e.coffeeshop_id = 1 order by salary desc limit 5;

--- Select the top 5 paid employees from Early Rise ---
select first_name , last_name ,coffeeshop_name, salary 
from employees left join shops on employees.coffeeshop_id
=shops.coffeeshop_id 
where employees.coffeeshop_id = 2 order by salary desc limit 5;

--- Select the top 5 paid employees from Ancient Bean ---
select first_name , last_name ,coffeeshop_name, salary 
from employees left join shops on employees.coffeeshop_id
=shops.coffeeshop_id 
where employees.coffeeshop_id = 3 order by salary desc limit 5;

--- Select the top 5 paid employees from Urban Grind ---
select first_name , last_name ,coffeeshop_name, salary 
from employees left join shops on employees.coffeeshop_id
=shops.coffeeshop_id 
where employees.coffeeshop_id = 4 order by salary desc limit 5;

--- Select the top 5 paid employees from Trembling Cup  ---
select first_name , last_name ,coffeeshop_name, salary 
from employees left join shops on employees.coffeeshop_id
=shops.coffeeshop_id 
where employees.coffeeshop_id = 5 order by salary desc limit 5;

--- Finding out the Top 5 lowest paid employee in CommonGrounds---
select e.first_name , e.last_name , s.coffeeshop_name,e.salary
from employees e left join shops s on e.coffeeshop_id
=s.coffeeshop_id 
where e.coffeeshop_id = 1 order by e.salary asc limit 5;

--- To find the lowest paid employee in CommonGround----
SELECT e.first_name, e.last_name, s.coffeeshop_name, e.salary AS minsal
FROM employees e
LEFT JOIN shops s ON e.coffeeshop_id = s.coffeeshop_id
WHERE e.salary = (
    SELECT MIN(e1.salary)
    FROM employees e1
    WHERE e1.coffeeshop_id = 1
)
AND e.coffeeshop_id = 1;
--- Find out the difference between the max and min salary in CG---
Select max(salary) - min(salary )as differences 
from employees where coffeeshop_id = 1;


Select first_name ||''|| last_name as full_name 
	from employees;
--- Find out Eleen Tarpey's salary'
SELECT salary, first_name || ' ' || last_name AS full_name
FROM employees
WHERE first_name || ' ' || last_name = 'Eleen Tarpey';


-- Labelling those who have a salary under 45k with True---
Select first_name ||''|| last_name as full_name,
	salary,
	(salary < 45000) as salary_under_45k
	from employees;
-- Find out the total of employee with salary under 45k---
Select count(*) as total from employees
where salary <45000;
---Find out the email missing values and fill it--
Select * from employees where email is null;
Select email , Coalesce(email, 'No email recorded')
from employees;	

---Total of Salary CommonGrounds must paid---
Select s.coffeeshop_name ,sum(e.salary) as total_paid  
from employees e left join shops s
on e.coffeeshop_id = s.coffeeshop_id group by e.coffeeshop_id,
s.coffeeshop_name
order by total_paid desc;

--- ALL info about salary ---
select s.coffeeshop_name , 
count(e.employee_id) as number_of_emp,
avg(e.salary) as average_sal,
max(e.salary) as max_sal,
min(e.salary) as min_sal
from employees e left join shops s on 
e.coffeeshop_id = s.coffeeshop_id 
group by s.coffeeshop_name , e.coffeeshop_id
order by average_sal desc;

--- Shop Info with employee > 200---
select s.coffeeshop_name , 
count(e.employee_id) as number_of_emp,
Round(avg(e.salary),0) as average_sal,
max(e.salary) as max_sal,
min(e.salary) as min_sal
from employees e left join shops s on 
e.coffeeshop_id = s.coffeeshop_id 
group by s.coffeeshop_name , e.coffeeshop_id
having count(e.employee_id)>200
order by average_sal desc;

---Findout the total male with categorized salary---
select salary_cat , count(*) as number_of_males from
(
	select employee_id,
	first_name , 
	salary,
	gender,
	case 
		when salary > 50000 and gender = 'M' then 'high_salary'
		when (salary between 25000 and 50000 ) and
		(gender = 'M') then 'mid_salary'
		when salary <25000 and gender = 'M' then 'low_salary'
		else null
	end as salary_cat
	from employees order by salary desc
) a
where salary_cat is not null
group by salary_cat;

--- Gather the info of employees from the US---
select e.* from employees e left join shops s on e.coffeeshop_id =
s.coffeeshop_id left join locations l on s.city_id = l.city_id 
where l.city_id in (1,2);

--- Gather Info of employees who is male and located in US---
Select e.* from employees e where e.gender = 'M' and 
coffeeshop_id in 
(select coffeeshop_id from shops s where s.city_id in (1,2));
---OR-- we could do it with subquery
Select e.* from employees e where e.gender = 'M' and 
coffeeshop_id in 
(select coffeeshop_id from shops s where s.city_id in 
(select l.city_id from locations l where l.country in
('United States')));

















