-- migrate:up
CREATE FUNCTION "total_tools_core"."filter_accounts_not_in_module"(module TEXT)
RETURNS setof "total_tools_core"."account" AS $$
    SELECT cca.*
        FROM total_tools_core.account cca
        LEFT JOIN total_tools_core.account_module ccam
        ON cca.id = ccam.account_id AND ccam.module_id = $1
        WHERE ccam.account_id IS NULL;
$$ LANGUAGE SQL IMMUTABLE;

-- migrate:down
DROP FUNCTION "total_tools_core"."filter_accounts_not_in_module"(TEXT);
