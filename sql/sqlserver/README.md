# MS SQL Server scripts

Retrieve the files:

```shell
git clone https://github.com/synthesized-io/db-scripts
cd sql/sqlserver
```

Minimal permissions for a database user:

```sql
grant view any definition to [USERNAME];
grant view server state to [USERNAME];
```


### Set connection details

```shell
export DB_NAME=sakila
export DB_HOST=127.0.0.1,1433
export DB_USER=sa
export DB_PASSWORD=Secret_password_1
```


### Run a specific script

Specify the name of the specific script (you can retrieve all available scripts using this command - `ls *.sql`):

```shell
export SCRIPT_NAME="schemas.sql"
```

Run the script using a Docker image:

```shell
docker run -it --net=host \
    -v ${PWD}:/sql \
    mcr.microsoft.com/mssql-tools \
    bash -c \
    "/opt/mssql-tools/bin/sqlcmd -S ${DB_HOST} -U ${DB_USER} -P ${DB_PASSWORD} -d ${DB_NAME} -i /sql/${SCRIPT_NAME}"
```

Run the script using the `sqlcmd` tools:

```shell
sqlcmd -C -S ${DB_HOST} -d ${DB_NAME} -U ${DB_USER} -P ${DB_PASSWORD} -i ${SCRIPT_NAME}
```


### Run all scripts in CSV output format

```shell
sh ./run.sh
```
