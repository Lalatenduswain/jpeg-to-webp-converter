# JPEG to WebP Converter Script

This Bash script converts JPEG images to WebP format using the `cwebp` tool. It's designed to be used in a Unix-like environment.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/Lalatenduswain/jpeg-to-webp-converter.git
    cd jpeg-to-webp-converter
    ```

2. Make the script executable:

    ```bash
    chmod +x webp_converter.sh
    ```

3. Run the script:

    ```bash
    ./webp_converter.sh
    ```

The script will check for the presence of the `cwebp` tool, install it if necessary, and then convert all JPEG images in the 'lala' folder to WebP format.

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
# Check if the 'lala' folder exists
input_folder="lala"
if [ ! -d "$input_folder" ]; then
    echo "Error: The '$input_folder' folder does not exist."
    exit 1
fi
```

This section checks if the 'lala' folder exists. If not, it displays an error message and exits the script.

```bash
# Get a list of all JPEG files in the 'lala' folder
jpeg_files=$(find "$input_folder" -type f -name "*.jpg")

# Check if there are JPEG files in the folder
if [ -z "$jpeg_files" ]; then
    echo "Error: No JPEG files found in the '$input_folder' folder."
    exit 1
fi
```

Here, the script uses the `find` command to locate all JPEG files in the 'lala' folder. If no JPEG files are found, it displays an error message and exits.

```bash
# Create an 'output' folder to store the converted WebP images
output_folder="$input_folder/webp_output"
mkdir -p "$output_folder"
```

This section creates an 'output' folder named 'webp_output' within the 'lala' folder to store the converted WebP images.

```bash
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
```

This loop iterates over each JPEG file found in the 'lala' folder. It uses the `cwebp` command to convert each JPEG file to WebP format with a quality of 80%. The converted WebP files are saved in the 'webp_output' folder.

```bash
echo "All JPEG files in the '$input_folder' folder converted to WebP in the '$output_folder' folder."
```

Finally, the script prints a message indicating that all JPEG files in the 'lala' folder have been successfully converted to WebP format, and the converted files are stored in the 'webp_output' folder.

In summary, the script checks for the presence of the `cwebp` tool, installs it if necessary, looks for JPEG files in the 'lala' folder, converts them to WebP format, and saves the converted files in a separate 'webp_output' folder within the 'lala' directory.

## Donations

If you find this script useful and want to show your appreciation, you can donate via [Buy Me a Coffee](https://www.buymeacoffee.com/lalatendu.swain).

## Disclaimer

**Author:** Lalatendu Swain | [GitHub](https://github.com/Lalatenduswain) | [Website](https://blog.lalatendu.info/)

This script is provided as-is and may require modifications or updates based on your specific environment and requirements. Use it at your own risk. The authors of the script are not liable for any damages or issues caused by its usage.
