set search_path to mimiciii;

SELECT *
FROM labevents
WHERE itemid IN 50912
AND valuenum IS NOT NULL
ORDER BY subject_id, charttime;