#!/bin/bash
# Author : Lalatendu Swain #

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

# Set the input folder path (create the 'lala' folder on the Desktop if it doesn't exist)
input_folder="$HOME/Desktop/lala"
if [ ! -d "$input_folder" ]; then
    echo "The '$input_folder' folder does not exist. Creating it now..."
    mkdir -p "$input_folder"
    echo "'$input_folder' folder created. Please place the images in this folder and rerun the script."
    exit 1
fi

# Get a list of all supported image files (JPEG, PNG, GIF) in the 'lala' folder
image_files=$(find "$input_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))

# Check if there are any image files in the folder
if [ -z "$image_files" ]; then
    echo "Error: No supported image files found in the '$input_folder' folder."
    exit 1
fi

# Create an 'output' folder to store the converted WebP images
output_folder="$input_folder/webp_output"
mkdir -p "$output_folder"

# Convert each image file to WebP
for image_file in $image_files; do
    output_file="$output_folder/$(basename "${image_file%.*}.webp")"
    cwebp -q 80 "$image_file" -o "$output_file"
    if [ $? -eq 0 ]; then
        echo "Conversion successful: $output_file"
    else
        echo "Error: Conversion failed for $image_file."
    fi
done

echo "All supported image files in the '$input_folder' folder converted to WebP in the '$output_folder' folder."
