# db-scripts
The set of plain SQL queries to help clarify the structure and current state of various databases


```shell
export DATABASE_NAME=sakila
export HOST_NAME=127.0.0.1,1433
export USERNAME=sa
export PASSWORD=Secret_password_1

export SCRIPT_NAME="sqlserver/tables.sql"
export SCRIPT_NAME="sqlserver/databases.sql"
export SCRIPT_NAME="sqlserver/cyclic_table_references.sql"
```

```shell
docker run -it --net=host \
    -v ${PWD}/sql:/sql \
    mcr.microsoft.com/mssql-tools \
    bash -c \
    "/opt/mssql-tools/bin/sqlcmd -S ${HOST_NAME} -U ${USERNAME} -P ${PASSWORD} -d ${DATABASE_NAME} -i ./sql/${SCRIPT_NAME}"
```


<!-- TODO -->
- Set CSV output
