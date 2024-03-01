-- Deploy ofact:2.3fn to pg

BEGIN;

ALTER TABLE product
    ADD COLUMN tva_ratio pdp;

UPDATE product SET 
    tva_ratio = ((price_with_taxes - price) / price);

ALTER TABLE product
    DROP COLUMN price_with_taxes;

COMMIT;
