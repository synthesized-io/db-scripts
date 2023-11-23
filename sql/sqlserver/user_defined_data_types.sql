select
    u.name as user_type,
    s.name as base_type,
    u.[precision],
    u.[scale],
    u.max_length,
    u.is_nullable,
    u.is_assembly_type,
    u.is_table_type,
    u.rule_object_id
from sys.types as u
inner join sys.types as s on u.system_type_id = s.user_type_id
where u.is_user_defined = 1;
