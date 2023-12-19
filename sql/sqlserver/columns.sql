select
    schema_name(tab.schema_id) as schema_name,
    tab.name as table_name,
    c.name as column_name,
    t.name as type_name,
    bt.name as base_type_name,
    c.max_length,
    c.precision,
    c.scale,
    c.is_nullable
from sys.columns as c
inner join
    sys.tables as tab
    on tab.object_id = c.object_id and tab.is_ms_shipped = 0
left join sys.types as t on c.user_type_id = t.user_type_id
left join sys.types as bt on t.system_type_id = bt.user_type_id
order by schema_name(tab.schema_id), tab.name;
