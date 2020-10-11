-- PRECONDITION: Run the script in cs669_project_data_han10.sql first.

-- Question 1
SELECT first_name, last_name, email, joined_on AS employee_joined
FROM (SELECT * FROM Employee 
	  WHERE current_date - joined_on < 31
	 ) AS Employee
JOIN Enrollment ON (Employee.employee_id = Enrollment.enroll_id)
JOIN Activity ON (Enrollment.activity_id = Activity.activity_id)
JOIN Level ON (Activity.level_id = Level.level_id)
WHERE (completed = false AND level_name = 'Beginner')
	OR level_name != 'Beginner';


-- Question 2
SELECT team_name, COUNT(completed)
FROM Team
JOIN Employee ON (Employee.team_id = Team.team_id)
JOIN Enrollment ON (Enrollment.Employee_id = Employee.employee_id)
GROUP BY team_name, completed
HAVING completed = true
ORDER BY COUNT(completed) DESC;


-- Question 3
SELECT title AS training_activity, 
	COUNT(progress_change_id) / COUNT(DISTINCT Enrollment.activity_id)
	AS average_nr_attempts
FROM Activity
JOIN Enrollment ON (Activity.activity_id = Enrollment.activity_id)
JOIN ProgressChange ON (ProgressChange.enroll_id = Enrollment.enroll_id)
GROUP BY title
ORDER BY COUNT(progress_change_id) / COUNT(DISTINCT Enrollment.activity_id);