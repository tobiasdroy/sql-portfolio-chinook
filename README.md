# SQL Portfolio - Chinook Database

## About this project

This repository contains a set of SQL queries written against the Chinook sample database, a mock digital music store with tables for customers, invoices, tracks, albums, artists, genres, and playlists. Each query answers a specific business question using joins across multiple tables, aggregate functions, filtering, and set operations. The goal was to practise SQL the way it's actually used: starting from a question, working out which tables hold the answer, and writing a query to find it.

## Tools used

SQLite, DB Browser for SQLite

## Revenue by country

**Question:** Which countries have generated the most revenue for the store?

**Query**
```sql
SELECT
		Customer.Country AS country,
		SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS total_revenue
FROM InvoiceLine
JOIN Invoice ON InvoiceLine.InvoiceId =  Invoice.InvoiceId
JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
GROUP BY Customer.Country
ORDER BY total_revenue DESC
LIMIT 5;
```

**Result:**
<img width="187" height="154" alt="image" src="https://github.com/user-attachments/assets/e38b4001-ec54-4dd2-b0ff-66625e4e8bbe" />

**Finding:** The USA leads at $523.06, roughly 3.3 times fifth-placed Germany.

## Revenue by genre

**Question:** Which genres have generated the most revenue for the store?

**Query**
```sql
SELECT
		Genre.Name AS genre_name,
		SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS total_revenue
FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId =  Track.TrackId
JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Genre.Name
ORDER BY total_revenue DESC
LIMIT 5;
```

**Result:**
<img width="233" height="154" alt="image" src="https://github.com/user-attachments/assets/71c36a0f-e2e2-40dc-aa0b-96c694ea2466" />

**Finding:** Rock is far and away the best selling genre, generating $826.65 in revenue, almost 9 times as much as fifth-placed TV Shows.

## Playlists by track number

**Question:** Which playlists have the most tracks?

**Query**
```sql
SELECT
		Playlist.Name AS playlist_name,
		COUNT(Track.TrackId) AS number_of_tracks
FROM Track
JOIN PlaylistTrack ON Track.TrackId =  PlaylistTrack.TrackId
JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
GROUP BY Playlist.PlaylistId
ORDER BY number_of_tracks DESC
LIMIT 5;
```

**Result:** 
<img width="256" height="154" alt="image" src="https://github.com/user-attachments/assets/a032dfc6-485a-49bc-a4d9-5d30a206afd8" />

**Finding:** Two pairs of playlists share identical track counts. "Music" appears twice at 3,290 tracks, and "TV Shows" appears twice at 213, despite being separate playlist entries with distinct PlaylistIds. This raised the question of whether they contain the exact same tracks or just coincidentally matching totals.

### Follow-up: verifying the duplicate playlists

To check whether the two "Music" and two "TV Shows" playlists contain identical tracks rather than just matching counts, I compared their TrackIds using `EXCEPT`, which returns any rows present in the first query but absent from the second:

**Query**
```sql
SELECT PlaylistId, Name FROM Playlist WHERE Name IN ('Music', 'TV Shows');

SELECT TrackId FROM PlaylistTrack WHERE PlaylistId = 1
EXCEPT
SELECT TrackId FROM PlaylistTrack WHERE PlaylistId = 8;
```

**Result:** PlaylistIds 1 & 8 were both named "Music", and PlaylistIds 3 & 10 were both named "TV Shows". Checking both playlists using `EXCEPT` returned zero rows.
<img width="359" height="103" alt="image" src="https://github.com/user-attachments/assets/b5fa7675-c49d-4a52-8a0a-1e0d9e6f662c" />


**Finding:** The two "Music" and two "TV Shows" playlists contain exactly the same tracks. They are duplicates in the source data, not a coincidence of matching totals.

## Biggest Bossa Nova Lovers

**Question:** Which customers have generated the most revenue by buying Bossa Nova tracks?

**Query**
```sql
SELECT
		Customer.FirstName AS customer_first_name,
		Customer.LastName AS customer_last_name,
		SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS total_revenue
FROM InvoiceLine
JOIN Invoice ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
JOIN Track on InvoiceLine.TrackId = Track.TrackId
JOIN Genre on Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Bossa Nova'
GROUP BY Customer.CustomerId
ORDER BY total_revenue DESC
LIMIT 5;
```

**Result:**
<img width="429" height="154" alt="image" src="https://github.com/user-attachments/assets/ac8c3336-9900-44bd-a565-6d08b238449b" />

 
**Finding:** François Tremblay has spent the most at $3.96, corresponding to 4 tracks bought, closely followed by Tim Goyer who bought 3 tracks.

## Skills demonstrated
- Multi-table joins (up to 4 tables per query)
- Aggregate functions (SUM, COUNT)
- Filtering with WHERE
- GROUP BY and ORDER BY
- Set operations (EXCEPT) to compare row sets between groups
- Investigating and verifying anomalies in query results, rather than reporting them at face value

