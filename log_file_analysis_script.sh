#!/bin/bash

# Define log file and output report
log_file="/var/log/nginx/access.log"
report_file="log_analysis_report.txt"

# Count occurrences of 404 errors
echo "404 Errors:" > "$report_file"
grep " 404 " "$log_file" | wc -l >> "$report_file"

# Count occurrences of 500 errors
echo "500 Errors:" >> "$report_file"
grep " 500 " "$log_file" | wc -l >> "$report_file"

# Report IP addresses with the most requests
echo "Top 5 IP addresses:" >> "$report_file"
awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 5 >> "$report_file"

# Display the report
cat "$report_file"


#404 Errors:
#0
#500 Errors:
#0
#Top 5 IP addresses:
