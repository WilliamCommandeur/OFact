-- Deploy ofact:1.init to pg

BEGIN;

-- Création des domaines pour les email et les codes postaux
CREATE DOMAIN mail_address AS TEXT CHECK( VALUE ~ '^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
CREATE DOMAIN postal_code AS TEXT CHECK (VALUE ~ '^[0-9]{5}$');


-- Création de la table visitor
CREATE TABLE IF NOT EXISTS visitor 
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email mail_address NOT NULL UNIQUE,
    password text NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    zip_code postal_code NOT NULL,
    city text NOT NULL,
    created_at timestamptz NOT NULL DEFAULT(now()),
    updated_at timestamptz
);

-- Création du domaine pour les prix (float positif)
CREATE DOMAIN pdp AS double precision CHECK (VALUE > 0);

-- Création de la table product
CREATE TABLE IF NOT EXISTS product
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label text NOT NULL UNIQUE,
    price pdp NOT NULL,
    price_with_taxes pdp NOT NULL,
    created_at timestamptz NOT NULL DEFAULT(now()),
    updated_at timestamptz
);

-- Création de la table invoice
CREATE TABLE IF NOT EXISTS invoice
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    visitor_id int REFERENCES visitor(id),
    issued_at timestamptz NOT NULL DEFAULT(now()),
    paid_at timestamptz DEFAULT NULL
);

-- Créatin du domaine pour les quantités (int positif)
CREATE DOMAIN pint AS integer CHECK (VALUE > 0);


-- Création de la table invoice_line
CREATE TABLE IF NOT EXISTS invoice_line
(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantity pint NOT NULL,
    invoice_id int NOT NULL REFERENCES invoice(id),
    product_id int NOT NULL REFERENCES product(id),
    created_at timestamptz NOT NULL DEFAULT(now()),
    updated_at timestamptz
);


COMMIT;
