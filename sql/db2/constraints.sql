select tab.creator as schema_name,
       tab.name as table_name,
       key.colname as column_name,
       const.NAME AS constraint_name,
       const.constraintyp AS constraint_type
from sysibm.systables tab
join sysibm.systabconst const on const.tbcreator = tab.creator
                              and const.tbname = tab.name
                              and const.constraintyp != 'F'
join sysibm.syskeycoluse key on const.tbcreator = key.tbcreator
                             and const.tbname = key.tbname
                             and const.name = key.constname
order by tab.creator, tab.name, key.colseq
