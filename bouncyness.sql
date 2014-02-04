--
-- bouncyness.sql
--

\C 'Bouncyness of big 1 day drops WHERE drop is more than 2 percent:'

SELECT 
SIGN(avg_day1_pct_gain) bouncy_or_not
,COUNT(ticker)           event_count
FROM
(
SELECT 
tkr ticker
,COUNT(ydate) event_count
,MIN(ydate)   min_date
,MAX(ydate)   max_date
,ROUND(100*AVG(nlg1),3)    avg_day1_pct_drop
,ROUND(100*AVG(ng),3)      avg_day1_pct_gain
FROM td12
WHERE nlg1 < -2.0/ 100.0
AND ydate > '2008-01-01'
AND ng IS NOT NULL
GROUP BY tkr ORDER BY AVG(ng)
) sq
GROUP BY SIGN(avg_day1_pct_gain)
ORDER BY SIGN(avg_day1_pct_gain)
;


\C 'Bouncyness of big 1 week drops WHERE drop is more than 5 percent:'

SELECT 
SIGN(avg_week1_pct_gain) bouncy_or_not
,COUNT(ticker)           event_count
FROM
(
SELECT 
tkr ticker
,COUNT(ydate) event_count
,MIN(ydate)   min_date
,MAX(ydate)   max_date
,ROUND(100*AVG(wnlg1),3)   avg_week1_pct_drop
,ROUND(100*AVG(wng),3)     avg_week1_pct_gain
FROM td12
WHERE wnlg1 < -5 / 100.0
AND ydate > '2000-01-01'
AND wng IS NOT NULL
GROUP BY tkr
)sq
GROUP BY SIGN(avg_week1_pct_gain)
ORDER BY SIGN(avg_week1_pct_gain)
;

\C 'Bouncyness of big 1 month drops WHERE drop is more than 10 percent:'

SELECT 
SIGN(avg_month1_pct_gain) bouncy_or_not
,COUNT(ticker)           event_count
FROM
(
SELECT 
tkr ticker
,COUNT(ydate) event_count
,MIN(ydate)   min_date
,MAX(ydate)   max_date
,ROUND(100*AVG(mnlg1),3)   avg_month1_pct_drop
,ROUND(100*AVG(mng),3)     avg_month1_pct_gain
FROM td12
WHERE mnlg1 < -10.0 / 100.0
AND ydate > '1983-01-01'
AND mng IS NOT NULL
GROUP BY tkr 
HAVING COUNT(ydate) > 22
ORDER BY AVG(mng)
)sq
GROUP BY SIGN(avg_month1_pct_gain)
ORDER BY SIGN(avg_month1_pct_gain)
;
