set search_path to mimiciii; 

SELECT subject_id, dob, age(dob) AS age
FROM patients;
