-- migrate:up
CREATE FUNCTION "total_tools_core"."who_am_i"(account_id TEXT)
RETURNS "total_tools_core"."user" AS $$
    SELECT *
    FROM total_tools_core.user ttcu
    WHERE ttcu.account_id = $1;
$$ LANGUAGE SQL IMMUTABLE;

-- migrate:down
DROP FUNCTION "total_tools_core"."who_am_i"(TEXT);
