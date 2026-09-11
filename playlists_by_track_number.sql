SELECT
		Playlist.Name AS playlist_name,
		COUNT(Track.TrackId) AS number_of_tracks
FROM Track
JOIN PlaylistTrack ON Track.TrackId =  PlaylistTrack.TrackId
JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
GROUP BY Playlist.PlaylistId
ORDER BY number_of_tracks DESC
LIMIT 5;
