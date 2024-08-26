-- migrate:up
CREATE OR REPLACE FUNCTION "total_tools_core"."install_module"(key_name TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    PERFORM "graphile_worker"."add_job"('install_module', json_build_object('name', $1));
    RETURN true;
END;
$$ LANGUAGE PLPGSQL SECURITY DEFINER;

-- migrate:down
DROP FUNCTION "total_tools_core"."install_module"(TEXT);
