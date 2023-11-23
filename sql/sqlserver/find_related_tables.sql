with tables as (
    select
        t.name,
        t.object_id,
        t.row_count,
        (
            select count(*)
            from sys.foreign_keys as fk
            where fk.parent_object_id = t.object_id
        ) as parent_tables_count,
        (
            select count(*)
            from sys.foreign_keys as fk
            where fk.referenced_object_id = t.object_id
        ) as child_tables_count
    from (
        select
            t.name,
            t.object_id,
            sum(dps.row_count) as row_count
        from sys.dm_db_partition_stats as dps
        inner join
            sys.tables as t
            on t.object_id = dps.object_id and t.is_ms_shipped = 0
        where dps.index_id < 2
        group by t.name, t.object_id
    ) as t
)
select
    rt.name as parent_table_name,
    rt.row_count as parent_table_row_count,
    pt.name as child_table_name,
    pt.row_count as parent_table_row_count
from sys.foreign_keys as fk
inner join
    tables as pt
    on
        pt.object_id = fk.parent_object_id
        and pt.child_tables_count = 1
inner join
    tables as rt
    on rt.object_id = fk.referenced_object_id and rt.parent_tables_count = 0
where pt.row_count between 10000 and 50000 and rt.row_count between 10000 and 50000;
