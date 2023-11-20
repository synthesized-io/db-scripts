# MS SQL Server scripts


```shell
export DB_NAME=sakila
export DB_HOST=127.0.0.1,1433
export DB_USER=sa
export DB_PASSWORD=Secret_password_1

export SCRIPT_NAME="tables.sql"
export SCRIPT_NAME="databases.sql"
export SCRIPT_NAME="cyclic_table_references.sql"
```

```shell
docker run -it --net=host \
    -v ${PWD}:/sql \
    mcr.microsoft.com/mssql-tools \
    bash -c \
    "/opt/mssql-tools/bin/sqlcmd -S ${DB_HOST} -U ${DB_USER} -P ${DB_PASSWORD} -d ${DB_NAME} -i /sql/${SCRIPT_NAME}"
```

```shell
scripts=("columns_data_types.sql" "constraints.sql" "cyclic_table_references.sql" "databases.sql" "pii_columns.sql" "schemas_relations.sql" "tables.sql")
```

```shell
for current_script in ${scripts[@]}; do
    export SCRIPT_NAME=$current_script
    /opt/mssql-tools18/bin/sqlcmd -C -S ${DB_HOST} -d ${DB_NAME} -U ${DB_USER} -P ${DB_PASSWORD} \
        -i init_script.sql,${SCRIPT_NAME} \
        -o ./output/${SCRIPT_NAME}.csv \
        -W -w 32768 -s ","
done
```
