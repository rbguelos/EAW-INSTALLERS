EXEC spInsertTableData 
@SCHEMA = 'maintenance'
,@TABLENAME = 'EnumValues'
,@COLUMNS = '[SourceName],[DisplayText],[Value],[OrderNumber],[Status]'
,@VALUETOINSERT = 
'OfficialBusinessType|Field Work- MM|7|6|0
OfficialBusinessType|Field Work- Non-MM|8|7|0'
,@COLUMNSEPARATOR = '|'
,@ROWSEPARATATOR = '
',
@CHECKDUPLICATECOLUMNS = '[SourceName],[DisplayText]'

UPDATE maintenance.EnumValues SET OrderNumber = 8 WHERE SourceName = 'OfficialBusinessType' AND DisplayText = 'Others'
SELECT * FROM maintenance.EnumValues WHERE SourceName LIKE '%OfficialBusinessType%'