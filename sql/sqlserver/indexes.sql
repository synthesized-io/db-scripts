select
    t.name,
    i.name,
    i.is_disabled,
    i.auto_created,
    i.type,
    i.type_desc,
    i.is_unique,
    i.is_unique_constraint,
    i.is_primary_key,
    i.is_hypothetical,
    i.auto_created,
    i.has_filter,
    i.filter_definition,
    schema_name(t.schema_id) as schema_name
from sys.indexes as i
inner join sys.tables as t on t.object_id = i.object_id and t.is_ms_shipped != 1
where i.type > 0
order by schema_name(t.schema_id), t.name, i.name;
