```shell
export DATABASE_NAME=sakila
export HOST_NAME=127.0.0.1,1433
export USERNAME=sa
export PASSWORD=Secret_password_1

export SCRIPT_NAME="tables.sql"
export SCRIPT_NAME="databases.sql"
export SCRIPT_NAME="cyclic_table_references.sql"
```

```shell
docker run -it --net=host \
    -v ${PWD}/sql:/sql \
    mcr.microsoft.com/mssql-tools \
    bash -c \
    "/opt/mssql-tools/bin/sqlcmd -S ${HOST_NAME} -U ${USERNAME} -P ${PASSWORD} -d ${DATABASE_NAME} -i ./sql/sqlserver/${SCRIPT_NAME}"
```

```shell
/opt/mssql-tools18/bin/sqlcmd -C -H ${HOST_NAME} -d ${DATABASE_NAME} -U ${USERNAME} -P ${PASSWORD} \
    -i ${SCRIPT_NAME} \
    -o ./output/${SCRIPT_NAME} \
    -W -w 1024 -s "," -h-1
```
