-- migrate:up
CREATE SCHEMA total_tools_project;
CREATE ROLE total_tools_project;
GRANT USAGE ON SCHEMA total_tools_project TO total_tools_project;
COMMENT ON TABLE "public"."total_tools_project_schema_migrations" IS
  E'@omit';

-- migrate:down
COMMENT ON TABLE "public"."total_tools_project_schema_migrations" IS NULL;
REVOKE USAGE ON SCHEMA total_tools_project FROM total_tools_project;
DROP ROLE total_tools_project;
DROP SCHEMA total_tools_project CASCADE;
