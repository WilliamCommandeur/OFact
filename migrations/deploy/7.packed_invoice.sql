-- Deploy ofact:7.packed_invoice to pg


BEGIN;

-- Création du type packed
CREATE TYPE packed AS (
    name TEXT,
    city TEXT,
    invoice_ref INT,
    issued_at TIMESTAMPTZ,
    paid_at TIMESTAMPTZ,
    lines JSON,
    total FLOAT
);

CREATE FUNCTION packed_invoice(id INT)
RETURNS packed AS
$$
    
SELECT 
        idt.name,
        idt.city,
        idt.invoice_ref,
        idt.issued_at,
        idt.paid_at,
        json_agg((json_build_object(
            'quantity',(SELECT idt.quantity),
            'label',(SELECT idt.label),
            'price',(SELECT idt.price),
            'tva_ratio',(SELECT idt.tva_ratio),
            'total_line',(SELECT idt.total_line)
        ))) as lines,
        (SELECT(SUM(total_line)) FROM invoice_details idt WHERE idt.invoice_ref=id) as total
        FROM invoice_details idt WHERE idt.invoice_ref=id
		GROUP BY idt.name, idt.city, idt.invoice_ref, idt.issued_at, idt.paid_at;
$$ LANGUAGE sql;
COMMIT;