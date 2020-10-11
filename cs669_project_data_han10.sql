-- PRECONDITION: Please run the script in cs669_project_procedures_han10.sql
-- below invocations will not work unless the procedure definitions are run

CALL InsertTeamAndGoal(2, 90, 
    2, 'Web Development', 
    'The Web Development team is responsible for developing and maintaining the corporate website.');

-- new manager for team 2
CALL InsertEmployee(
    3, 1, 2, -- employee_id, department_id, team_id
    1, null, -- job_id, manager_id
    'John', 'Doe',
    'johndoe@company.com', 'f', '2019-07-02');

-- new employee for team 2
CALL InsertEmployee(
    4, 1, 2, -- employee_id, department_id, team_id
    2, 3, -- job_id, manager_id
    'Mary', 'Smith',
    'marysmith@company.com', 'f', '2019-11-21');

-- new employee for team 2
CALL InsertEmployee(
    5, 1, 2, -- employee_id, department_id, team_id
    2, 3, -- job_id, manager_id
    'Sarah', 'Lawrence',
    'sarahlawrence@company.com', 'f', '2020-10-01');


-- new course and certification
CALL InsertLocation(2, 'https://mywebinar.com/course/234523');
CALL InsertLocation(3, 'Building C, Floor 3');
CALL InsertLevel(2, 'Intermediate');
CALL InsertLevel(3, 'Advanced');

Call InsertCourse(
    2, 2, 2, -- activity_id, location_id, level_id
    'Cloud Computing', 'Cloud', 'This class teaches distributed computing in the cloud.',
    's', null, 199.00,
    360, '2020-03-19', 8
);

Call InsertCertification(
    3, 3, 3, -- activity_id, location_id, level_id
    'Solution Architect Professional', 'Architecture', 'This accreditation certifies the ability to design and implement highly performant systems in the cloud.',
    's', null, 265.00,
    120, '2020-08-17', 24
);


-- new enrollments
CALL InsertEnrollment(
    3, 2, 1,  -- enroll_id, employee_id, activity_id
    '2020-02-13', 35,
    false, 40, null
);

CALL InsertEnrollment(
    4, 3, 3,  -- enroll_id, employee_id, activity_id
    '2020-01-10', 110,
    true, 100, 'abcde-12345'
);

CALL InsertEnrollment(
    5, 4, 3,  -- enroll_id, employee_id, activity_id
    '2020-01-15', 118,
    true, 100, 'ewfij-45678'
);

CALL InsertEnrollment(
    6, 5, 2,  -- enroll_id, employee_id, activity_id
    '2020-02-05', 23,
    false, 10, null
);


-- new changes to history table
UPDATE Enrollment
SET progress_percent = 60,
    session_mins = 45,
    last_active = '2020-03-27'
WHERE enroll_id = 1;

UPDATE Enrollment
SET progress_percent = 75,
    session_mins = 95,
    last_active = '2020-04-21'
WHERE enroll_id = 4;

UPDATE Enrollment
SET progress_percent = 80,
    session_mins = 30,
    last_active = '2020-05-13'
WHERE enroll_id = 5;