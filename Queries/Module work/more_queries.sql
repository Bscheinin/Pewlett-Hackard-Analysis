sql
-- Joining departments and dept_manager tables
-- SELECT d.dept_name,
--      dm.emp_no,
--      dm.from_date,
--      dm.to_date
-- FROM departments as d
-- INNER JOIN dept_manager as dm
-- ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01')

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_candidates
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary
INTO empls_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	
SELECT e.emp_no, e.first_name, e.last_name, e.gender, e.salary, de.to_date
INTO employee_info
FROM empls_info as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01');

DROP TABLE empl_info;

-- List of managers per department
SELECT dm.dept_no,
	d.dept_name,
		dm.emp_no,
		ce.last_name,
		ce.first_name,
		dm.from_date,
		dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no);
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
--INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

SELECT * FROM dept_info;

SELECT di.emp_no,
di.first_name,
di.last_name,
di.dept_name
INTO sales_retirement_candidates
FROM dept_info as di
WHERE (di.dept_name = 'Sales');

SELECT di.emp_no,
di.first_name,
di.last_name,
di.dept_name
INTO development_candidates
FROM dept_info as di
WHERE di.dept_name IN ('Sales', 'Development');