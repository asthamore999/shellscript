# Owner: astha more
# $USER: astha
# Created date: 20-6-25
# Modified date: 26-6-25
# Question:Monitors CPU and memory usage, logs the data to file, and alerts if usage exceeds.
#!/bin/bash
source ./lib.sh
logfile="$HOME/sys_monitor.log"
if [ $# -eq 2 ]; then
 cpu_th=$1
 mem_th=$2
else
 read -p "Enter cpu usage threshold " cpu_th
fi
empty_input "$cpu_th" || exit 1
input_number_only "$cpu_th" || exit 1
positive_only "$cpu_th" || exit 1
if [ "$cpu_th" -gt 100 ]; then
  echo "CPU usage threshold cannot be beyond 100%."
  exit 1
fi
read -p "Enter memory usage threshold " mem_th
float_int_allowed "$mem_th" || exit 1
if (( $(echo "$mem_th" > 100 |bc -l) )); then
  echo "memory usage threshold cannot be beyond 100%."
  exit 1
fi

## Get current memory and cpu usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)
mem_usage=$(free | grep 'Mem' | awk '{printf("%.0f", $3*100/$2)}')

echo "cpu usage : '$cpu_usage'"
echo "memory usage :'$mem_usage'"
{
  echo "------ $(date) ------"
  echo "CPU usage: ${cpu_usage}%"
  echo "Memory usage: ${mem_usage}%"
} >> "$logfile"

# Alert
if [ "$cpu_usage" -gt "$cpu_th" ]; then
  echo "CPU usage is ${cpu_usage}%. Exceeds threshold of ${cpu_th}%." 
else
  echo "usage is within limit"
fi
if (($(echo "$mem_usage > $mem_th" | bc -l) )); then 
  echo "Memory usage is ${mem_usage}%. Exceeds threshold of ${mem_th}%." 
else
  echo "usage is within limit"
fi
