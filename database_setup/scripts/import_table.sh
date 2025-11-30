    
#!/bin/bash
# ='s==================================================================
# REUSABLE IMPORT SCRIPT
# This script uses the SOURCE_DIR variable set by the master script.
# ====================================================================

set -e

TABLE_NAME=$1
SOURCE_FILE=$2

# Check if the SOURCE_DIR variable is set. If not, exit with an error.
if [ -z "$SOURCE_DIR" ]; then
    echo "ERROR: SOURCE_DIR variable is not set. Run this from the master script."
    exit 1
fi

echo "--- Importing data for table: $TABLE_NAME ---"
echo "Source file: $SOURCE_DIR/$SOURCE_FILE"

# Use 'cp' with the SOURCE_DIR variable passed from the master script.
echo "Copying file to /tmp/..."
cp "$SOURCE_DIR/$SOURCE_FILE" /tmp/

# This part remains the same, as it's already using variables correctly.
echo "Starting psql \copy command with TEXT format..."
sudo su - postgres -c "/Library/PostgreSQL/18/bin/psql -h localhost -p 5433 -d postgres -c \"\\copy public.$TABLE_NAME FROM '/tmp/$SOURCE_FILE' WITH (FORMAT text, DELIMITER E'\\t', HEADER true, NULL '\\N')\""

echo "--- Import for $TABLE_NAME complete. ---"

  