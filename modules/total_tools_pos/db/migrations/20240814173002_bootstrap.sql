-- migrate:up
CREATE SCHEMA total_tools_pos;
CREATE ROLE total_tools_pos;
GRANT USAGE ON SCHEMA total_tools_pos TO total_tools_pos;
COMMENT ON TABLE "public"."total_tools_pos_schema_migrations" IS
  E'@omit';

-- migrate:down
COMMENT ON TABLE "public"."total_tools_pos_schema_migrations" IS NULL;
REVOKE USAGE ON SCHEMA total_tools_pos FROM total_tools_pos;
DROP ROLE total_tools_pos;
DROP SCHEMA total_tools_pos CASCADE;
