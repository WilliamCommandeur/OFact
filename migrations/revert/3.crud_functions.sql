-- Revert ofact:3.crud_functions from pg

BEGIN;

DROP FUNCTION 
    insert_visitor(json),
    insert_product(json),
    insert_invoice(json),
    insert_invoice_line(json),
    update_visitor(json),
    update_product(json),
    update_invoice(json),
    update_invoice_line(json);    

COMMIT;
