select
    t.name,
    count(*) as columns_count
from sys.columns as c
left join systypes as t on c.system_type_id = t.xtype
left join sys.objects as o on c.object_id = o.object_id
left join sys.schemas as s on s.schema_id = o.schema_id
where s.name not in ('sys')
group by t.name
order by columns_count desc;
