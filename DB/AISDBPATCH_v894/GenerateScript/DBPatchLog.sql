/****** Object:  Table [admin].[DBPatchLog]    Script Date: 10/9/2017 3:19:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [admin].[DBPatchLog](
	[DBPatchLogId] [bigint] IDENTITY(1,1) NOT NULL,
	[DBPatchId] [int] NULL,
	[DBVersionNo] [varchar](30) NULL,
	[ScriptName] [varchar](250) NULL,
	[Status] [varchar](2048) NULL,
	[DateRun] [datetime] NULL,
	[Duration] [decimal](18,4) NULL,
	[TypeCode] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[DBPatchLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


