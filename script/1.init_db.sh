export PGUSER=spedata

dropdb ofact

dropuser admin_ofact

createuser admin_ofact -P

createdb ofact -O admin_ofact