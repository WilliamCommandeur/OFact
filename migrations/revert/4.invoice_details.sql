-- Revert ofact:4.invoice_details from pg

BEGIN;

DROP VIEW invoice_details;
DROP FUNCTION calculate_total_price(quantity int, price float, tva_ratio float);

COMMIT;
