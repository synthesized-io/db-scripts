SELECT
   db_name() as database_name,
   isnull( s.name, '' ) as schema_name,
   isnull( o.name, 'DDL Trigger') as table_name,
   t.name as trigger_name, 
   object_definition( t.object_id ) as definition
FROM sys.triggers t
   LEFT JOIN sys.all_objects o
      ON t.parent_id = o.object_id
   LEFT JOIN sys.schemas s
      ON s.schema_id = o.schema_id
where t.is_ms_shipped != 1
ORDER BY 
   schema_name,
   table_name,
   trigger_name;
