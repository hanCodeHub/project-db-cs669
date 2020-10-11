-- Drop tables to allow script reruns
DROP TABLE IF EXISTS Job CASCADE;
DROP TABLE IF EXISTS Department CASCADE;
DROP TABLE IF EXISTS Employee CASCADE;
DROP TABLE IF EXISTS Team CASCADE;
DROP TABLE IF EXISTS Goal CASCADE;
DROP TABLE IF EXISTS Enrollment CASCADE;
DROP TABLE IF EXISTS Activity CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Level CASCADE;
DROP TABLE IF EXISTS Course CASCADE;
DROP TABLE IF EXISTS Certification CASCADE;
DROP TABLE IF EXISTS ProgressChange CASCADE;

-- CREATE TABLES

CREATE TABLE Job(
    job_id DECIMAL(12) PRIMARY KEY,
    job_title VARCHAR(255) NOT NULL
);

CREATE TABLE Department(
    department_id DECIMAL(12) PRIMARY KEY,
    dep_name VARCHAR(255) NOT NULL,
    dep_descrip VARCHAR(1024) NOT NULL,
    dep_email VARCHAR(255) NOT NULL
);

CREATE TABLE Goal(
    goal_id DECIMAL(12) PRIMARY KEY,
    target_percent DECIMAL(5,2) NOT NULL
);

CREATE TABLE Team(
    team_id DECIMAL(12) PRIMARY KEY,
    goal_id DECIMAL(12) NOT NULL,
    team_name VARCHAR(255) NOT NULL,
    team_descrip VARCHAR(1024) NOT NULL,

    FOREIGN KEY (goal_id) REFERENCES Goal(goal_id)
);

CREATE TABLE Employee(
    employee_id DECIMAL(12) PRIMARY KEY,
    department_id DECIMAL(12) NOT NULL,
    team_id DECIMAL(12) NOT NULL,
    job_id DECIMAL(12) NOT NULL,
    manager_id DECIMAL(12),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    employee_type CHAR(1) NOT NULL,
    joined_on DATE NOT NULL,

    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (team_id) REFERENCES Team(team_id),
    FOREIGN KEY (job_id) REFERENCES Job(job_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id) 
	ON DELETE CASCADE
);

CREATE TABLE Location(
    location_id DECIMAL(12) PRIMARY KEY,
    location_name VARCHAR(1024) NOT NULL
);

CREATE TABLE Level(
    level_id DECIMAL(12) PRIMARY KEY,
    level_name VARCHAR(64) NOT NULL
);

CREATE TABLE Activity(
    activity_id DECIMAL(12) PRIMARY KEY,
    location_id DECIMAL(12) NOT NULL,
    level_id DECIMAL(12),
    title VARCHAR(255) NOT NULL,
    activity_domain VARCHAR(255),
    activity_descrip VARCHAR(1024) NOT NULL,
    format CHAR(1) NOT NULL,
    offered_on TIMESTAMP,
    price DECIMAL(7,2) NOT NULL,
    duration_mins DECIMAL(5) NOT NULL,
    updated_on DATE NOT NULL,

    FOREIGN KEY (location_id) REFERENCES Location(location_id),
    FOREIGN KEY (level_id) REFERENCES LEVEL(level_id)
);

CREATE TABLE Enrollment(
    enroll_id DECIMAL(12) PRIMARY KEY,
    employee_id DECIMAL(12) NOT NULL,
    activity_id DECIMAL(12) NOT NULL,
    last_active DATE NOT NULL,
    session_mins DECIMAL(6) NOT NULL,
    completed BOOLEAN NOT NULL,
    progress_percent DECIMAL(3) NOT NULL,
    cert_code VARCHAR(255),

    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (activity_id) REFERENCES Activity(activity_id)
);

CREATE TABLE Course(
    activity_id DECIMAL(12) PRIMARY KEY,
    nr_lessons DECIMAL(2) NOT NULL,

    FOREIGN KEY (activity_id) REFERENCES Activity(activity_id)
);

CREATE TABLE Certification(
    activity_id DECIMAL(12) PRIMARY KEY,
    valid_months DECIMAL(3),

    FOREIGN KEY (activity_id) REFERENCES Activity(activity_id)
);


-- History table
CREATE TABLE ProgressChange(
    progress_change_id DECIMAL(12) PRIMARY KEY,
    enroll_id DECIMAL(12) NOT NULL,
    old_progress DECIMAL(3) NOT NULL,
    new_progress DECIMAL(3) NOT NULL,
    change_date DATE NOT NULL,

    FOREIGN KEY (enroll_id) REFERENCES Enrollment(enroll_id)
);