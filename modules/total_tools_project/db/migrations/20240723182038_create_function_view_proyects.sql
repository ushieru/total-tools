-- migrate:up
CREATE FUNCTION "total_tools_project"."projects"()
RETURNS setof "total_tools_project"."project" AS $$
    SELECT p.*
    FROM "total_tools_project"."project" p
    JOIN "total_tools_project"."project_user" pu ON p.id = pu.project_id
    JOIN "total_tools_core"."user" u ON pu.user_id = u.id
    WHERE u.account_id = current_setting('jwt.claims.sub');
$$ LANGUAGE SQL IMMUTABLE;

-- migrate:down
DROP FUNCTION "total_tools_project"."projects"();
