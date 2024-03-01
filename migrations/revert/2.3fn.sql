-- Revert ofact:2.3fn from pg

BEGIN;

ALTER TABLE product
    ADD COLUMN price_with_taxes pdp;

UPDATE product SET
    price_with_taxes = price + (price * tva_ratio);

ALTER TABLE product 
    DROP COLUMN tva_ratio;

COMMIT;
