-- Verify ofact:1.init on pg

BEGIN;

SELECT 
    id,
    email,
    password,
    name,
    address,
    zip_code,
    city
FROM visitor;

SELECT 
    id,
    label,
    price,
    price_with_taxes
FROM product;

SELECT 
    id,
    visitor_id,
    issued_at,
    paid_at
FROM invoice;

SELECT
    id,
    quantity,
    invoice_id,
    product_id
FROM invoice_line;

ROLLBACK;
