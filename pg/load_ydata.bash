#!/bin/bash

# ~/hr/pg/load_ydata.bash

# I use this script to load data from CSV files into table, ydata.

if [ -e ~/hr/pg ] ; then
  echo You are good to go.
else
  echo I have a problem.
  echo I should see a directory named ~/hr/pg/
  echo Please study $0 for more clues.
  echo bye.
  exit 0
fi

set -x
cd ~/hr/
./wget_ydata.bash

cd ~/hr/pg/

# I add tkr values to the CSV data and create one large CSV file.
# But, rm it first:
rm -f /tmp/ydata/ydata.csv
# And the builder script:
rm -f /tmp/ydata/build_ydata_csv.bash

# I want to run a series of shell commands which look like this:
# grep -v Date /tmp/ydata/SPY.csv | sed '1,$s/^/SPY,/' >> /tmp/ydata/ydata.csv

mkdir -p /tmp/ydata/
grep "^[A-Z]" ~/hr/tkrlist.txt | \
  sort -u | \
  awk '{print "grep -v Date /tmp/ydata/"$1".csv | sed :1,$s/^/"$1",/: >> /tmp/ydata/ydata.csv"}' | \
  sed '1,$s/:/'"'"'/g' >> /tmp/ydata/build_ydata_csv.bash

echo I just used grep and ~/hr/tkrlist.txt to create /tmp/ydata/build_ydata_csv.bash
# echo The head looks like this:
# head /tmp/ydata/build_ydata_csv.bash

# Run it:
bash -x /tmp/ydata/build_ydata_csv.bash

echo 'Here is head and tail of the CSV file I want to load:'
head -3 /tmp/ydata/ydata.csv
tail -3 /tmp/ydata/ydata.csv

# Time for me to call psql which calls the COPY command to copy
# rows out of /tmp/ydata/ydata.csv
# into the table, ydata.

# Ensure that postgres server can read the data:
chmod 755 /tmp/ydata/
chmod 644 /tmp/ydata/ydata.csv

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
,opn      
,mx
,mn
,closing_price
,vol
,adjclse
) FROM '/tmp/ydata/ydata.csv' WITH csv
;

EOF

# At this point,
# my table, ydata, should be full of rows from /tmp/ydata/ydata.csv'

echo 'Here is the load report:'

./psql.bash<<EOF
SELECT MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata;

SELECT tkr, MIN(ydate),COUNT(tkr),MAX(ydate) FROM ydata GROUP BY tkr ORDER BY tkr ;

-- Look for dups:
SELECT * FROM ydata WHERE tkr = 'BA' AND ydate = '2013-11-29';

EOF

echo 'wc -l /tmp/ydata/BA.csv'
      wc -l /tmp/ydata/BA.csv

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
,opn     
,mx      
,mn      
,closing_price
,vol     
,adjclse 
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

