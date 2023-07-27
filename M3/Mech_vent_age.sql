SET search_path TO mimiciii;

SELECT
    icu.icustay_id,
    vent.itemid AS ventnum,
    vent.starttime,
    vent.endtime,
    EXTRACT(EPOCH FROM (vent.endtime - vent.starttime))/3600 AS duration_hours,
    vent.row_id,
    adm.subject_id,
    adm.hadm_id,
    icu.icustay_id AS "icustay_id-2",
    icu.dbsource,
    icu.first_careunit,
    icu.last_careunit,
    icu.first_wardid,
    icu.last_wardid,
    icu.intime,
    icu.outtime,
    icu.los,
    icu.row_id AS "row_id-2",
    icu.subject_id AS "subject_id-2",
    icu.hadm_id AS "hadm_id-2",
    adm.admittime,
    adm.dischtime,
    adm.deathtime,
    adm.admission_type,
    adm.admission_location,
    adm.discharge_location,
    adm.ethnicity,
    adm.diagnosis,
    adm.hospital_expire_flag,
    adm.has_chartevents_data,
    DATE_PART('year', adm.admittime) - DATE_PART('year', p.dob) AS age
FROM
    icustays icu
    INNER JOIN admissions adm ON icu.hadm_id = adm.hadm_id
    LEFT JOIN procedureevents_mv vent ON icu.icustay_id = vent.icustay_id
    LEFT JOIN patients p ON adm.subject_id = p.subject_id
WHERE
    vent.itemid IN (225792, 225794, 225798, 225800, 225802, 225804);

