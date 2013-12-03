--
-- ~/hr/oracle/qry_tvs.sql
--

-- I use this script to look for rows which give me a nice Sharpe Ratio.

-- This script depends on ~/hr/oracle/hr.sql

-- @hr.sql

COLUMN avg_ng1 FORMAT 99.9999
COLUMN avg_ng2 FORMAT 99.9999
COLUMN avg_ng3 FORMAT 99.9999
COLUMN avg_ng4 FORMAT 99.9999
COLUMN avg_ng5 FORMAT 99.9999
COLUMN sharpe_r1 FORMAT 9999.9999
COLUMN sharpe_r2 FORMAT 9999.9999
COLUMN sharpe_r3 FORMAT 9999.9999
COLUMN sharpe_r4 FORMAT 9999.9999
COLUMN sharpe_r5 FORMAT 9999.9999

SELECT
tkr
,COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma03s_lt = 1
GROUP BY tkr
HAVING COUNT(tkr) > 5
ORDER BY AVG(ng3)
;

SELECT
COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma03s_lt = 1
;

SELECT
tkr
,COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma04s_lt = 1
GROUP BY tkr
HAVING COUNT(tkr) > 5
ORDER BY AVG(ng3)
;

SELECT
COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma04s_lt = 1
;

SELECT
tkr
,COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma05s_lt = 1
GROUP BY tkr
HAVING COUNT(tkr) > 5
ORDER BY AVG(ng3)
;

SELECT
COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma05s_lt = 1
;

SELECT
tkr
,COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma09s_lt = 1
GROUP BY tkr
HAVING COUNT(tkr) > 5
ORDER BY AVG(ng3)
;

SELECT
COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma09s_lt = 1
;

SELECT
tkr
,COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma20s_lt = 1
GROUP BY tkr
HAVING COUNT(tkr) > 5
ORDER BY AVG(ng3)
;

SELECT
COUNT(tkr) ccount
,AVG(ng1) avg_ng1
,AVG(ng2) avg_ng2
,AVG(ng3) avg_ng3
,AVG(ng4) avg_ng4
,AVG(ng5) avg_ng5
,AVG(ng5)/STDDEV(ng1) sharpe_r1
,AVG(ng5)/STDDEV(ng2) sharpe_r2
,AVG(ng5)/STDDEV(ng3) sharpe_r3
,AVG(ng5)/STDDEV(ng4) sharpe_r4
,AVG(ng5)/STDDEV(ng5) sharpe_r5
FROM tvsource
WHERE ma20s_lt = 1
;

exit
