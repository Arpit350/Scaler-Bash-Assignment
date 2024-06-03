#!/bin/bash

# Define the log file to monitor
LOG_FILE="C:/app/log_file.log"

# Function to perform analysis on new log lines
analyze_log() {
    # Run top command and capture its output to a variable
    TOP_OUTPUT=$(top -n 1 -b)

    # Grep for error messages in the log file and capture them
    ERROR_MESSAGES=$(grep "ERROR" $LOG_FILE)

    # Count the occurrences of each error message
    ERROR_COUNT=$(grep -c "ERROR" $LOG_FILE)
    MOST_FREQUENT_ERROR=$(grep "ERROR" $LOG_FILE | sort | uniq -c | sort -nr | head -1)

    # Print the top command output
    echo "CPU Utilization:"
    echo "$TOP_OUTPUT"

    # Print error messages
    echo "Error Messages:"
    echo "$ERROR_MESSAGES"

    # Print the count of error messages
    echo "Error Message Count: $ERROR_COUNT"

    # Print the most frequent error message
    echo "Most Frequent Error:"
    echo "$MOST_FREQUENT_ERROR"
}

# Main function to continuously monitor the log file
monitor_log() {
    echo "Monitoring log file: $LOG_FILE"
    tail -f -n0 $LOG_FILE | while read line; do
        analyze_log
    done
}

# Start monitoring the log file
monitor_log
