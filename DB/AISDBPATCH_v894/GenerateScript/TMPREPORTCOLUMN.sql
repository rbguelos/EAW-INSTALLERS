
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[report].[TMPREPORTCOLUMN]') AND type in (N'U'))
DROP TABLE [report].[TMPREPORTCOLUMN]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [report].[TMPREPORTCOLUMN](
	[ReportColumnId] [bigint] IDENTITY(1,1) NOT NULL,
	[ReportProcessId] [varchar](50) NULL,
	[ReportId] [bigint] NULL,
	[ReportColumn] [varchar](150) NULL,
	[ReportDataValue] [varchar](150) NULL,
	[ReportDataType] [varchar](10) NULL,
	[ColumnOrderNumber] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportColumnId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


