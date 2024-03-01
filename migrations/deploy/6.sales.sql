-- Deploy ofact:6.sales to pg

BEGIN;

-- Création du type sales
CREATE TYPE sales AS (
    sales_date DATE,
    nb_invoices INT,
    total FLOAT
);

CREATE FUNCTION sales_by_date(starting_date DATE, ending_date DATE)
RETURNS SETOF sales AS
$$
    SELECT date::DATE,
		COALESCE(COUNT(i.id), 0) as nb_invoices,
		COALESCE(SUM(id.total_line), 0) as total
		FROM generate_series(starting_date, ending_date, '1 day'::interval) as date
		LEFT JOIN invoice i ON i.issued_at::DATE = date
		LEFT JOIN invoice_details id ON i.id = id.invoice_ref
		GROUP BY date    
$$ LANGUAGE sql;

COMMIT;
