DROP VIEW if EXISTS dbo.Merged_table; 

CREATE VIEW [dbo].Merged_table
	AS SELECT m.channelId,m.kind,m.title,
	s.trending_date,s.views, s.likes, s.dislikes, s.comment_count
	FROM dbo.metadata_youtube m INNER join 
	dbo.stats_data s ON m.id = s.category_id;
