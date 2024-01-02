set nocount on;

select stats.last_execution_time,
  stats.execution_count,
  stats.total_rows,
  stats.last_rows,
  s.text
from sys.dm_exec_query_stats stats
cross apply sys.dm_exec_sql_text(stats.sql_handle) s
order by last_execution_time desc;
