-- migrate:up
CREATE TYPE total_tools_pos.ticket_status AS ENUM ('open', 'canceled', 'paid');

CREATE TABLE "total_tools_pos"."ticket"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT public.nanoid(12),
    "created_by" VARCHAR(12)
        CONSTRAINT fk_user
        REFERENCES "total_tools_core"."user"("id"),
    "status" total_tools_pos.ticket_status NOT NULL DEFAULT 'open',
    "created_at" TIMESTAMP DEFAULT NOW(),
    "total" DECIMAL(12, 2) NOT NULL DEFAULT 0
);

GRANT ALL ON "total_tools_pos"."ticket" TO total_tools_pos;

-- migrate:down
DROP TABLE "total_tools_pos"."ticket";
DROP TYPE total_tools_pos.ticket_status;
