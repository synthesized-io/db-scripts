select
    t.name,
    c.name,
    count(*)
from sys.foreign_key_columns as fc
inner join sys.foreign_keys as f on f.object_id = fc.constraint_object_id
inner join
    sys.columns as c
    on c.object_id = fc.parent_object_id and c.column_id = fc.parent_column_id
inner join sys.tables as t on t.object_id = c.object_id
group by t.name, c.name
having count(*) > 1
order by t.name, c.name;
