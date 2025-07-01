#!/bin/bash

THRESHOLD=1
USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
USAGE_INT=${USAGE%.*}

if [ "$USAGE_INT" -gt "$THRESHOLD" ]; then
  echo " ALERT: CPU usage is $USAGE_INT%" >> /var/log/cpu_alert.log
fi

