-- Deploy ofact:5.invoice_recap to pg

BEGIN;

CREATE VIEW invoice_recap AS
    SELECT
        i.id,
        i.issued_at,
        i.paid_at,
        (SELECT v.name FROM visitor v WHERE v.id = i.visitor_id),
		(SELECT (SUM(total_line)) FROM invoice_details idet WHERE idet.invoice_ref = i.id ) as total
        FROM invoice i;
        
COMMIT;
