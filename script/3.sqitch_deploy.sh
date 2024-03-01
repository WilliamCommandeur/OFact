export PGUSER=admin_ofact
export PGPASSWORD=ofact
export PGDATABASE=ofact

sqitch deploy 1.init
sqitch deploy 2.3fn
sqitch deploy 3.crud_functions