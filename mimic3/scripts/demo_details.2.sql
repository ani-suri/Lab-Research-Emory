set search_path to mimiciii; 

SELECT 
  admissions.hadm_id,
  CASE 
    WHEN admissions.hospital_expire_flag = 1 THEN 'Yes'
    ELSE 'No'
  END AS mortality,
  CASE 
    WHEN vent.mechvent = 1 THEN vent.duration_hours
    ELSE NULL
  END AS mech_vent_duration,
  CASE
    WHEN procedures.icd9_code = '90945' THEN 'Yes'
    ELSE 'No'
  END AS CRRT,
  CASE
    WHEN cpt_events.category = 'ECMO' THEN 'Yes'
    ELSE 'No'
  END AS ECMO,
  vital_signs.charttime,
  vital_signs.sbp,
  vital_signs.temperature,
  vital_signs.glasgow_coma_scale,
  vital_signs.respiration,
  vital_signs.heartrate
FROM admissions
LEFT JOIN ventdurations vent ON admissions.hadm_id = vent.hadm_id
LEFT JOIN procedures ON admissions.hadm_id = procedures.hadm_id
LEFT JOIN cptevents cpt_events ON admissions.hadm_id = cpt_events.hadm_id
LEFT JOIN (
  SELECT
    icustay_id,
    charttime,
    MAX(CASE WHEN itemid = 51 THEN value END) AS sbp,
    MAX(CASE WHEN itemid = 223761 THEN value END) AS temperature,
    MAX(CASE WHEN itemid = 198 THEN value END) AS glasgow_coma_scale,
    MAX(CASE WHEN itemid = 615 THEN value END) AS respiration,
    MAX(CASE WHEN itemid = 211 THEN value END) AS heartrate
  FROM chartevents
  WHERE itemid IN (51, 223761, 198, 615, 211)
  GROUP BY icustay_id, charttime
) vital_signs ON admissions.hadm_id = vital_signs.icustay_id







