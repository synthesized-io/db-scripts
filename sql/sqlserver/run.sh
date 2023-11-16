export DB_NAME=sakila
export DB_HOST=127.0.0.1,1433
export DB_USER=sa
export DB_PASSWORD=Secret_password_1

export scripts=("columns_data_types.sql" "constraints.sql" "cyclic_table_references.sql" "databases.sql" "pii_columns.sql" "schemas_relations.sql" "tables.sql")

mkdir -p ./output/${DB_NAME}

for current_script in ${scripts[@]}; do
    export SCRIPT_NAME=$current_script
    sqlcmd -C -S ${DB_HOST} -d ${DB_NAME} -U ${DB_USER} -P ${DB_PASSWORD} \
        -i init_script.sql,${SCRIPT_NAME} \
        -o ./output/${DB_NAME}/${SCRIPT_NAME}.csv \
        -W -w 32768 -s ","
done
