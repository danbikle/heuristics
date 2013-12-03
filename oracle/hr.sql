--
-- ~/hr/oracle/hr.sql
--

DROP   TABLE tv10;
CREATE TABLE tv10 COMPRESS AS
SELECT
tkr,ydate
,closing_price cp
,(LEAD(closing_price,1,NULL) OVER (PARTITION BY TKR ORDER BY ydate) - closing_price)/closing_price  ng1
,(LEAD(closing_price,2,NULL) OVER (PARTITION BY TKR ORDER BY ydate) - closing_price)/closing_price  ng2
,(LEAD(closing_price,3,NULL) OVER (PARTITION BY TKR ORDER BY ydate) - closing_price)/closing_price  ng3
,(LEAD(closing_price,4,NULL) OVER (PARTITION BY TKR ORDER BY ydate) - closing_price)/closing_price  ng4
,(LEAD(closing_price,5,NULL) OVER (PARTITION BY TKR ORDER BY ydate) - closing_price)/closing_price  ng5
,AVG(closing_price)OVER(PARTITION BY TKR ORDER BY ydate ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)   ma02
,AVG(closing_price)OVER(PARTITION BY TKR ORDER BY ydate ROWS BETWEEN 3 PRECEDING AND 0 PRECEDING)   ma03
,AVG(closing_price)OVER(PARTITION BY TKR ORDER BY ydate ROWS BETWEEN 4 PRECEDING AND 0 PRECEDING)   ma04
,AVG(closing_price)OVER(PARTITION BY TKR ORDER BY ydate ROWS BETWEEN 5 PRECEDING AND 0 PRECEDING)   ma05
,AVG(closing_price)OVER(PARTITION BY TKR ORDER BY ydate ROWS BETWEEN 9 PRECEDING AND 0 PRECEDING)   ma09
,AVG(closing_price)OVER(PARTITION BY TKR ORDER BY ydate ROWS BETWEEN 20 PRECEDING AND 0 PRECEDING)  ma20
FROM ydata
ORDER BY ydate
;

DROP   TABLE tv12;
CREATE TABLE tv12 COMPRESS AS
SELECT
tkr,ydate
,ng1
,ng2
,ng3
,ng4
,ng5
,CASE WHEN ng1>0 THEN 1 ELSE 0 END y1
,CASE WHEN ng2>0 THEN 1 ELSE 0 END y2
,CASE WHEN ng3>0 THEN 1 ELSE 0 END y3
,CASE WHEN ng4>0 THEN 1 ELSE 0 END y4
,CASE WHEN ng5>0 THEN 1 ELSE 0 END y5
,(ma02-LAG(ma02,1,ma02) OVER (PARTITION BY TKR ORDER BY ydate))/ma02     ma02s
,(ma03-LAG(ma03,1,ma03) OVER (PARTITION BY TKR ORDER BY ydate))/ma03     ma03s
,(ma04-LAG(ma04,1,ma04) OVER (PARTITION BY TKR ORDER BY ydate))/ma04     ma04s
,(ma05-LAG(ma05,2,ma05) OVER (PARTITION BY TKR ORDER BY ydate))/ma05     ma05s
,(ma09-LAG(ma09,3,ma09) OVER (PARTITION BY TKR ORDER BY ydate))/ma09     ma09s
,(ma20-LAG(ma20,4,ma20) OVER (PARTITION BY TKR ORDER BY ydate))/ma20     ma20s
FROM tv10
ORDER BY ydate
;

DROP   TABLE tv14;
CREATE TABLE tv14 COMPRESS AS
SELECT
tkr,ydate
,ng1
,ng2
,ng3
,ng4
,ng5
,y1
,y2
,y3
,y4
,y5
,ma02s
,ma03s
,ma04s
,ma05s
,ma09s
,ma20s
,(ma02s-LAG(ma02s,1,ma02s) OVER (PARTITION BY TKR ORDER BY ydate)) ma02sd
,(ma03s-LAG(ma03s,1,ma03s) OVER (PARTITION BY TKR ORDER BY ydate)) ma03sd
,(ma04s-LAG(ma04s,1,ma04s) OVER (PARTITION BY TKR ORDER BY ydate)) ma04sd
,(ma05s-LAG(ma05s,2,ma05s) OVER (PARTITION BY TKR ORDER BY ydate)) ma05sd
,(ma09s-LAG(ma09s,3,ma09s) OVER (PARTITION BY TKR ORDER BY ydate)) ma09sd
,(ma20s-LAG(ma20s,4,ma20s) OVER (PARTITION BY TKR ORDER BY ydate)) ma20sd
FROM tv12
ORDER BY ydate
;


