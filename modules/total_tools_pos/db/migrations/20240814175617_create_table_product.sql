-- migrate:up
CREATE TABLE "total_tools_pos"."product"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT public.nanoid(12),
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "price" DECIMAL(12, 2) NOT NULL DEFAULT 0,
    "available_from" DATE NOT NULL DEFAULT now(),
    "available_until" DATE NOT NULL DEFAULT now() + interval '1 year',
    "available_from_hour" TIME NOT NULL DEFAULT '00:00:00'::time,
    "available_until_hour" TIME NOT NULL DEFAULT '23:59:59'::time,
    "available_days" INTEGER[] NOT NULL DEFAULT '{0, 1, 2, 3, 4, 5, 6}'
);

GRANT ALL ON "total_tools_pos"."product" TO total_tools_pos;

-- migrate:down
DROP TABLE "total_tools_pos"."product";
