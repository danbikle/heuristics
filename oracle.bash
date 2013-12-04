#!/bin/bash

# ~/hr/oracle.bash

# I use this script to run some other scripts in the oracle sub-dir.

# Inspiration comes from ~/hr/oracle/readme.txt

cd ~/hr/oracle/

~/hr/oracle/wget_ydata.bash

~/hr/oracle/load_ydata.bash

cd ~/hr/

~/hr/cr_upd_cp.bash

~/hr/sqt @qry_abrupt.sql
~/hr/sqt @update_closing_price.sql
~/hr/sqt @qry_abrupt.sql

cd ~/hr/oracle
~/hr/sqt @hr.sql
~/hr/sqt @qry_tvs.sql

exit