DROP   TABLE tv14st;
CREATE TABLE tv14st COMPRESS AS
SELECT
tkr,ydate
,ng1
,ng2
,ng3
,ng4
,ng5
,y1
,y2
,y3
,y4
,y5
,ma02s
,ma03s
,ma04s
,ma05s
,ma09s
,ma20s
,ma02sd
,ma03sd
,ma04sd
,ma05sd
,ma09sd
,ma20sd
,1.5*STDDEV(ma02s  )OVER() ma02s_st
,1.5*STDDEV(ma03s  )OVER() ma03s_st
,1.5*STDDEV(ma04s  )OVER() ma04s_st
,1.5*STDDEV(ma05s  )OVER() ma05s_st
,1.5*STDDEV(ma09s  )OVER() ma09s_st
,1.5*STDDEV(ma20s  )OVER() ma20s_st
,1.5*STDDEV(ma02sd )OVER() ma02sd_st
,1.5*STDDEV(ma03sd )OVER() ma03sd_st
,1.5*STDDEV(ma04sd )OVER() ma04sd_st
,1.5*STDDEV(ma05sd )OVER() ma05sd_st
,1.5*STDDEV(ma09sd )OVER() ma09sd_st
,1.5*STDDEV(ma20sd )OVER() ma20sd_st
,AVG(ma02s  )OVER() ma02s_av
,AVG(ma03s  )OVER() ma03s_av
,AVG(ma04s  )OVER() ma04s_av
,AVG(ma05s  )OVER() ma05s_av
,AVG(ma09s  )OVER() ma09s_av
,AVG(ma20s  )OVER() ma20s_av
,AVG(ma02sd )OVER() ma02sd_av
,AVG(ma03sd )OVER() ma03sd_av
,AVG(ma04sd )OVER() ma04sd_av
,AVG(ma05sd )OVER() ma05sd_av
,AVG(ma09sd )OVER() ma09sd_av
,AVG(ma20sd )OVER() ma20sd_av
FROM tv14
ORDER BY ydate
;

DROP   TABLE tv16st;
CREATE TABLE tv16st COMPRESS AS
SELECT
tkr,ydate
,ng1
,ng2
,ng3
,ng4
,ng5
,y1
,y2
,y3
,y4
,y5
,CASE WHEN ma02s   <ma02s_av   -ma02s_st    THEN 1 ELSE 0 END ma02s_lt
,CASE WHEN ma03s   <ma03s_av   -ma03s_st    THEN 1 ELSE 0 END ma03s_lt
,CASE WHEN ma04s   <ma04s_av   -ma04s_st    THEN 1 ELSE 0 END ma04s_lt
,CASE WHEN ma05s   <ma05s_av   -ma05s_st    THEN 1 ELSE 0 END ma05s_lt
,CASE WHEN ma09s   <ma09s_av   -ma09s_st    THEN 1 ELSE 0 END ma09s_lt
,CASE WHEN ma20s   <ma20s_av   -ma20s_st    THEN 1 ELSE 0 END ma20s_lt
,CASE WHEN ma02sd  <ma02sd_av  -ma02sd_st   THEN 1 ELSE 0 END ma02sd_lt
,CASE WHEN ma03sd  <ma03sd_av  -ma03sd_st   THEN 1 ELSE 0 END ma03sd_lt
,CASE WHEN ma04sd  <ma04sd_av  -ma04sd_st   THEN 1 ELSE 0 END ma04sd_lt
,CASE WHEN ma05sd  <ma05sd_av  -ma05sd_st   THEN 1 ELSE 0 END ma05sd_lt
,CASE WHEN ma09sd  <ma09sd_av  -ma09sd_st   THEN 1 ELSE 0 END ma09sd_lt
,CASE WHEN ma20sd  <ma20sd_av  -ma20sd_st   THEN 1 ELSE 0 END ma20sd_lt
,CASE WHEN ma02s   >ma02s_av   +ma02s_st    THEN 1 ELSE 0 END ma02s_gt
,CASE WHEN ma03s   >ma03s_av   +ma03s_st    THEN 1 ELSE 0 END ma03s_gt
,CASE WHEN ma04s   >ma04s_av   +ma04s_st    THEN 1 ELSE 0 END ma04s_gt
,CASE WHEN ma05s   >ma05s_av   +ma05s_st    THEN 1 ELSE 0 END ma05s_gt
,CASE WHEN ma09s   >ma09s_av   +ma09s_st    THEN 1 ELSE 0 END ma09s_gt
,CASE WHEN ma20s   >ma20s_av   +ma20s_st    THEN 1 ELSE 0 END ma20s_gt
,CASE WHEN ma02sd  >ma02sd_av  +ma02sd_st   THEN 1 ELSE 0 END ma02sd_gt
,CASE WHEN ma03sd  >ma03sd_av  +ma03sd_st   THEN 1 ELSE 0 END ma03sd_gt
,CASE WHEN ma04sd  >ma04sd_av  +ma04sd_st   THEN 1 ELSE 0 END ma04sd_gt
,CASE WHEN ma05sd  >ma05sd_av  +ma05sd_st   THEN 1 ELSE 0 END ma05sd_gt
,CASE WHEN ma09sd  >ma09sd_av  +ma09sd_st   THEN 1 ELSE 0 END ma09sd_gt
,CASE WHEN ma20sd  >ma20sd_av  +ma20sd_st   THEN 1 ELSE 0 END ma20sd_gt
FROM tv14st
ORDER BY ydate
;

