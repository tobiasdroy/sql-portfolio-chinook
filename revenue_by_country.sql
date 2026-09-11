SELECT
		Customer.Country AS country,
		SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS total_revenue
FROM InvoiceLine
JOIN Invoice ON InvoiceLine.InvoiceId =  Invoice.InvoiceId
JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
GROUP BY Customer.Country
ORDER BY total_revenue DESC
LIMIT 5;
