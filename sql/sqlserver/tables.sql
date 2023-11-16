select
    t.table_name,
    t.schema_name,
    t.row_counts,
    t.total_space_kb / 1024 / 1024 as total_space_gb,
    t.used_space_kb / 1024 / 1024 as used_space_gb,
    (t.total_space_kb - t.used_space_kb) / 1024 / 1024 as unused_space_gb,
    t.in_row_reserved_page_count / 1024 / 1024 as in_row_reserved_gb,
    t.in_row_used_page_count / 1024 / 1024 as in_row_used_gb,
    t.lob_used_page_count / 1024 / 1024 as lob_used_gb,
    t.lob_reserved_page_count / 1024 / 1024 as lob_reserved_gb,
    (select count(*) from sys.columns as c where c.object_id = t.table_id
    ) as columns_count
from (
    select
        t.name as table_name,
        t.object_id as table_id,
        s.name as schema_name,
        p.row_count as row_counts,
        sum(p.in_row_reserved_page_count) * 8
        + sum(p.lob_reserved_page_count) * 8 as total_space_kb,
        sum(p.in_row_used_page_count) * 8
        + sum(lob_used_page_count) * 8 as used_space_kb,
        sum(p.in_row_reserved_page_count) * 8 as in_row_reserved_page_count,
        sum(p.in_row_used_page_count) * 8 as in_row_used_page_count,
        sum(p.lob_used_page_count) * 8 as lob_used_page_count,
        sum(p.lob_reserved_page_count) * 8 as lob_reserved_page_count
    from
        sys.tables as t
    inner join sys.indexes as i on t.object_id = i.object_id
    inner join
        sys.dm_db_partition_stats as p
        on i.object_id = p.object_id and i.index_id = p.index_id
    left outer join sys.schemas as s on t.schema_id = s.schema_id
    where
        t.name not like 'dt%'
        and t.is_ms_shipped = 0
        and i.object_id > 255
    group by
        t.name, t.object_id, s.name, p.row_count
) as t
order by
    t.table_name;
