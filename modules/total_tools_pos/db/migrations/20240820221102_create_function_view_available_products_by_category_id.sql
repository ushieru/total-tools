-- migrate:up
CREATE FUNCTION "total_tools_pos"."available_products_by_category_id"(category_id TEXT)
RETURNS setof "total_tools_pos"."product" AS $$
    SELECT cpp.* FROM "total_tools_pos"."product" cpp
        INNER JOIN "total_tools_pos"."category_product" cpcp
        ON cpcp.product_id = cpp.id
        WHERE 
            cpcp.category_id = $1
            AND (now() AT TIME ZONE '+6' BETWEEN cpp.available_from AND cpp.available_until)
            AND (now()::time AT TIME ZONE '+6' BETWEEN (cpp.available_from_hour || '-6')::timetz AND (cpp.available_until_hour || '-6')::timetz)
            AND extract('dow' from now() AT TIME ZONE '+6') = ANY(cpp.available_days)
$$ LANGUAGE SQL IMMUTABLE;

-- migrate:down
DROP FUNCTION "total_tools_pos"."available_products_by_category_id"(TEXT);
