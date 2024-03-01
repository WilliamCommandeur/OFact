export PGUSER=admin_ofact
export PGPASSWORD=ofact
export PGDATABASE=ofact

sqitch deploy 1.init
sqitch deploy 2.3fn
sqitch deploy 3.crud_functions
sqitch deploy 4.invoice_details
sqitch deploy 5.invoice_recap
sqitch deploy 6.sales
sqitch deploy 7.packed_invoice
sqitch deploy 8.add_invoice