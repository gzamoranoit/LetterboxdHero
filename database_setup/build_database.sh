    
#!/bin/bash
# ====================================================================
# MASTER BUILD SCRIPT 
# ====================================================================

set -e

# --- CONFIGURATION ---
export SOURCE_DIR="/Users/gasparzamorano/Downloads/Archive"
# ---------------------

PSQL_CMD="/Library/PostgreSQL/18/bin/psql -U postgres -h localhost -p 5433 -d postgres"

echo "=== STARTING DATABASE BUILD FROM: $SOURCE_DIR ==="

# --- Step 1: Create all table schemas ---
echo " "
echo "--> STEP 1: Creating all schemas..."
$PSQL_CMD -f ./sql/01_create_all_schemas.sql

# --- Step 2: Import data for all tables ---
echo " "
echo "--> STEP 2: Importing all data (using TEXT format)..."
chmod +x ./scripts/import_table.sh

# Call the simplified reusable script.
./scripts/import_table.sh name_basics name.basics.tsv
./scripts/import_table.sh title_basics title.basics.tsv
./scripts/import_table.sh title_principals title.principals.tsv
./scripts/import_table.sh title_ratings title.ratings.tsv

# --- Step 3: Create all indexes ---
echo " "
echo "--> STEP 3: Creating all indexes..."
$PSQL_CMD -f ./sql/02_create_all_indexes.sql


echo " "
echo "--> STEP 6: Converting data types..."
$PSQL_CMD -f ./sql/04_data_type_conversion.sql


echo " "
echo "--> STEP 5: Optimizing performance..."
$PSQL_CMD -c "ANALYZE;"

echo " "
echo "=== DATABASE BUILD COMPLETE ==="

