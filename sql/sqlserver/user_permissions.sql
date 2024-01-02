set nocount on;

select
    entity_name,
    subentity_name,
    permission_name
from fn_my_permissions(null, 'database');
