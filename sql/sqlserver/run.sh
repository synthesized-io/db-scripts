export DB_NAME=sakila
export DB_HOST=127.0.0.1,1433
export DB_USER=test_user_2
export DB_PASSWORD=Uvxs245!
export scripts=("columns_data_types.sql" "constraints.sql" "cyclic_table_references.sql" "databases.sql" "pii_columns.sql" "schemas_relations.sql" "tables.sql" "schemas.sql", "user_permissions.sql")

mkdir -p ./output/${DB_NAME}

for current_script in ${scripts[@]}; do
    export SCRIPT_NAME=$current_script
    echo "Execting $current_script ..."
    /opt/mssql-tools18/bin/sqlcmd -C -S ${DB_HOST} -d ${DB_NAME} -U ${DB_USER} -P ${DB_PASSWORD} \
        -i init_script.sql,${SCRIPT_NAME} \
        -W -w 32768 -s "," 1> ./output/${DB_NAME}/${SCRIPT_NAME}.csv
done
