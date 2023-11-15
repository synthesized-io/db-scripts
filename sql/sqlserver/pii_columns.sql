select
    c.name as "column",
    object_name(o.object_id) as "table",
    db_name() as "database"
from sys.columns as c inner join sys.objects as o on c.object_id = o.object_id
where
    o.type in ('U')
    and (
        c.name like '%mail%'
        or c.name like '%first%name%'
        or c.name like '%last%name%'
        or c.name like '%birth%'
        or c.name like '%sex%'
        or c.name like '%address%'
        or c.name like '%phone%'
        or c.name like '%social%'
        or c.name like '%ssn%'
        or c.name like '%gender%'
    );
