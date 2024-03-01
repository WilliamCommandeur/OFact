-- Revert ofact:8.add_invoice from pg

BEGIN;

DROP FUNCTION add_invoice(json);

COMMIT;
