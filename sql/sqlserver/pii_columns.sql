set nocount on;

with tables as (
    select
        t.name,
        t.object_id,
        schema_name(t.schema_id) as schema_name,
        sum(dps.row_count) as row_count
    from sys.dm_db_partition_stats as dps
    inner join sys.tables as t on t.object_id = dps.object_id
    where dps.index_id < 2
    group by t.schema_id, t.name, t.object_id
)

select
    t.schema_name,
    t.name as table_name,
    c.name as column_name,
    t.row_count
from tables as t
inner join sys.columns as c on c.object_id = t.object_id
where (
    c.name like '%mail%'
    or c.name like '%first%name%'
    or c.name like '%last%name%'
    or c.name like '%birth%'
    or c.name like '%sex%'
    or c.name like '%address%'
    or c.name like '%phone%'
    or c.name like '%social%'
    or c.name like '%ssn%'
    or c.name like '%gender%'
)
order by 1, 2, 3;
