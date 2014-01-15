#!/bin/bash

# ~/hr/wget_ydata.bash

# I use this script to wget some yahoo stock prices.

mkdir -p /tmp/ydata/
cd       /tmp/ydata/

cat ~/hr/tkrlist.txt | sort -u | awk '{print "~/hr/dlcsv_yahoo.bash",$1}' | grep "[A-Z]" > wget_ydata_temp.bash

bash -x wget_ydata_temp.bash

exit
