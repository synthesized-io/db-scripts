with db_files as (
    select
        cast(sum(size) * 8. / 1024 / 1024 as DECIMAL(8, 2)) as total_size_gb,
        cast(
            sum(case when type_desc = 'ROWS' then size end)
            * 8.
            / 1024 / 1024 as DECIMAL(8, 2)
        ) as row_size_gb,
        cast(
            sum(case when type_desc = 'LOG' then size end)
            * 8.
            / 1024 / 1024 as DECIMAL(8, 2)
        ) as log_size_gb,
        db_name(database_id) as database_name
    from sys.master_files with (nowait)
    group by database_id
)

select
    f.database_name,
    f.total_size_gb,
    f.row_size_gb,
    f.log_size_gb,
    case
        when name in ('master', 'model', 'msdb', 'tempdb') then 1 else 0
    end as is_system_db,
    has_dbaccess(name) as has_db_access
from db_files as f
inner join sys.databases as d on f.database_name = d.name;
