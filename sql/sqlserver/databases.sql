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
group by database_id;
