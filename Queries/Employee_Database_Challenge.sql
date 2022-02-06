--Challenge 7
--Retrieve employees 
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	tt.title,
	tt.from_date,
	tt.to_date
INTO retiring_emp
FROM employees as e
LEFT JOIN titles_cleaned as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Find those employees with titles on the list that are still with the company and are ready to retire
SELECT re.emp_no,
re.first_name,
re.last_name,
re.title,
re.from_date,
re.to_date
INTO unique_titles
FROM retiring_emp as re
WHERE to_date = ('9999-01-01')
ORDER BY emp_no;

-- Title counts
SELECT COUNT(ut.title), ut.title 
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY (count) DESC;