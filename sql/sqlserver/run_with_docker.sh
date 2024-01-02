export DB_NAME=sakila
export DB_HOST=127.0.0.1,1433
export DB_USER=test_user_2
export DB_PASSWORD=Uvxs245!
export scripts=("check_constraints.sql" "columns_data_types_basic.sql" "columns_data_types.sql" "columns.sql" "constraints.sql" "databases.sql" "foreign_keys.sql" "indexes_space_stat.sql" "indexes.sql" "rules.sql" "schemas_relations.sql" "schemas.sql" "table_data_types.sql" "tables.sql" "triggers.sql" "user_defined_data_types.sql" )

mkdir -p ./output/${DB_NAME}

for current_script in ${scripts[@]}; do
    export SCRIPT_NAME=$current_script
    echo "Executing $current_script ..."

    docker run -it --net=host \
        -v ${PWD}:/sql \
        mcr.microsoft.com/mssql-tools \
        bash -c \
        "/opt/mssql-tools/bin/sqlcmd -C -S ${DB_HOST} -U ${DB_USER} -P ${DB_PASSWORD} -d ${DB_NAME} \
        -i /sql/${SCRIPT_NAME} \
        -W -w 32768 -s "," 1> /sql/output/${DB_NAME}/${SCRIPT_NAME}.csv"

done
