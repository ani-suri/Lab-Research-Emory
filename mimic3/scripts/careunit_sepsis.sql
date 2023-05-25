set search_path to mimiciii;

SELECT DISTINCT ON (ie.subject_id)
    ie.subject_id,
    ie.hadm_id,
    icu.icustay_id,
    icu.first_careunit
FROM
    admissions ad
    INNER JOIN icustays icu
        ON ad.hadm_id = icu.hadm_id
    INNER JOIN icustays ie
        ON icu.icustay_id = ie.icustay_id
		
limit all;  