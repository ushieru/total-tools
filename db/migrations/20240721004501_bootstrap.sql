-- migrate:up
CREATE ROLE authenticator NOINHERIT NOCREATEDB NOCREATEROLE NOSUPERUSER LOGIN PASSWORD 'total_tools-authenticator';
CREATE ROLE anonymous NOLOGIN NOINHERIT NOCREATEDB NOCREATEROLE NOSUPERUSER;
CREATE ROLE total_tools_admin NOLOGIN;
CREATE ROLE total_tools_user NOLOGIN;
GRANT anonymous TO authenticator;
CREATE SCHEMA total_tools_core;
GRANT USAGE ON SCHEMA total_tools_core TO total_tools_admin;

COMMENT ON TABLE "public"."total_tools_core_schema_migrations" IS
    E'@omit';

-- migrate:down
REVOKE USAGE ON SCHEMA total_tools_core FROM total_tools_admin;
DROP SCHEMA total_tools_core CASCADE;
REVOKE anonymous FROM authenticator;
DROP ROLE total_tools_user;
DROP ROLE total_tools_admin;
DROP ROLE anonymous;
DROP ROLE authenticator;
