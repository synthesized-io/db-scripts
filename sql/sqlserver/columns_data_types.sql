select
    t.name,
    t.is_user_defined,
    count(*) as columns_count
from sys.columns as c
left join sys.types as t on c.system_type_id = t.system_type_id
left join sys.objects as o on c.object_id = o.object_id
left join sys.schemas as s on s.schema_id = o.schema_id
where s.name not in ('sys')
group by
    t.name,
    t.is_user_defined
order by columns_count desc, t.name asc;
