--
-- ~/hr/pg/cr_ydata.sql
--

-- I use this script to create table ydata which holds price data from
-- yahoo.  Note that this Postgres syntax is different than the syntax
-- I use for Oracle.


CREATE TABLE ydata
(
tkr                 VARCHAR(9)
,ydate              DATE
,closing_price      DECIMAL
,closing_price_orig DECIMAL
)
;
