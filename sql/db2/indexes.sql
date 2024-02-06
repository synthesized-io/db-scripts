select
    ind.indschema as schema_name,
    ind.tabname as table_name,
    ind.indname as index_name,
    cols.colname as column_name,
    ind.iid as index_id,
    ind.indextype as index_type
from syscat.indexes as ind
inner join syscat.indexcoluse as cols
    on
        ind.indname = cols.indname
        and ind.indschema = cols.indschema
where ind.tabschema not like 'SYS%'
order by
    schema_name,
    index_name,
    index_id
