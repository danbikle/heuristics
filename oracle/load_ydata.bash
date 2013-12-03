#!/bin/bash

# ~/hr/oracle/load_ydata.bash

# I use this script to load data from CSV files into table, ydata.

if [ -e ~/hr/oracle ] ; then
  echo You are good to go.
else
  echo I have a problem.
  echo I should see a directory named ~/hr/oracle/
  echo Please study $0 for more clues.
  echo bye.
  exit 0
fi

set -x

cd ~/hr/oracle/


# I add tkr values to the CSV data and create one large CSV file.
# But, rm it first:
rm -f /tmp/ydata/ydata.csv
And the builder script:
rm -f /tmp/ydata/build_ydata_csv.bash

# I want to run a series of shell commands which look like this:
# grep -v Date /tmp/ydata/SPY.csv | sed '1,$s/^/SPY,/' >> /tmp/ydata/ydata.csv

grep "^[A-Z]" ~/hr/tkrlist.txt | \
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

# Time for me to call sqlldr which copies
# rows out of /tmp/ydata/ydata.csv
# into the table, ydata.

# Ensure that oracle server can read the data:
chmod 755 /tmp/ydata/
chmod 644 /tmp/ydata/ydata.csv

# Ensure I have the ydata target table created:

exit

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

exit

