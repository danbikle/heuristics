--
-- big_drops_rpt.sql
--

-- I use this script to study Mean-Reversion in the Stock Market.


DROP   TABLE IF EXISTS td08;
CREATE TABLE td08 AS
SELECT
tkr
,ydate
,AVG(closing_price)      cp
,AVG(closing_price_orig) cpo
FROM ydata
WHERE ydate + (365 *30) > (SELECT MAX(ydate) FROM ydata)
GROUP BY tkr,ydate
ORDER BY tkr,ydate
;

DROP   TABLE td10;
CREATE TABLE td10 AS
SELECT
tkr||ydate tkrdate
,tkr
,ydate
,cp
,cpo
,(cp-LAG(cp,1,NULL)OVER(PARTITION BY tkr ORDER BY ydate))/cp  nlg1
,(cp-LAG(cp,5,NULL)OVER(PARTITION BY tkr ORDER BY ydate))/cp  wnlg1
,(cp-LAG(cp,20,NULL)OVER(PARTITION BY tkr ORDER BY ydate))/cp mnlg1
,(LEAD(cp,1,NULL)OVER(PARTITION BY tkr ORDER BY ydate)-cp)/cp ng
,(LEAD(cp,5,NULL)OVER(PARTITION BY tkr ORDER BY ydate)-cp)/cp wng
,(LEAD(cp,20,NULL)OVER(PARTITION BY tkr ORDER BY ydate)-cp)/cp mng
,LAG(ydate,1,NULL)OVER(PARTITION BY tkr ORDER BY ydate)       lagdate1
,LAG(ydate,2,NULL)OVER(PARTITION BY tkr ORDER BY ydate)       lagdate2
,LAG(ydate,3,NULL)OVER(PARTITION BY tkr ORDER BY ydate)       lagdate3
,LAG(ydate,4,NULL)OVER(PARTITION BY tkr ORDER BY ydate)       lagdate4
,LAG(ydate,5,NULL)OVER(PARTITION BY tkr ORDER BY ydate)       lagdate5
,LEAD(ydate,1,NULL)OVER(PARTITION BY tkr ORDER BY ydate)      lddate
FROM td08
ORDER BY tkr,ydate
;

DROP   TABLE td12;
CREATE TABLE td12 AS
SELECT
tkrdate
,tkr
,ydate
,cp
,cpo
,nlg1
,wnlg1
,mnlg1
,ng
,wng
,mng
,lagdate1
,lagdate2
,lagdate3
,lagdate4
,lagdate5
,lddate
,LAG(nlg1,1,NULL)OVER(PARTITION BY tkr ORDER BY ydate) nlg2
,LAG(nlg1,2,NULL)OVER(PARTITION BY tkr ORDER BY ydate) nlg3
,LAG(nlg1,3,NULL)OVER(PARTITION BY tkr ORDER BY ydate) nlg4
,LAG(nlg1,4,NULL)OVER(PARTITION BY tkr ORDER BY ydate) nlg5
,LAG(wnlg1,5,NULL)OVER(PARTITION BY tkr ORDER BY ydate) wnlg2
,LAG(wnlg1,10,NULL)OVER(PARTITION BY tkr ORDER BY ydate) wnlg3
,LAG(mnlg1,20,NULL)OVER(PARTITION BY tkr ORDER BY ydate) mnlg2
FROM td10
ORDER BY tkr,ydate;

-- Now I am ready to report.

\C 'Next day summary of stocks which dropped 2% or more the day before:'
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
;

\C 'Next week summary of stocks which dropped 5% or more the week before:'
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
GROUP BY tkr ORDER BY AVG(wng)
;

\C 'Next month summary of stocks which dropped 10% or more the month before:'
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
;