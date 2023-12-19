select
    schema_name(fk.schema_id) as schema_name,
    object_name(c.object_id) as child_table_name,
    object_name(cr.object_id) as parent_table_name,
    fk.name as fk_name,
    c.name as child_column_name,
    cr.name as parent_column_name
from sys.foreign_key_columns as fkc
inner join
    sys.foreign_keys as fk
    on fk.object_id = fkc.constraint_object_id and fk.is_ms_shipped = 0
inner join
    sys.columns as c
    on c.object_id = fkc.parent_object_id and c.column_id = fkc.parent_column_id
inner join
    sys.columns as cr
    on cr.object_id = fkc.referenced_object_id and cr.column_id = fkc.referenced_column_id
order by schema_name(fk.schema_id), object_name(c.object_id), fk.name;
