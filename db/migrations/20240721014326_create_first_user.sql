-- migrate:up
SELECT "total_tools_core"."create_user"('total','tools', 'Total', 'Tools', 'root@total_tools.com', '0000000000', true);

-- migrate:down
TRUNCATE TABLE "total_tools_core"."account" CASCADE;
DROP ROLE root;
