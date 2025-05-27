#!/bin/bash


# From here we get BCK_Dest:
source .env 

# Define the backup destination
BACKUP_DEST="/Users/$(whoami)/Library/Mobile Documents/com~apple~CloudDocs/Documents/${BCK_Dest}"

echo BACKUP_DEST

# Get the root folder name (where the script is run)
ROOTFOLDER=$(basename "$PWD")

# Function to compress and move a subfolder
backup_folder() {
    local SUBFOLDER="$1"

    if [[ ! -d "$SUBFOLDER" ]]; then
        echo "Error: '$SUBFOLDER' is not a directory."
        return 1
    fi

    # Generate timestamp
    TIMESTAMP=$(date +"%Y%m%d_%H%M")

    # Construct zip filename
    ZIP_NAME="${ROOTFOLDER}_${SUBFOLDER}_${TIMESTAMP}.zip"

    echo "Compressing '$SUBFOLDER' to '$ZIP_NAME'..."
    zip -r "$ZIP_NAME" "$SUBFOLDER" > /dev/null

    # Ensure destination exists
    mkdir -p "$BACKUP_DEST"

    echo "Moving '$ZIP_NAME' to '$BACKUP_DEST'..."
    mv "$ZIP_NAME" "$BACKUP_DEST"
}

# Main script logic

# specify a folder. If you don't the script will zip all subfolders to the Backup destination.

# ./backup_subfolders.sh stg
# ./backup-subfolders.sh 

if [[ $# -eq 1 ]]; then
    # Mode: specific subfolder
    backup_folder "$1"
elif [[ $# -eq 0 ]]; then
    # Mode: process all subfolders
    for item in */; do
        [[ -d "$item" ]] || continue
        folder_name="${item%/}"
        backup_folder "$folder_name"
    done
else
    echo "Usage:"
    echo "  $0             → process all subfolders"
    echo "  $0 <subfolder> → process only the specified subfolder"
    exit 1
fi

echo "Backup complete."