DROP   TABLE tv18st;
CREATE TABLE tv18st COMPRESS AS
SELECT
tkr,ydate
,ng1
,ng2
,ng3
,ng4
,ng5
,y1
,y2
,y3
,y4
,y5
,ma02s_lt
,ma03s_lt
,ma04s_lt
,ma05s_lt
,ma09s_lt
,ma20s_lt
,ma02sd_lt
,ma03sd_lt
,ma04sd_lt
,ma05sd_lt
,ma09sd_lt
,ma20sd_lt
,ma02s_gt
,ma03s_gt
,ma04s_gt
,ma05s_gt
,ma09s_gt
,ma20s_gt
,ma02sd_gt
,ma03sd_gt
,ma04sd_gt
,ma05sd_gt
,ma09sd_gt
,ma20sd_gt
,ma02s_lt
+ma03s_lt
+ma04s_lt
+ma05s_lt
+ma09s_lt
+ma20s_lt
+ma02sd_lt
+ma03sd_lt
+ma04sd_lt
+ma05sd_lt
+ma09sd_lt
+ma20sd_lt ltsum
,ma02s_gt
+ma03s_gt
+ma04s_gt
+ma05s_gt
+ma09s_gt
+ma20s_gt
+ma02sd_gt
+ma03sd_gt
+ma04sd_gt
+ma05sd_gt
+ma09sd_gt
+ma20sd_gt gtsum
FROM tv16st
ORDER BY ydate
;

DROP   TABLE tv20st;
CREATE TABLE tv20st COMPRESS AS
SELECT
tkr,ydate
,ng1
,ng2
,ng3
,ng4
,ng5
,y1
,y2
,y3
,y4
,y5
,ma02s_lt
,ma03s_lt
,ma04s_lt
,ma05s_lt
,ma09s_lt
,ma20s_lt
,ma02sd_lt
,ma03sd_lt
,ma04sd_lt
,ma05sd_lt
,ma09sd_lt
,ma20sd_lt
,ma02s_gt
,ma03s_gt
,ma04s_gt
,ma05s_gt
,ma09s_gt
,ma20s_gt
,ma02sd_gt
,ma03sd_gt
,ma04sd_gt
,ma05sd_gt
,ma09sd_gt
,ma20sd_gt
,ltsum
,gtsum
FROM tv18st
ORDER BY ydate
;

DROP   TABLE tv22st;
CREATE TABLE tv22st COMPRESS AS
SELECT * FROM tv20st
WHERE ltsum>0
OR    gtsum>0
;

DROP   TABLE tvsource;
CREATE TABLE tvsource COMPRESS AS
SELECT
tkr,ydate
,y1
,y2
,y3
,y4
,y5
,ng1
,ng2
,ng3
,ng4
,ng5
,ma02s_lt
,ma03s_lt
,ma04s_lt
,ma05s_lt
,ma09s_lt
,ma20s_lt
,ma02sd_lt
,ma03sd_lt
,ma04sd_lt
,ma05sd_lt
,ma09sd_lt
,ma20sd_lt
,ma02s_gt
,ma03s_gt
,ma04s_gt
,ma05s_gt
,ma09s_gt
,ma20s_gt
,ma02sd_gt
,ma03sd_gt
,ma04sd_gt
,ma05sd_gt
,ma09sd_gt
,ma20sd_gt
FROM tv22st
WHERE -180 + ydate > (SELECT MIN(ydate) FROM tv22st)
ORDER BY ydate
;


exit
