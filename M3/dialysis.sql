SET search_path TO mimiciii;

-- select * from d_icd_diagnoses 
-- where short_title ILIKE '%dialysis%' or long_title ILIKE '%dialysis%'; 


select a.row_id, a.subject_id, a.diagnosis, a.hadm_id, d.icd9_code, d.short_title, d.long_title 
from admissions a
inner join d_icd_diagnoses d on a.row_id = d.row_id 
where short_title ILIKE '%dialysis%' or long_title ILIKE '%dialysis%'; 
