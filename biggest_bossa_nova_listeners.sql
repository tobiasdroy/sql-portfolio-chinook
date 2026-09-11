SELECT
		Customer.FirstName AS cusotomer_first_name,
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
