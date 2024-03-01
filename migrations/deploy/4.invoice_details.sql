-- Deploy ofact:4.invoice_details to pg

BEGIN;

-- Création d'une fonction pour récupérer le prix total de la commande
CREATE FUNCTION calculate_total_price(quantity INT, price FLOAT, tva_ratio FLOAT) RETURNS FLOAT AS
$$
    SELECT ((price + (price * tva_ratio)) * quantity)
$$ LANGUAGE sql;

-- Création de la vue invoice_details
CREATE VIEW invoice_details AS
    SELECT 
        v.name,
        v.city,
        i.id as invoice_ref,
        i.issued_at,
        i.paid_at,
        il.quantity,
        p.label,
        p.price,
        p.tva_ratio,
        (SELECT calculate_total_price(il.quantity, p.price, p.tva_ratio)) as total_line
    FROM visitor v
    JOIN invoice i ON i.visitor_id = v.id
    JOIN invoice_line il ON il.invoice_id = i.id
    JOIN product p ON p.id = il.product_id;


COMMIT;
