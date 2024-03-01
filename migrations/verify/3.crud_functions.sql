-- Verify ofact:3.crud_functions on pg

BEGIN;

SELECT * FROM insert_visitor('{
    "email": "x@x.fr",
    "password": "12345",
    "name": "Nico",
    "address": "Au mileu de la grande anse",
    "zip_code": "17370",
    "city": "Grand-Village plage"
}');

SELECT * FROM insert_product('{
    "label": "test",
    "price": 25,
    "tva_ratio": 0.2
}');

SELECT * FROM insert_invoice('{
    "visitor_id": 1,
    "paid_at": "now()"
}');

SELECT * FROM insert_invoice_line('{
    "quantity": 5,
    "invoice_id": 1,
    "product_id": 1
}');

SELECt * FROM update_visitor('{
    "id":1,
    "email": "update@test.fr",
    "password": "12345789",
    "name": "Charle",
    "address": "Au mileu de la mise a jour",
    "zip_code": "95000",
    "city": "Grand-Village update"
}');

SELECT * FROM update_product('{
    "id":1,
    "label": "Test update",
    "price": 30,
    "tva_ratio": 0.055
}');

SELECT * FROM update_invoice('{
    "visitor_id": 2,
    "id": 5
}');

SELECT * FROM update_invoice_line('{
    "id":2,
    "quantity": 5,
    "invoice_id": 3,
    "product_id": 2
}');

ROLLBACK;
