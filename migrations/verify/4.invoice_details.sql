-- Verify ofact:4.invoice_details on pg

BEGIN;

SELECT * FROM invoice_details WHERE name='Numérobis';

ROLLBACK;
