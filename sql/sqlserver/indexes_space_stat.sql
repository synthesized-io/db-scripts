select
    i.type_desc,
    i.is_unique,
    i.is_unique_constraint,
    i.is_primary_key,
    count(distinct i.name) as indexes_count,
    sum(i.in_row_reserved_page_kb) / 1024 / 1024 as in_row_reserved_gb,
    sum(i.lob_reserved_page_kb) / 1024 / 1024 as lob_used_gb
from (select
    i.name,
    i.type_desc,
    i.is_unique,
    i.is_unique_constraint,
    i.is_primary_key,
    p.in_row_reserved_page_count * 8 as in_row_reserved_page_kb,
    p.lob_reserved_page_count * 8 as lob_reserved_page_kb
from sys.indexes as i
inner join
    sys.dm_db_partition_stats as p
    on i.object_id = p.object_id and i.index_id = p.index_id
inner join sys.tables as t on t.object_id = i.object_id and t.is_ms_shipped != 1
where i.type > 0) as i
group by
    i.type_desc,
    i.is_unique,
    i.is_unique_constraint,
    i.is_primary_key;
