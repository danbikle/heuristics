--
--select 
--ydate,closing_price,closing_price_orig,closing_price/closing_price_orig as cpr
--from ydata 
--where tkr = 'FFIN'
--and ydate > '2014-01-01'
--order by ydate
--
--
--select closing_price/closing_price_orig as cpr_final
--from ydata 
--where tkr = 'FFIN'
--and ydate = (select max(ydate) from ydata)


drop   table dropme1 ;
create table dropme1 as
select
ydate,closing_price,closing_price_orig
,closing_price/closing_price_orig as cpr
,1 as cpr2
from ydata 
where tkr = 'FFIN'
and ydate > '2014-01-01'
order by ydate
;

update dropme1
set cpr2 = (select max(cpr) from dropme1 where ydate = (select max(ydate) from dropme1));

select * from dropme1 where ydate = (select min(ydate) from dropme1);
select * from dropme1 where ydate = (select max(ydate) from dropme1);


drop   table dropme2 ;
create table dropme2 as
select
ydate,closing_price,closing_price_orig
,cpr,cpr2
,closing_price/cpr2 as cp3
from dropme1
order by ydate
;

select * from dropme2 where ydate = (select min(ydate) from dropme2);
select * from dropme2 where ydate = (select max(ydate) from dropme2);
