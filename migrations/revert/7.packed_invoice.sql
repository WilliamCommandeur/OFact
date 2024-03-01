-- Revert ofact:7.packed_invoice from pg

BEGIN;

DROP FUNCTION packed_invoice(id INT);
DROP TYPE packed;

COMMIT;
