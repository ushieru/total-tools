-- migrate:up
CREATE VIEW "total_tools_pos"."available_categories"
AS SELECT * FROM "total_tools_pos"."category"
  WHERE (now() AT TIME ZONE '+6' BETWEEN available_from AND available_until)
    AND (now()::time AT TIME ZONE '+6' BETWEEN (available_from_hour || '-6')::timetz AND (available_until_hour || '-6')::timetz)
    AND extract('dow' from now() AT TIME ZONE '+6') = ANY(available_days);

GRANT SELECT ON "total_tools_pos"."available_categories" TO total_tools_pos;

-- migrate:down
DROP VIEW "total_tools_pos"."available_categories";
