#!/bin/bash

set -xe

# Check if mmdc is installed
if ! command -v mmdc &> /dev/null; then
    echo "Error: mmdc command not found."
    echo "Please install Mermaid CLI with: npm install -g @mermaid-js/mermaid-cli"
    exit 1
fi

# Counter for successful conversions
converted=0

# Iterate through files in the current directory
for file in *.mermaid; do
    # Check if any .mermaid files were found
    if [ ! -f "$file" ]; then
        echo "No .mermaid files found in the current directory."
        exit 0
    fi
    
    # Get the base filename without extension
    filename=$(basename "$file" .mermaid)
    
    # Convert the file
    echo "Converting $file to $filename.svg..."
    mmdc -i "$file" -o "$filename.svg"
    
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "✅ Successfully converted $file to $filename.svg"
        ((converted++))
    else
        echo "❌ Failed to convert $file"
    fi
done

echo "Conversion complete. Converted $converted Mermaid files to SVG."