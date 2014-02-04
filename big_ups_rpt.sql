--
-- big_ups_rpt.sql
--

-- I use this script to study Mean-Reversion in the Stock Market.

-- Now I am ready to report.

\C 'Next day summary of stocks which upped 2% or more the day before:'
SELECT 
tkr ticker
,COUNT(ydate) event_count
,MIN(ydate)   min_date
,MAX(ydate)   max_date
,ROUND(100*AVG(nlg1),3)    avg_day1_pct_up
,ROUND(100*AVG(ng),3)      avg_day1_pct_gain
FROM td12
WHERE nlg1 > 2.0/ 100.0
AND ydate > '2008-01-01'
AND ng IS NOT NULL
GROUP BY tkr ORDER BY AVG(ng)
;

\C 'Next week summary of stocks which upped 5% or more the week before:'
SELECT 
tkr ticker
,COUNT(ydate) event_count
,MIN(ydate)   min_date
,MAX(ydate)   max_date
,ROUND(100*AVG(wnlg1),3)   avg_week1_pct_up
,ROUND(100*AVG(wng),3)     avg_week1_pct_gain
FROM td12
WHERE wnlg1 > 5 / 100.0
AND ydate > '2000-01-01'
AND wng IS NOT NULL
GROUP BY tkr ORDER BY AVG(wng)
;

\C 'Next month summary of stocks which upped 10% or more the month before:'
SELECT 
tkr ticker
,COUNT(ydate) event_count
,MIN(ydate)   min_date
,MAX(ydate)   max_date
,ROUND(100*AVG(mnlg1),3)   avg_month1_pct_up
,ROUND(100*AVG(mng),3)     avg_month1_pct_gain
FROM td12
WHERE mnlg1 > 10.0 / 100.0
AND ydate > '1983-01-01'
AND mng IS NOT NULL
GROUP BY tkr 
HAVING COUNT(ydate) > 22
ORDER BY AVG(mng)
;