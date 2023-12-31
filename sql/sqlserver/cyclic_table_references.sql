set nocount on;

with
refs as (
    select
        ps.name + '.' + p.name as id,
        rs.name + '.' + r.name as pid
    from sys.foreign_keys as f
    inner join sys.objects as p on p.object_id = f.parent_object_id
    inner join sys.schemas as ps on ps.schema_id = p.schema_id
    inner join sys.objects as r on r.object_id = f.referenced_object_id
    inner join sys.schemas as rs on rs.schema_id = r.schema_id
),

findroot as (
    select
        id,
        pid,
        cast(id as nvarchar(max)) as path
    from refs
    union all
    select
        c.id,
        p.pid,
        c.path + N' > ' + cast(p.id as nvarchar(max))
    from refs as p
    inner join findroot as c on c.pid = p.id and p.pid != p.id and c.pid != c.id
)

select *
from findroot as r
where r.id = r.pid;
