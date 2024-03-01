-- Revert ofact:6.sales from pg

BEGIN;

DROP FUNCTION sales_by_date(starting_date DATE, ending_date DATE);
DROP TYPE sales;

COMMIT;
