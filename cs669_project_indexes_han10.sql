-- CREATE INDEXES

-- Foreign key indexes
CREATE INDEX employee_groupfk_idx
ON Employee (department_id, team_id, manager_id);

CREATE INDEX employee_jobfk_idx
ON Employee (job_id);

CREATE INDEX team_goalfk_idx
ON Team (goal_id);

CREATE INDEX enroll_employeefk_idx
ON Enrollment(employee_id, activity_id);


-- Query driven indexes
CREATE INDEX employee_joinedon_idx
ON Employee (joined_on);

CREATE INDEX enrollment_progresspercent_idx
ON Enrollment (progress_percent);

CREATE INDEX activity_durationmins_idx
ON Activity (duration_mins);