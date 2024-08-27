-- migrate:up
CREATE FUNCTION "total_tools_pos"."categories_not_in_product"(product_id TEXT)
RETURNS setof "total_tools_pos"."category" AS $$
    SELECT cpc.*
        FROM total_tools_pos.category cpc
        LEFT JOIN total_tools_pos.category_product cpcp
        ON cpc.id = cpcp.category_id AND cpcp.product_id = $1
        WHERE cpcp.category_id IS NULL;
$$ LANGUAGE SQL IMMUTABLE;

-- migrate:down
DROP FUNCTION "total_tools_pos"."categories_not_in_product"(TEXT);
