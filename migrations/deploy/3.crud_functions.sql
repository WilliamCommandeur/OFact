-- Deploy ofact:3.crud_functions to pg

BEGIN;

-- Création de la fonction pour ajouter un visiteur
CREATE FUNCTION insert_visitor(json) RETURNS visitor AS
$$
    INSERT INTO visitor(email, password, name, address, zip_code, city)
    VALUES (
        ($1 ->> 'email')::mail_address,
        ($1 ->> 'password')::TEXT,
        ($1 ->> 'name')::TEXT,
        ($1 ->> 'address')::TEXT,
        ($1 ->> 'zip_code')::postal_code,
        ($1 ->> 'city')::TEXT
    ) RETURNING *;
$$ LANGUAGE sql STRICT;

-- Création de la fonction pour ajouter un produit
CREATE FUNCTION insert_product(json) RETURNS product AS
$$
    INSERT INTO product(label, price, tva_ratio)
    VALUES (
        ($1 ->> 'label')::TEXT,
        ($1 ->> 'price')::pdp,
        ($1 ->> 'tva_ratio')::pdp
    ) RETURNING *;
$$ LANGUAGE sql STRICT;

-- Création de la fonction pour ajouter une facture
CREATE FUNCTION insert_invoice(json) RETURNS invoice AS
$$
    INSERT INTO invoice(visitor_id, paid_at)
    VALUES (
        ($1 ->> 'visitor_id')::INT,
        ($1 ->> 'paid_at')::timestamptz
    ) RETURNING *;
$$ LANGUAGE sql STRICT;

-- Création de la fonction pour ajouter une ligne de facture
CREATE FUNCTION insert_invoice_line(json) RETURNS invoice_line AS
$$
    INSERT INTO invoice_line(quantity, invoice_id, product_id)
    VALUES (
        ($1 ->> 'quantity')::pint,
        ($1 ->> 'invoice_id')::INT,
        ($1 ->> 'product_id')::INT
    ) RETURNING *;
$$ LANGUAGE sql STRICT;

-- Création de la fonction pour mettre à jour un visiteur
CREATE FUNCTION update_visitor(json) RETURNS visitor AS
$$
    UPDATE visitor SET
        email = (($1 ->> 'email')::mail_address),
        password = (($1 ->> 'password')::TEXT),
        name = (($1 ->> 'name')::TEXT),
        address = (($1 ->> 'address')::TEXT),
        zip_code = (($1 ->> 'zip_code')::postal_code),
        city = (($1 ->> 'city')::TEXT),
        updated_at = (now()::timestamptz)
        WHERE id = (($1 ->> 'id')::INT)
        RETURNING *;
$$ LANGUAGE sql STRICT;

-- Création de la fonction pour mettre à jour un produit
CREATE FUNCTION update_product(json) RETURNS product AS
$$
    UPDATE product SET
        label = (($1 ->> 'label')::TEXT),
        price = (($1 ->> 'price')::pdp),
        tva_ratio = (($1 ->> 'tva_ratio')::pdp),
        updated_at = (now()::timestamptz)
        WHERE id = (($1 ->> 'id')::INT)
        RETURNING *;
$$ LANGUAGE sql STRICT;

-- Création de la fonction pour mettre à jour une facture
CREATE FUNCTION update_invoice(json) RETURNS invoice AS
$$
    UPDATE invoice SET
        visitor_id = (($1 ->> 'visitor_id')::INT),
        paid_at = (SELECT COALESCE((($1 ->> 'paid_at')::timestamptz),(now()::timestamptz))::timestamptz)
        WHERE id = (($1 ->> 'id')::INT)
        RETURNING *;
$$ LANGUAGE sql STRICT;

-- Création de la fonction pour mettre à jour une ligne de facture
CREATE FUNCTION update_invoice_line(json) RETURNS invoice_line AS
$$
    UPDATE invoice_line SET
        quantity = (($1 ->> 'quantity')::pint),
        invoice_id = (($1 ->> 'invoice_id')::INT),
        product_id = (($1 ->> 'product_id')::INT),
        updated_at = (now()::timestamptz)
        WHERE id = (($1 ->> 'id')::INT)
        RETURNING *;
$$ LANGUAGE sql STRICT;

COMMIT;


