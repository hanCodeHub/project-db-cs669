-- STORED PROCEDURES

-- Inserting Department, Team, Goal

CREATE OR REPLACE PROCEDURE InsertDepartment (department_id_arg DECIMAL, 
    dep_name_arg VARCHAR, dep_descrip_arg VARCHAR, dep_email_arg VARCHAR)
LANGUAGE SQL
AS $$
    INSERT INTO Department VALUES (department_id_arg, dep_name_arg,
        dep_descrip_arg, dep_email_arg);
$$;


CREATE OR REPLACE PROCEDURE InsertTeamAndGoal (
    goal_id_arg DECIMAL, target_percent_arg DECIMAL,
    team_id_arg DECIMAL, team_name VARCHAR, team_descrip VARCHAR)
LANGUAGE SQL
AS $$
    INSERT INTO Goal VALUES (goal_id_arg, target_percent_arg);
    INSERT INTO Team VALUES (team_id_arg, goal_id_arg, team_name, team_descrip);
$$;


CALL InsertDepartment(1, 'Engineering', 
    'The Engineering department is concerned with the research, design, development, and deployment of our products and services.',
    'engineering@company.com');

CALL InsertTeamAndGoal(1, 80, 
    1, 'Platform Development', 
    'The Platform Development team is responsible for developing and maintaining the core set of capabilities that powers our technology stack.');


-- Inserting Employee, Job

CREATE OR REPLACE PROCEDURE InsertJob(job_id_arg DECIMAL, job_title_arg VARCHAR)
LANGUAGE SQL
AS $$
    INSERT INTO Job VALUES (job_id_arg, job_title_arg);
$$;

CREATE OR REPLACE PROCEDURE InsertEmployee(
    employee_id_arg DECIMAL, department_id_arg DECIMAL, team_id_arg DECIMAL, 
    job_id_arg DECIMAL, manager_id_arg DECIMAL, 
    first_name_arg VARCHAR, last_name_arg VARCHAR,
    email_arg VARCHAR, employee_type_arg CHAR, joined_on_arg DATE)
LANGUAGE SQL
AS $$
    INSERT INTO Employee VALUES (
        employee_id_arg, department_id_arg, team_id_arg, 
        job_id_arg, manager_id_arg, 
        first_name_arg, last_name_arg,
        email_arg, employee_type_arg, joined_on_arg);
$$;

CALL InsertJob(1, 'Software Development Manager');
CALL InsertJob(2, 'Software Engineer');

CALL InsertEmployee(
    1, 1, 1, -- employee_id, department_id, team_id
    1, null, -- job_id, manager_id
    'Jane', 'Doe',
    'janedoe@company.com', 'f', '2019-08-13');

CALL InsertEmployee(
    2, 1, 1, -- employee_id, department_id, team_id
    2, 1, -- job_id, manager_id
    'Han', 'Xu',
    'hanxu@company.com', 'f', '2020-04-27');


-- Inserting Activity, Location, Level, Course, Certification

CREATE OR REPLACE PROCEDURE InsertLocation(
    location_id_arg DECIMAL, location_name_arg VARCHAR)
LANGUAGE SQL
AS $$
    INSERT INTO Location VALUES (location_id_arg, location_name_arg);
$$;

CREATE OR REPLACE PROCEDURE InsertLevel(
    level_id_arg DECIMAL, level_name_arg VARCHAR)
LANGUAGE SQL
AS $$
    INSERT INTO Level VALUES (level_id_arg, level_name_arg);
$$;

CREATE OR REPLACE PROCEDURE InsertCourse(
    activity_id_arg DECIMAL, location_id_arg DECIMAL, level_id_arg DECIMAL,
    title_arg VARCHAR, activity_domain_arg VARCHAR, activity_description_arg VARCHAR,
    format_arg CHAR, offered_on_arg DATE, price_arg DECIMAL, 
    duration_mins_arg DECIMAL, updated_on_arg DATE, nr_lessons_arg DECIMAL)
LANGUAGE SQL
AS $$
    INSERT INTO Activity VALUES (
        activity_id_arg, location_id_arg, level_id_arg,
        title_arg, activity_domain_arg, activity_description_arg,
        format_arg, offered_on_arg, price_arg,
        duration_mins_arg, updated_on_arg);
    INSERT INTO Course VALUES (activity_id_arg, nr_lessons_arg);
$$;

CREATE OR REPLACE PROCEDURE InsertCertification(
    activity_id_arg DECIMAL, location_id_arg DECIMAL, level_id_arg DECIMAL,
    title_arg VARCHAR, activity_domain_arg VARCHAR, activity_description_arg VARCHAR,
    format_arg CHAR, offered_on_arg DATE, price_arg DECIMAL, 
    duration_mins_arg DECIMAL, updated_on_arg DATE, valid_months DECIMAL)
LANGUAGE SQL
AS $$
    INSERT INTO Activity VALUES (
        activity_id_arg, location_id_arg, level_id_arg,
        title_arg, activity_domain_arg, activity_description_arg,
        format_arg, offered_on_arg, price_arg,
        duration_mins_arg, updated_on_arg);
    INSERT INTO Certification VALUES (activity_id_arg, valid_months);
$$;

CALL InsertLocation(1, 'https://mywebinar.com/course/123904');
CALL InsertLevel(1, 'Beginner');

Call InsertCourse(
    1, 1, 1,
    'Database Design', 'Storage', 'This class teaches database design fundamentals.',
    's', null, 199.00,
    240, '2020-02-12', 5
);


-- Inserting Enrollment

CREATE OR REPLACE PROCEDURE InsertEnrollment(
    enroll_id_arg DECIMAL, employee_id_arg DECIMAL, activity_id_arg DECIMAL,
    last_active_arg DATE, session_mins_arg DECIMAL,
    completed_arg BOOLEAN, progress_percent_arg DECIMAL, cert_code_arg VARCHAR
)
LANGUAGE SQL
AS $$
    INSERT INTO Enrollment VALUES (
        enroll_id_arg, employee_id_arg, activity_id_arg,
        last_active_arg, session_mins_arg,
        completed_arg, progress_percent_arg, cert_code_arg);
$$;

CALL InsertEnrollment(
    1, 1, 1,
    '2020-03-11', 55,
    false, 80, null
)