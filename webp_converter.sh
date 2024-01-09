#!/bin/bash
#Author : Lalatendu Swain #
# Check if cwebp is installed
if ! command -v cwebp &> /dev/null; then
    echo "cwebp is not installed. Installing it now..."
    
    # Install webp package
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y webp
    elif command -v yum &> /dev/null; then
        sudo yum install -y libwebp-tools
    else
        echo "Error: Unsupported package manager. Please install cwebp manually."
        exit 1
    fi
    
    # Check if installation was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install cwebp. Please install it manually and rerun the script."
        exit 1
    fi
fi

# Check if the 'lala' folder exists
input_folder="lala"
if [ ! -d "$input_folder" ]; then
    echo "Error: The '$input_folder' folder does not exist."
    exit 1
fi

# Get a list of all JPEG files in the 'lala' folder
jpeg_files=$(find "$input_folder" -type f -name "*.jpg")

# Check if there are JPEG files in the folder
if [ -z "$jpeg_files" ]; then
    echo "Error: No JPEG files found in the '$input_folder' folder."
    exit 1
fi

# Create an 'output' folder to store the converted WebP images
output_folder="$input_folder/webp_output"
mkdir -p "$output_folder"

# Convert each JPEG file to WebP
for jpeg_file in $jpeg_files; do
    output_file="$output_folder/$(basename "${jpeg_file%.jpg}.webp")"
    cwebp -q 80 "$jpeg_file" -o "$output_file"
    if [ $? -eq 0 ]; then
        echo "Conversion successful: $output_file"
    else
        echo "Error: Conversion failed for $jpeg_file."
    fi
done

echo "All JPEG files in the '$input_folder' folder converted to WebP in the '$output_folder' folder."
