#!/usr/bin/env bash

psql -U aqueduct_admin -W aqueduct -c "
BEGIN TRANSACTION;
DROP TABLE public._aqueduct_version_pgsql;
DROP TABLE public._authcode;
DROP TABLE public._social;
DROP TABLE public._token;
DROP TABLE public._client;
DROP TABLE public._user;
GRANT ALL ON ALL TABLES IN SCHEMA public TO aqueduct_app;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO aqueduct_app;
COMMIT TRANSACTION;
";
cd ..;
aqueduct db upgrade


