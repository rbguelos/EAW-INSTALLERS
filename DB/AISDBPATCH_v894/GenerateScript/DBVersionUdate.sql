/****** Object:  Table [dbo].[DBVersionUpdate]    Script Date: 7/9/2016 2:38:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF OBJECT_ID('admin.DBVersionUpdate') IS NULL
CREATE TABLE [admin].[DBVersionUpdate](
	[DBVersionId] [bigint] IDENTITY(1,1) NOT NULL,
	[VersionNo] [int] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_DBVersionUpdate] PRIMARY KEY CLUSTERED 
(
	[DBVersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*new column*/
IF (select [name] from sys.columns where object_id = OBJECT_ID('admin.DBVersionUpdate') and [name] = 'SystemVersion') IS NULL
	ALTER TABLE admin.DBVersionUpdate ADD SystemVersion varchar(30) NULL
GO

IF (select [name] from sys.columns where object_id = OBJECT_ID('admin.DBVersionUpdate') and [name] = 'Mode') IS NULL
	ALTER TABLE admin.DBVersionUpdate ADD Mode varchar(30) NULL;
GO

UPDATE admin.DBVersionUpdate SET Mode = 'databasepatch' WHERE Mode IS NULL;
GO


