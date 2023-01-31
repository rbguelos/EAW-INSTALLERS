DECLARE @CMD VARCHAR(MAX)

SET @CMD = '
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[DeleteColumn]'') AND type in (N''P'', N''PC''))
DROP PROCEDURE [dbo].[DeleteColumn]'

EXEC (@CMD);

SET @CMD ='
CREATE PROCEDURE [dbo].[DeleteColumn] 
--DECLARE
	@TABLENAME VARCHAR (50) = '''', 
	@COLUMNNAME VARCHAR (50) = '''',
	@SCHEMA VARCHAR(50) = ''''
AS 
BEGIN
SET NOCOUNT ON;


SET @SCHEMA = ISNULL(@SCHEMA,''dbo'')
	
	DECLARE @ConstraintName nvarchar (200)
	,@SQLCMD VARCHAR(MAX)

	SELECT
		@ConstraintName = Name
	FROM SYS.DEFAULT_CONSTRAINTS
	WHERE PARENT_OBJECT_ID = OBJECT_ID(@SCHEMA + ''.'' + @TABLENAME) AND PARENT_COLUMN_ID = (SELECT
		column_id
	FROM sys.columns
	WHERE NAME = N'''' + @COLUMNNAME + '''' AND OBJECT_ID = OBJECT_ID(N'''' + @TABLENAME + ''''))

	IF @ConstraintName IS NOT NULL
	BEGIN
		SET @SQLCMD = ''ALTER TABLE '' + @SCHEMA + ''.'' + @TABLENAME + '' DROP CONSTRAINT '' + @ConstraintName
		--EXEC (@SQLCMD)
	END
	IF EXISTS (SELECT
		*
	FROM syscolumns
	WHERE id = OBJECT_ID(@SCHEMA + ''.'' + @TABLENAME) AND name = @COLUMNNAME)
	BEGIN
		SET @SQLCMD = ''ALTER TABLE '' + @SCHEMA + ''.''  + @TABLENAME + '' DROP COLUMN '' + @COLUMNNAME
	END

	EXEC (@SQLCMD);

IF @@ERROR <> 0 
	PRINT ERROR_MESSAGE()
ELSE 
	PRINT ''Column '' + @COLUMNNAME + '' for table '' + @TABLENAME + '' removed.''

END
'

EXEC (@CMD);
