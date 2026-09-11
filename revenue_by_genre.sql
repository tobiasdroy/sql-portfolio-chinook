SELECT
		Genre.Name AS genre_name,
		SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS total_revenue
FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId =  Track.TrackId
JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Genre.Name
ORDER BY total_revenue DESC
LIMIT 5;
