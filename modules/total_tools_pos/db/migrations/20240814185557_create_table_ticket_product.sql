-- migrate:up
CREATE TYPE total_tools_pos.ticket_product_status AS ENUM ('added', 'ordered', 'prepared');

CREATE TABLE "total_tools_pos"."ticket_product"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT public.nanoid(12),
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "price" DECIMAL(12, 2) NOT NULL DEFAULT 0,
    "status" total_tools_pos.ticket_product_status NOT NULL DEFAULT 'added',
    "product_id" VARCHAR(12) NOT NULL,
    "ticket_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_ticket_id
        REFERENCES "total_tools_pos"."ticket"("id")
);

GRANT ALL ON "total_tools_pos"."ticket_product" TO total_tools_pos;

-- migrate:down
DROP TABLE "total_tools_pos"."ticket_product";
DROP TYPE total_tools_pos.ticket_product_status;
