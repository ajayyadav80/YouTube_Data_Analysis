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

CREATE EXTERNAL TABLE stats_data (
	[video_id] nvarchar(4000),
	[trending_date] nvarchar(4000),
	[title] nvarchar(4000),
	[channel_title] nvarchar(4000),
	[category_id] float,
	[publish_time] nvarchar(4000),
	[tags] nvarchar(4000),
	[views] float,
	[likes] float,
	[dislikes] float,
	[comment_count] float,
	[thumbnail_link] nvarchar(4000),
	[comments_disabled] bit,
	[ratings_disabled] bit,
	[video_error_or_removed] bit,
	[description] nvarchar(4000)
	)
	WITH (
	LOCATION = 'YouTube_data_analysis/Youtube_Data_Analysis_cleaned/csv_data/**',
	DATA_SOURCE = [de-on-youtubedata_deblobajay_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.stats_data
GO