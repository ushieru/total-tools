-- migrate:up
CREATE FUNCTION "total_tools_core"."link_user_module"(
    username TEXT,
    module TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    _account_id TEXT;
BEGIN
    EXECUTE 'GRANT ' || $2 || ' TO ' || $1;
    SELECT id INTO _account_id FROM "total_tools_core"."account" cca WHERE cca.username = $1;
    INSERT INTO "total_tools_core"."account_module"(account_id, module_id) VALUES(_account_id, $2);
    RETURN true;
END;
$$ LANGUAGE PLPGSQL SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "total_tools_core"."link_user_module"(TEXT, TEXT) TO total_tools_admin;

-- migrate:down
DROP FUNCTION "total_tools_core"."link_user_module"(TEXT, TEXT);
