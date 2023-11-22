select
    tt.name,
    tt.is_user_defined,
    tt.rule_object_id,
    tt.is_table_type,
    c.name as column_name,
    st.name as column_data_type_name,
    c.max_length as column_max_length,
    c.[precision] as column_precision,
    c.[scale] as column_scale,
    c.is_nullable as column_is_nullable
from sys.table_types as tt
left join sys.columns as c on c.object_id = tt.type_table_object_id
inner join sys.systypes as st on st.xtype = c.system_type_id
