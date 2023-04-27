select first_name || last_name as Name, 
job_id job, salary, (salary*12)+100 "Increased Ann_Salary", (salary +100)*12 "Increased Salary" from employees;

select last_name || ': 1 Year Salary = $' ||salary*12 as "1 Year Salary"
from employees;

select distinct department_id, job_id
from employees;

select last_name "e and o Name" from employees where last_name like '%e%' and last_name like '%o%';

select first_name||last_name Name, job_id, hire_date from employees where hire_date between '2006-05-20' and '2007-05-20' order by hire_date;

select first_name||last_name Name, salary, job_id, commission_pct from employees where commission_pct is not null order by salary desc;

select * from employees;

select INITCAP(first_name || ' ' || last_name) || 'is a ' || UPPER(job_id) "Employee JOBs"
from Employees
where substr(last_name, -1) = 's';

select first_name || ' ' || last_name as "Name", salary, 
    salary*12 "Annual Salary", NVL(TO_CHAR(commission_pct), 'Salary Only') "Commission ?"
from Employees
order by "Annual Salary" desc;

select first_name || ' ' || last_name as "Name", hire_date,
    TO_CHAR(hire_date, 'day') "Day of the week"
from Employees
order by to_char(hire_date,'d');

select department_id, TO_CHAR(SUM(salary), '$999,999.00') "Sum Salary", 
    TO_CHAR(AVG(salary), '$999,999.00') "Avg Salary" , 
    TO_CHAR(MAX(salary), '$999,999.00') "Max Salary",
    TO_CHAR(MIN(salary), '$999,999.00') "Min SAlary"
from Employees
where department_id is not null
group by department_id;

select job_id, AVG(salary) "Avg Salary"
from Employees
where job_id not in('clerk')
group by job_id
having AVG(salary) > 10000 
order by AVG(salary) desc;
--558
--1번 문제
select d.department_name, COUNT(e.department_id)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_name
having COUNT(e.department_id) >= 5
order by COUNT(e.department_id) desc;

--2번 문제
select e.first_name || ' ' || e.last_name "Name", e.job_id, 
     d.department_name, e.hire_date, e.salary, j.grade_level
from employees e, departments d, job_grades j
where e.department_id = d.department_id
    and e.salary between j.lowest_sal and j.highest_sal
order by j.grade_level;

select e.first_name || ' ' || e.last_name || ' report to ' || m.first_name || ' ' || m.last_name
as "Employee vs Manager"
from employees e left outer join employees m
on e.manager_id = m.employee_id;

--560P
SELECT first_name || last_name as Name, job_id, salary, hire_date
from employees;

SELECT first_name || last_name as Name, salary, department_id,job_id
from employees;

--select employee_id, first_name||''||last_name,job_id,hire_date
--from employees
--where substr( -1) = 'o';
--561p
select e.employee_id, CONCAT(CONCAT(e.first_name, ' '), e.last_name) "Name", e.job_id, e.hire_date
from employees e
where e.department_id = (select department_id
                         from departments
                         where location_id = (select location_id
                                              from locations
                                              where city like 'O%'));
                                              

select e.first_name || ' ' || e.last_name "Name", e.job_id, e.salary, e.department_id,
        (select ROUND(AVG(salary)) "Department Avg Salary"
         from employees
         where department_id = e.department_id) average
from employees e;

select employee_id, job_id, department_id
from employees
union all
select employee_id, job_id, department_id
from job_history
order by employee_id;

--563p
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

select employee_id, job_id, to_date(null) "Start Date", to_date(null) "End Date"
from employees
 intersect
select employee_id, job_id, to_date(null) "Start Date", to_date(null) "End Date"
from job_history
where employee_id = 176
 union all
select employee_id, job_id, start_date, end_date
from job_history
where employee_id = 176
order by job_id, "Start Date";




select employee_id
from employees
minus
select employee_id
from job_history;

--566p


select department_id, SUM(salary) "SUM_SAL",
    CASE when SUM(salary) > 100000 then 'Excellent'
         when SUM(salary) > 50000 then 'Good'
         when SUM(salary) > 10000 then 'Medium'
         when SUM(salary) <= 10000 then 'well'
         end "Department Grade Salary"
from employees
group by department_id;

--567p



select COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '01', 1)) "1 Month",
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '02', 1)) "2 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '03', 1)) "3 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '04', 1)) "4 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '05', 1)) "5 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '06', 1)) "6 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '07', 1)) "7 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '08', 1)) "8 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '09', 1)) "9 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '10', 1)) "10 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '11', 1)) "11 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '12', 1)) "12 Month"
from employees
where TO_CHAR(hire_date, 'MM') >= '01' and TO_CHAR(hire_date, 'MM') <='12';


--569P
SELECT department_id, job_id
    , TO_CHAR(SUM(salary),'$999,999.00') as "Salary SUM"
    , COUNT(employee_id) as "COUNT EMPs"
FROM Employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id;


--570p
SELECT DECODE(GROUPING(department_id),  1, '(ALL-DEPTS)', 0, department_id) "Dept#"
    , DECODE(GROUPING(job_id), 1, '(ALL_JOBS)', 0, job_id) "Jobs"
    , COUNT(employee_id) as "COUNT EMPs", ROUND(AVG(salary*12)) "Avg Ann_sal"
FROM Employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id;

--572p
select employee_id, last_name, salary, department_id, Rank() over (partition by department_id order by salary) "Rank",
    DENSE_RANK() over (partition by department_id order by salary) "DENSE_RANK", 
    ROW_NUMBER() over (partition by department_id order by salary) "Row_Number"
from Employees
order by department_id;

select employee_id, last_name, salary, LAG(salary, 1, 0) OVER (order by salary) "Prev_Sal", 
        LEAD(salary, 1, 0) OVER (order by salary) "Next_Sal"
from employees
where department_id = 50
order by salary desc;

--573\

select department_id, COUNT(*), Max(last_name) keep ( DENSE_RANK FIRST order by salary) "Max_Emp_Name", 
        Min(last_name) keep (DENSE_RANK LAST order by salary)"Min_Emp_Name"
from employees
group by department_id;

--574
select PRIOR last_name || ' reports to ' || last_name "Walk"
from employees
start with last_name like 'Olson'
connect by PRIOR manager_id = employee_id;


select level, LPAD('______', 3*(level-1)) || last_name "Hierarchical Query"
from employees
start with last_name like 'King'
connect by prior employee_id = manager_id;

--575

select level, LPAD('*********', (level)) || last_name || ' ' || 'job is ' || job_id || 
            ', department name is ' || department_name
from (select e.last_name, e.job_id, d.department_name, e.employee_id, e.manager_id 
      from employees e, departments d
      where e.department_id = d.department_id)
start with last_name like 'King'
connect by prior employee_id = manager_id;

select SUBSTR(sys_connect_by_path(last_name, '-'), 2) "Name_Path"
from employees
start with manager_id is null
connect by prior employee_id = manager_id;










