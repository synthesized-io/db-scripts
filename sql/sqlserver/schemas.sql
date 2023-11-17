select
    s.name as schema_name,
    count(*) as tables_count
from sys.tables as t
inner join sys.schemas as s on s.schema_id = t.schema_id
where
    t.name not like 'dt%'
    and t.is_ms_shipped = 0
group by s.name
