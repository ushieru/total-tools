-- migrate:up
CREATE FUNCTION "total_tools_core"."unlink_user_module"(
        username TEXT,
        module TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    _account_id TEXT;
BEGIN
    EXECUTE 'REVOKE ' || $2 || ' FROM ' || $1;
    SELECT id INTO _account_id FROM "total_tools_core"."account" cca WHERE cca.username = $1;
    DELETE FROM "total_tools_core"."account_module" ccam WHERE ccam.account_id = _account_id AND ccam.module_id = $2;
    RETURN true;
END;
$$ LANGUAGE PLPGSQL SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "total_tools_core"."unlink_user_module"(TEXT, TEXT) TO total_tools_admin;

-- migrate:down
DROP FUNCTION "total_tools_core"."unlink_user_module"(TEXT, TEXT);
