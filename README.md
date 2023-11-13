# db-scripts
The set of plain SQL queries to help clarify the structure and current state of various databases


```shell
export SCRIPT_NAME="sqlserver/tables.sql"
export SCRIPT_NAME="sqlserver/databases.sql"
export SCRIPT_NAME="sqlserver/cyclic_table_references.sql"
```

```shell
docker run -it --net=host \
    -v ${PWD}/sql:/sql \
    mcr.microsoft.com/mssql-tools \
    bash -c \
    "/opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -P Secret_password_1 -d sakila -i ./sql/${SCRIPT_NAME}"
```
