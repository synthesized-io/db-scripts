SELECT r.creator as schema_name,
       r.tbname as child_table_name,
       r.reftbname as parent_table_name,
       r.relname as fk_name,
       fk_columns.colname as child_column_name,
       r.refkeyname as pk_name,
       pk_columns.colname as parent_column_name
from sysibm.sysrels r
JOIN SYSIBM.SYSKEYCOLUSE fk_columns ON fk_columns.tbcreator = r.creator AND fk_columns.tbname = r.tbname AND fk_columns.constname = r.relname
JOIN SYSIBM.SYSKEYCOLUSE pk_columns ON pk_columns.tbcreator = r.reftbcreator AND pk_columns.tbname = r.reftbname AND pk_columns.constname = r.refkeyname AND pk_columns.colseq = fk_columns.colseq
ORDER BY r.creator, r.tbname, fk_columns.colseq
