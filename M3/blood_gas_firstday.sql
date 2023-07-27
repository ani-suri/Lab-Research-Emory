set search_path to mimiciii; 

create table echo_table as

SELECT
  ROW_ID,
  subject_id,
  hadm_id,
  chartdate,
  TO_TIMESTAMP(
    TO_CHAR(chartdate, 'YYYY-MM-DD') || substring(ne.text FROM 'Date/Time: .+? at ([0-9]+:[0-9]{2})') || ':00',
    'YYYY-MM-DDHH24:MI:SS'
  ) AS charttime,
  substring(ne.text FROM 'Indication: (.+?)\n') AS Indication,
  CAST(substring(ne.text FROM 'Height: \\(in\\) ([0-9]+)') AS NUMERIC) AS Height,
  CAST(substring(ne.text FROM 'Weight \\(lb\\): ([0-9]+)\n') AS NUMERIC) AS Weight,
  CAST(substring(ne.text FROM 'BSA \\(m2\\): ([0-9]+) m2\n') AS NUMERIC) AS BSA,
  substring(ne.text FROM 'BP \\(mm Hg\\): (.+)\n') AS BP,
  CAST(substring(ne.text FROM 'BP \\(mm Hg\\): ([0-9]+)/[0-9]+?\n') AS NUMERIC) AS BPSys,
  CAST(substring(ne.text FROM 'BP \\(mm Hg\\): [0-9]+/([0-9]+?)\n') AS NUMERIC) AS BPDias,
  CAST(substring(ne.text FROM 'HR \\(bpm\\): ([0-9]+?)\n') AS NUMERIC) AS HR,
  substring(ne.text FROM 'Status: (.+?)\n') AS Status,
  substring(ne.text FROM 'Test: (.+?)\n') AS Test,
  substring(ne.text FROM 'Doppler: (.+?)\n') AS Doppler,
  substring(ne.text FROM 'Contrast: (.+?)\n') AS Contrast,
  substring(ne.text FROM 'Technical Quality: (.+?)\n') AS TechnicalQuality
FROM
  noteevents ne
WHERE
  category = 'Echo';
