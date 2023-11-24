select
    c.type_name,
    count(*) as columns_count
from (
    select coalesce(bt.name, t.name) as type_name
    from sys.columns as c
    left join sys.types as t on c.system_type_id = t.system_type_id
    left join sys.types as bt on t.system_type_id = bt.user_type_id
    left join sys.objects as o on c.object_id = o.object_id
    left join sys.schemas as s on s.schema_id = o.schema_id
    where s.name not in ('sys')
) as c
group by c.type_name
order by 2 desc, 1 asc;
