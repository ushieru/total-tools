-- migrate:up
CREATE FUNCTION "total_tools_project"."create_project"(name TEXT)
RETURNS "total_tools_project"."project" AS $$
DECLARE
    _created_project "total_tools_project"."project";
    _user "total_tools_core"."user";
BEGIN
    INSERT INTO "total_tools_project"."project"(name) VALUES($1) RETURNING * INTO _created_project;
    SELECT * INTO _user FROM "total_tools_core"."user" ccu WHERE ccu.account_id = current_setting('jwt.claims.sub');
    INSERT INTO "total_tools_project"."project_user"(project_id, user_id)
        VALUES(_created_project.id, _user.id);
    RETURN _created_project;
END
$$ LANGUAGE PLPGSQL SECURITY DEFINER;

-- migrate:down
DROP FUNCTION "total_tools_project"."create_project"(TEXT);
