set nocount on;

select
    t.name as table_name,
    col.name as column_name,
    t.type,
    t.type_desc,
    c.type as constraint_type,
    c.type_desc as constraint_type_desc,
    c.name as constraint_name,
    i.name as index_name,
    i.type as index_type,
    i.type_desc as index_type_desc,
    schema_name(t.schema_id) as schema_name
from sys.objects as t
inner join sys.indexes as i on t.object_id = i.object_id
inner join
    sys.key_constraints as c
    on i.object_id = c.parent_object_id and i.index_id = c.unique_index_id
left join
    sys.index_columns as ic
    on ic.object_id = t.object_id and ic.index_id = i.index_id
left join
    sys.columns as col
    on ic.object_id = col.object_id and ic.column_id = col.column_id
where t.is_ms_shipped = 0
order by schema_name(t.schema_id), t.name, col.name;
