-- Deploy ofact:8.add_invoice to pg

BEGIN;

CREATE FUNCTION add_invoice(json) RETURNS INT AS
$$
    INSERT INTO invoice(visitor_id, issued_at)
    VALUES (
        ($1 ->> 'visitor_id')::INT,
        ($1 ->> 'issued_at')::TIMESTAMPTZ
    );

    INSERT INTO invoice_line(quantity, invoice_id, product_id)
    VALUES (
       ((json_array_elements(($1 ->> 'products')::json))->> 'quantity')::INT,
       (SELECT id FROM invoice ORDER BY id DESC LIMIT 1)::INT,
       ((json_array_elements(($1 ->> 'products')::json))->> 'id')::INT
    );
	
	SELECT id FROM invoice ORDER BY id DESC LIMIT 1;
$$ LANGUAGE sql;

COMMIT;

-- Deploy ofact:8.add_invoice to pg

