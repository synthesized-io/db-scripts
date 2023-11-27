-- Disable foreign key constraints in dbo schema
EXEC sp_MSforeachtable "IF OBJECT_SCHEMA_NAME(object_id('?')) = 'dbo' BEGIN ALTER TABLE ? NOCHECK CONSTRAINT all END"

-- Delete all data from tables in dbo schema
EXEC sp_MSforeachtable "IF OBJECT_SCHEMA_NAME(object_id('?')) = 'dbo' BEGIN DELETE FROM ? END"

-- Re-enable foreign key constraints in dbo schema
EXEC sp_MSforeachtable "IF OBJECT_SCHEMA_NAME(object_id('?')) = 'dbo' BEGIN ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL END"
