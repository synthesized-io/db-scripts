select
    t.name as table_name,
    i.name as index_name,
    col.name as column_name,
    ic.index_id as column_index_id,
    ic.index_column_id as column_index_column_id,
    ic.is_descending_key as column_is_descending_key,
    i.is_disabled,
    i.auto_created,
    i.type,
    i.type_desc,
    i.is_unique,
    i.is_unique_constraint,
    i.is_primary_key,
    i.is_hypothetical,
    i.has_filter,
    i.filter_definition,
    schema_name(t.schema_id) as schema_name
from sys.indexes as i
inner join sys.tables as t on t.object_id = i.object_id and t.is_ms_shipped != 1
inner join 
     sys.index_columns ic ON  i.object_id = ic.object_id and i.index_id = ic.index_id 
inner join 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
where i.type > 0
order by schema_name(t.schema_id), t.name, i.name;
