-- migrate:up
CREATE TABLE "total_tools_core"."account"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT nanoid(12),
    "username" VARCHAR(255) NOT NULL UNIQUE,
    "password" VARCHAR(255) NOT NULL,
    "is_admin" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL DEFAULT NOW()
);

GRANT SELECT ON "total_tools_core"."account" TO total_tools_admin;

COMMENT ON COLUMN "total_tools_core"."account"."password" IS
  E'@omit';

COMMENT ON TABLE "total_tools_core"."account" IS
    E'@omit create,update,delete';

-- migrate:down
DROP TABLE "total_tools_core"."account";
