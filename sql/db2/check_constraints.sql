select 
  con.tabschema AS schema_name,
  con.tabname as table_name,
  con.constname as constraint_name,
  col.colname as column_name,
  con.text  as definition,
  tab.enforced AS enforced
from syscat.checks con
join syscat.colchecks col on col.constname = con.constname 
        and col.tabschema = con.tabschema 
        and col.tabname = con.tabname
join syscat.tabconst tab on tab.constname = con.constname 
        and tab.tabschema = con.tabschema 
        and tab.tabname = con.tabname
where con.tabschema not like 'SYS%'
order by con.tabschema, con.tabname, con.constname

