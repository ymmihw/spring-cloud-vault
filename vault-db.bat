@echo off
call %%~dp0%%/vault-env.bat

set VAULT_TOKEN=s.ZtXyfuXZfTFo4KeCn8x5rVYA
vault secrets enable database
vault write database/config/mysql-fakebank ^
  plugin_name=mysql-legacy-database-plugin ^
  connection_url="{{username}}:{{password}}@tcp(172.16.10.177:3306)/fakebank" ^
  allowed_roles="*" ^
  username="fakebank-admin" ^
  password="Sup&rSecre7!" 

vault write database/roles/fakebank-accounts-ro ^
    db_name=mysql-fakebank ^
    creation_statements="CREATE USER '{{name}}'@'%%' IDENTIFIED BY '{{password}}';GRANT SELECT ON fakebank.* TO '{{name}}'@'%%';" ^
    default_ttl="1h" ^
    max_ttl="24h"  

vault write database/roles/fakebank-accounts-rw ^
    db_name=mysql-fakebank ^
    creation_statements="CREATE USER '{{name}}'@'%%' IDENTIFIED BY '{{password}}';GRANT SELECT,INSERT,UPDATE ON fakebank.* TO '{{name}}'@'%%';" ^
    default_ttl="5m" ^
    max_ttl="30m"  

vault read database/creds/fakebank-accounts-rw