-- Set the search path to the MIMIC-III schema
SET search_path TO mimiciii;

-- Query to retrieve subject ID, age, and DOB of sepsis patients
SELECT p.subject_id AS sub_id, p.dob AS dob, EXTRACT(YEAR FROM age(adm.admittime, p.dob)) AS age
FROM admissions adm
JOIN patients p ON adm.subject_id = p.subject_id
WHERE adm.hadm_id IN (
    SELECT hadm_id
    FROM diagnoses_icd
    WHERE icd9_code LIKE '99592'  -- Sepsis ICD-9 codes
        OR icd9_code LIKE '78552' -- Septic shock ICD-9 code
);
