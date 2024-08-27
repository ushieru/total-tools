-- migrate:up
CREATE TABLE "total_tools_pos"."category_product"(
    "category_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_category
        REFERENCES "total_tools_pos"."category"("id"),
    "product_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_product
        REFERENCES "total_tools_pos"."product"("id"),
    PRIMARY KEY("category_id", "product_id")
);

GRANT ALL ON "total_tools_pos"."category_product" TO total_tools_pos;

-- migrate:down
DROP TABLE "total_tools_pos"."category_product";
