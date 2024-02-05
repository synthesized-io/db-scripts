select
    tabschema as table_schema,
    tabname as table_name,
    trigname as trigger_name,
    text as definition,
    case trigtime
        when 'B' then 'before'
        when 'A' then 'after'
        when 'I' then 'instead of'
    end as activation,
    rtrim(
        case when eventupdate = 'Y' then 'update ' else '' end
        concat
        case when eventdelete = 'Y' then 'delete ' else '' end
        concat
        case when eventinsert = 'Y' then 'insert ' else '' end
    )
    as event_type,
    case
        when enabled = 'N' then 'disabled'
        else 'active'
    end as status
from syscat.triggers
where tabschema not like 'SYS%'
order by tabschema, tabname, trigname
