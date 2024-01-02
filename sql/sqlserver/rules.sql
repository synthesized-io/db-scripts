set nocount on;

select
    name as rule_name,
    syscomments.text as rule_definition
from sysobjects
inner join syscomments on sysobjects.id = syscomments.id
where sysobjects.xtype = 'R';
