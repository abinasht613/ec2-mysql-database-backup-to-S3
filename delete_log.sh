#!/bin/bash

# Specify directories and age limit (in days)
log_dir="/var/log"
temp_dir="/tmp"
days_old=30

# Archive old logs
find "$log_dir" -type f -name "*.log" -mtime +$days_old -exec tar -zcvf /backup/logs_$(date +"%Y-%m-%d").tar.gz {} \;

# Remove files older than $days_old days
find "$log_dir" -type f -name "*.log" -mtime +$days_old -exec rm {} \;

# Clean /tmp directory by deleting files older than 7 days
find "$temp_dir" -type f -mtime +7 -exec rm {} \;

echo "Cleanup completed!"
