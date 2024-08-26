-- migrate:up
CREATE TABLE "total_tools_core"."user"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT nanoid(12),
    "name" VARCHAR(255) NOT NULL,
    "family_name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL UNIQUE,
    "cellphone" VARCHAR(255) NOT NULL,
    "account_id" VARCHAR(12) NOT NULL CONSTRAINT fk_account
        REFERENCES "total_tools_core"."account"("id") ON DELETE CASCADE,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL DEFAULT NOW()
);

GRANT SELECT ON "total_tools_core"."user" TO total_tools_admin;

COMMENT ON TABLE "total_tools_core"."user" IS
    E'@omit create,update,delete';

-- migrate:down
DROP TABLE "total_tools_core"."user";
