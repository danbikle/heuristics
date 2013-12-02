#!/bin/bash

# ~/hr/dlcsv_yahoo.bash

# I use this script to download CSV data from Yahoo

# Demo:
# ~/hr/dlcsv_yahoo.bash IBM

if [ $# -lt 1 ] ; then
  echo Need 1 tkr
  echo demo:
  echo /pt/w/sbcj/dlcsv_yahoo.bash IBM
  exit 0
fi

mkdir -p /tmp/hr/
cd       /tmp/hr/

wget --output-document=${1}.csv http://ichart.finance.yahoo.com/table.csv?s=${1}

exit


