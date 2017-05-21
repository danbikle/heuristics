#!/bin/bash

# ~/hr/pg/load_ydata.bash

# I use this script to load data from CSV files into table, ydata.

echo 'I might see an error here:'
echo 'ERROR:  relation "ydata" already exists'
echo 'It is okay. I need to ensure that ydata exists'
echo 'before I try to fill it.'
./psql.bash<<EOF
-- Ensure that ydata exists.
-- I might get an error here:
\i ~/hr/pg/cr_ydata.sql 

-- Assume current data in ydata is not needed.
-- Since this is only a demo, I can toss it in the trash:

TRUNCATE TABLE ydata;

-- Now fill ydata

COPY ydata (
tkr
,ydate     
,closing_price
) FROM '/home/tkrprice/tkrprice/static/ydata.csv' WITH csv
;

EOF

# The above CSV file should have been filled by a cronjob owned by tkrprice

# At this point,
# my table, ydata, should be full of rows from ydata.csv'

echo 'Here is the load report:'

./psql.bash<<EOF
SELECT MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata;

SELECT tkr, MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata GROUP BY tkr ORDER BY tkr ;

-- Look for dups:
SELECT * FROM ydata WHERE tkr = 'BA' AND ydate = '2013-11-29';

EOF

# Since I am about to UPDATE the closing_price column,
# I will backup the data in it.
echo 'The command below might issue an error:'
echo 'ERROR:  table "ydata_copy" does not exist'
echo 'I need to drop it before I create and refill it.'
./psql.bash<<EOF
DROP   TABLE ydata_copy;
-- Above command might give error

CREATE TABLE ydata_copy AS
SELECT
tkr
,ydate   
,closing_price
,closing_price AS closing_price_orig
FROM ydata
ORDER BY tkr,ydate
;

DROP   TABLE ydata;
CREATE TABLE ydata AS SELECT * FROM ydata_copy;

-- Run the load report again

SELECT MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata;

SELECT tkr, MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata GROUP BY tkr ORDER BY tkr ;
EOF

# So, now I have the data loaded.  Usually my next step is to cd ../
# and call 
#  ../cr_upd_cp.bash 
# to create 
#  ../update_closing_price.sql.
# Then, I call update_closing_price.sql to UPDATE closing_price in ydata.

# Another thing I might do is look for abrupt, abnormal 
# changes in closing_price using ../qry_abrupt.sql
# After I UPDATE, those abrupt changes (due to stock splits) 
# should be gone.

# The scripts in ../ should work for both Oracle and Postgres.

cd ~/hr/
./cr_upd_cp.bash
./psql.bash -f update_closing_price.sql

exit

