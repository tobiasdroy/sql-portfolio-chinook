# SQL Portfolio - Chinook Database

## About this project

This repository contains a set of SQL queries written against the Chinook sample database, a mock digital music store with tables for customers, invoices, tracks, albums, artists, genres, and playlists. Each query answers a specific business question using joins across multiple tables, aggregate functions, and filtering. The goal was to practise SQL the way it's actually used: starting from a question, working out which tables hold the answer, and writing a query to get there.

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


