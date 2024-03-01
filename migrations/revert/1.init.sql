-- Revert ofact:1.init from pg

BEGIN;

DROP TABLE invoice_line, invoice, product, visitor;
DROP DOMAIN pint, pdp, postal_code, mail_address;

COMMIT;
