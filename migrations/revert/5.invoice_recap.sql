-- Revert ofact:5.invoice_recap from pg

BEGIN;

DROP VIEW invoice_recap;

COMMIT;
