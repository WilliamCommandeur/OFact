-- Verify ofact:5.invoice_recap on pg

BEGIN;

SELECT * FROM invoice_recap;

ROLLBACK;
