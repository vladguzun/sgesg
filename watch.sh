#!/bin/bash

THRESHOLD=1
# Extract idle CPU percentage and convert it to actual usage.
# The output of `top` can vary slightly across systems; using `sed`
# ensures we reliably grab the numeric idle value.
USAGE=$(top -bn1 | grep "Cpu(s)" \
    | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' \
    | awk '{print 100 - $1}')
USAGE_INT=${USAGE%.*}

if [ "$USAGE_INT" -gt "$THRESHOLD" ]; then
  echo " ALERT: CPU usage is $USAGE_INT%" >> /var/log/cpu_alert.log
fi

