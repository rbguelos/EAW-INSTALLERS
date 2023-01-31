/****** Object:  StoredProcedure [dbo].[AlterColumn]  ******/
IF EXISTS (SELECT
	*
FROM sys.objects
WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AlterColumn]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[AlterColumn]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AlterColumn] 
--DECLARE
	@SCHEMA VARCHAR (50) = 'dbo',
	@TABLENAME VARCHAR (50) = 'TestTable', 
	@COLUMNNAME VARCHAR (50) = 'col1', 
	@NEWCOLUMNNAME VARCHAR (50) = 'col1updated',
	@DATATYPE VARCHAR (50) = 'varchar(30)' 
AS 
BEGIN
SET NOCOUNT ON;

BEGIN TRY

DECLARE @SCMD NVARCHAR (MAX)
SET @SCMD = '  IF EXISTS(SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE COLUMN_NAME=''' + @COLUMNNAME + ''' AND TABLE_NAME=''' + @TABLENAME + '''   )    
BEGIN
IF NOT EXISTS(
SELECT DBNew.COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS DBNew
WHERE 1=1
AND rtrim('''' + DBNew.DATA_TYPE + '''' + 
	CASE WHEN DBNew.DATA_TYPE IN (''image'',''text'',''binary'',''ntext'') THEN '''' 
	WHEN DBNew.DATA_TYPE IN (''decimal'') THEN + ''('' + CAST(DBNew.NUMERIC_PRECISION AS varchar) + '','' + CAST(DBNew.NUMERIC_SCALE AS varchar) + '')''
	ELSE 
	CASE coalesce(DBNew.CHARACTER_MAXIMUM_LENGTH,0) 
							WHEN 0 THEN ''''
							WHEN -1 THEN ''(max)''
							ELSE ''('' + CAST(DBNew.CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + '')'' END END) = ''' + RTRIM(@DATATYPE) + '''
AND DBNew.TABLE_NAME = ''' + @TABLENAME + '''
AND DBNew.COLUMN_NAME = ''' + @COLUMNNAME + '''
)
BEGIN
ALTER TABLE '+@SCHEMA+'.[' + @TABLENAME + '] ALTER COLUMN [' + @COLUMNNAME + '] ' + @DATATYPE + ' 
END
END'

EXEC (@SCMD)


IF (@COLUMNNAME <> ISNULL(@NEWCOLUMNNAME,'') AND ISNULL(@NEWCOLUMNNAME,'') <> '' AND EXISTS(SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE COLUMN_NAME = @COLUMNNAME AND TABLE_NAME = @TABLENAME))
BEGIN
	SET @SCMD = 'EXECUTE sp_rename N'''+ @SCHEMA +'.'+@TABLENAME+'.'+@COLUMNNAME+''', N''Tmp_'+@NEWCOLUMNNAME+''', ''COLUMN'''
	EXEC (@SCMD);

	SET @SCMD = 'EXECUTE sp_rename N'''+@SCHEMA+'.'+@TABLENAME+'.Tmp_'+@NEWCOLUMNNAME+''', N'''+@NEWCOLUMNNAME+''', ''COLUMN'''
	EXEC (@SCMD);
END

	PRINT 'Column ' + @COLUMNNAME + ' updated to ' + @NEWCOLUMNNAME + '(' + @DATATYPE + ')'

END TRY
BEGIN CATCH
    --PRINT 'In catch block.';  
	IF CHARINDEX('Either the parameter @objname is ambiguous',ERROR_MESSAGE()) = 0 
	BEGIN

		DECLARE @errormsg VARCHAR(2048)
		,@ERRNO bigint

		SET @errormsg = 'Error executing ''''' + @errormsg + '''''' +  ERROR_MESSAGE();
		THROW 60000, @errormsg, 1;

		--SET @ERRNO = 50000--@@error
		--PRINT 'Alter Column "' + @COLUMNNAME + '" to "' + @NEWCOLUMNNAME + ' ' + @DATATYPE + '" of table ' + @TABLENAME;
		--RAISERROR (13000,-1,-1,'ALTERCOLUMN');
	END
	ELSE
	BEGIN
		PRINT 'Column ' + @COLUMNNAME + ' updated to ' + @NEWCOLUMNNAME + '(' + @DATATYPE + ')' 
	END
END CATCH
END

GO
