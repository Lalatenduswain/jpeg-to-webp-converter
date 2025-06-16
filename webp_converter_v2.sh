#!/bin/bash
# Author: Lalatendu Swain
# Script: Convert Images to WebP with Interactive UI

# Function: Install cwebp if not found
install_cwebp() {
    if ! command -v cwebp &>/dev/null; then
        echo "📦 cwebp is not installed. Installing..."
        if command -v apt-get &>/dev/null; then
            sudo apt-get update
            sudo apt-get install -y webp whiptail
        elif command -v yum &>/dev/null; then
            sudo yum install -y libwebp-tools newt
        else
            echo "❌ Unsupported package manager. Install cwebp manually."
            exit 1
        fi
    fi
}

# Function: Prompt input using whiptail or fallback to read
prompt_input() {
    local prompt="$1"
    local default="$2"
    local result

    if command -v whiptail &>/dev/null; then
        result=$(whiptail --inputbox "$prompt" 10 60 "$default" 3>&1 1>&2 2>&3)
    else
        read -rp "$prompt [$default]: " result
        result="${result:-$default}"
    fi

    echo "$result"
}

# Main
install_cwebp

# Get input folder
input_folder=$(prompt_input "Enter the full path of the folder containing images:" "$HOME/Desktop/lala")
if [ ! -d "$input_folder" ]; then
    echo "📁 Folder not found. Creating: $input_folder"
    mkdir -p "$input_folder"
    echo "⚠️ Please add images to '$input_folder' and rerun the script."
    exit 1
fi

# Get quality %
quality=$(prompt_input "Enter WebP quality (1–100, where 100 is best):" "80")
if ! [[ "$quality" =~ ^[0-9]+$ ]] || [ "$quality" -lt 1 ] || [ "$quality" -gt 100 ]; then
    echo "❌ Invalid quality value: $quality"
    exit 1
fi

# Find images
image_files=$(find "$input_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))
if [ -z "$image_files" ]; then
    echo "🚫 No supported image files found in: $input_folder"
    exit 1
fi

# Create output folder
output_folder="$input_folder/webp_output"
mkdir -p "$output_folder"

# Convert images
count=0
echo "🔄 Starting conversion..."
for image_file in $image_files; do
    filename=$(basename "${image_file%.*}")
    output_file="$output_folder/${filename}.webp"

    if cwebp -q "$quality" "$image_file" -o "$output_file" &>/dev/null; then
        echo "✅ Converted: $(basename "$image_file") → $(basename "$output_file")"
        count=$((count + 1))
    else
        echo "❌ Failed: $image_file"
    fi
done

echo "🎉 Done! Converted $count image(s) to WebP in: $output_folder"

