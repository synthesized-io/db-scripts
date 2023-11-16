select
    s.name as schema_name,
    db_name() as database_name,
    count(*) as fks_count,
    case
        when (max(parent_tbl.schema_id) = min(ref_tbl.schema_id)) then 0 else 1
    end as depends_on_another_schemas
from sys.foreign_keys as f
inner join sys.schemas as s on s.schema_id = f.schema_id
inner join
    sys.objects as parent_tbl
    on f.parent_object_id = parent_tbl.object_id
inner join sys.objects as ref_tbl on f.referenced_object_id = ref_tbl.object_id
group by s.name;
