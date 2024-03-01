-- Verify ofact:6.sales on pg

BEGIN;

SELECT * FROM sales_by_date('2024-02-26', '2024-03-02');

ROLLBACK;
