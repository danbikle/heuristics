#!/bin/bash

# /pt/w/sbcj/dlcsv_yahoo.bash

# I use this script to download CSV data from Yahoo

# Demo:
# /pt/w/sbcj/dlcsv_yahoo.bash IBM

if [ $# -lt 1 ] ; then
  echo Need 1 tkr
  echo demo:
  echo /pt/w/sbcj/dlcsv_yahoo.bash IBM
  exit 0
fi

cd /tmp/
mkdir -p /bak/sbcj/csv_files/
cd       /bak/sbcj/csv_files/

wget --output-document=${1}.csv http://ichart.finance.yahoo.com/table.csv?s=${1}


