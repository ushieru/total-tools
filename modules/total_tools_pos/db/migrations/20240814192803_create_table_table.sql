-- migrate:up
CREATE TABLE "total_tools_pos"."table"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT public.nanoid(12),
    "name" VARCHAR(255) NOT NULL,
    "pos_x" DECIMAL NOT NULL DEFAULT 0,
    "pos_y" DECIMAL NOT NULL DEFAULT 0,
    "user_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_user_id
        REFERENCES "total_tools_core"."user"("id"),
    "ticket_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_ticket_id
        REFERENCES "total_tools_pos"."ticket"("id")
);

GRANT ALL ON "total_tools_pos"."table" TO total_tools_pos;

-- migrate:down
DROP TABLE "total_tools_pos"."table";
