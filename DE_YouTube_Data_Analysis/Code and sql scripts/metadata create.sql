IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'de-on-youtubedata_deblobajay_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [de-on-youtubedata_deblobajay_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://de-on-youtubedata@deblobajay.dfs.core.windows.net' 
	)
GO


CREATE EXTERNAL TABLE metadata_youtube (
	[etag] nvarchar(4000),
	[id] NVARCHAR(4000),
	[kind] nvarchar(4000),
	[assignable] bit,
	[channelId] nvarchar(4000),
	[title] nvarchar(4000)
	)

	WITH (
	LOCATION = 'YouTube_data_analysis/Youtube_Data_Analysis_cleaned/json_data/**',
	DATA_SOURCE = [de-on-youtubedata_deblobajay_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.metadata_youtube
GO