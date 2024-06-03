#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 path_to_directory"
    exit 1
fi

FILE_DIR="$1"

# Check if the provided argument is a directory
if [ ! -d "$FILE_DIR" ]; then
    echo "Error: Provided path is not a directory."
    exit 1
fi

# Declare an associative array to store file type counts
declare -A file_types

# Traverse the directory recursively and count file types
while IFS= read -r -d '' file; do
    extension="${file##*.}"
    if [ "$extension" != "$file" ]; then
        ((file_types["$extension"]++))
    else
        ((file_types["no_extension"]++))
    fi
done < <(find "$FILE_DIR" -type f -print0)

# Output the file type counts
echo "File Type Counts:"
for ext in "${!file_types[@]}"; do
    echo "$ext: ${file_types[$ext]}"
done | sort