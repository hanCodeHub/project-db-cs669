-- STORED PROCEDURES AND TRIGGERS

-- Function and trigger for history table ProgressChange

CREATE OR REPLACE FUNCTION ProgressChangeFunc()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
BEGIN
    INSERT INTO ProgressChange(progress_change_id, enroll_id, 
        old_progress, new_progress, change_date)
    VALUES(COALESCE((SELECT MAX(progress_change_id)+1 FROM ProgressChange), 1),
    New.enroll_id,
    OLD.progress_percent,
    NEW.progress_percent,
    current_date);

    RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER ProgressChangeTrigger
BEFORE UPDATE OF progress_percent ON Enrollment
FOR EACH ROW
EXECUTE PROCEDURE ProgressChangeFunc(); 


-- Trigger test run
-- PRECONDITION: make sure that all stored procedure scripts are run
CALL InsertEnrollment(
    2, 2, 1,  -- enroll_id, employee_id, activity_id
    '2020-04-15', 15,  -- last_active, session_mins
    false, 20, null  -- completed, progress_percent, cert_code
);

UPDATE Enrollment
SET progress_percent = 40,
    session_mins = 30,
    last_active = '2020-04-18'
WHERE enroll_id = 2;

UPDATE Enrollment
SET progress_percent = 70,
    session_mins = 50,
    last_active = '2020-04-20'
WHERE enroll_id = 2;

UPDATE Enrollment
SET progress_percent = 100,
    session_mins = 90,
    last_active = '2020-04-22',
    completed = true
WHERE enroll_id = 2;