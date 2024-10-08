# Image to WebP Converter Script

This Bash script converts various image formats (JPEG, PNG, GIF) to WebP format using the `cwebp` tool. It's designed to be used in a Unix-like environment.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/Lalatenduswain/image-to-webp-converter.git
    cd image-to-webp-converter
    ```

2. Make the script executable:

    ```bash
    chmod +x webp_converter.sh
    ```

3. Run the script:

    ```bash
    ./webp_converter.sh
    ```

The script will check for the presence of the `cwebp` tool, install it if necessary, and then convert all supported image files in the 'lala' folder to WebP format.

## More

Certainly! Let's go through the script step by step to understand what each part does:

```bash
#!/bin/bash
```

This line specifies the script should be interpreted using the Bash shell.

```bash
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
```

This block checks if the `cwebp` tool is installed. If not, it attempts to install it. The script checks for the package manager (`apt-get` for Debian/Ubuntu and `yum` for CentOS/RHEL) and installs the `webp` package accordingly.

```bash
# Set the input folder path (create the 'lala' folder on the Desktop if it doesn't exist)
input_folder="$HOME/Desktop/lala"
if [ ! -d "$input_folder" ]; then
    echo "The '$input_folder' folder does not exist. Creating it now..."
    mkdir -p "$input_folder"
    echo "'$input_folder' folder created. Please place the images in this folder and rerun the script."
    exit 1
fi
```

This section checks if the 'lala' folder exists on the Desktop. If it does not exist, it creates the folder and prompts the user to place images inside it before exiting.

```bash
# Get a list of all supported image files (JPEG, PNG, GIF) in the 'lala' folder
image_files=$(find "$input_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))

# Check if there are any image files in the folder
if [ -z "$image_files" ]; then
    echo "Error: No supported image files found in the '$input_folder' folder."
    exit 1
fi
```

Here, the script uses the `find` command to locate all supported image files (JPEG, PNG, and GIF) in the 'lala' folder. If no files are found, it displays an error message and exits.

```bash
# Create an 'output' folder to store the converted WebP images
output_folder="$input_folder/webp_output"
mkdir -p "$output_folder"
```

This section creates an 'output' folder named 'webp_output' within the 'lala' folder to store the converted WebP images.

```bash
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
```

This loop iterates over each supported image file found in the 'lala' folder. It uses the `cwebp` command to convert each image file to WebP format with a quality of 80%. The converted WebP files are saved in the 'webp_output' folder.

```bash
echo "All supported image files in the '$input_folder' folder converted to WebP in the '$output_folder' folder."
```

Finally, the script prints a message indicating that all supported image files in the 'lala' folder have been successfully converted to WebP format, and the converted files are stored in the 'webp_output' folder.

## Donations

If you find this script useful and want to show your appreciation, you can donate via [Buy Me a Coffee](https://www.buymeacoffee.com/lalatendu.swain).

## Disclaimer

**Author:** Lalatendu Swain | [GitHub](https://github.com/Lalatenduswain) | [Website](https://blog.lalatendu.info/)

This script is provided as-is and may require modifications or updates based on your specific environment and requirements. Use it at your own risk. The authors of the script are not liable for any damages or issues caused by its usage.
```
