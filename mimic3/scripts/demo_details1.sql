set search_path to mimiciii;

SELECT
  p.subject_id,
  p.gender,
  p.dob,
  p.dod,
  p.expire_flag,
  a.admittime,
  a.dischtime,
  a.deathtime,
  a.hospital_expire_flag
FROM
  mimiciii.patients p
  LEFT JOIN mimiciii.admissions a
    ON p.subject_id = a.subject_id
ORDER BY
  p.subject_id,
  a.admittime;
