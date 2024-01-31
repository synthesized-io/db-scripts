set nocount on;

select
    schema_name(schema_id) as schema_name,
    object_name(object_id) as table_name,
    type,
    type_desc,
    is_ms_shipped,
    is_disabled,
    definition,
    is_system_named
from sys.check_constraints;
