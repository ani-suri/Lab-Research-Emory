set search_path to mimiciii;

SELECT labevents.subject_id, labevents.hadm_id, labevents.itemid, to_char(labevents.charttime, 'YYYY-MM-DD HH24:MI:SS'), labevents.value, labevents.valuenum, labevents.valueuom, labevents.flag
FROM labevents
WHERE itemid = 50912 -- Assuming itemid 50912 represents creatinine levels
  AND valuenum IS NOT NULL
ORDER BY subject_id, charttime;
