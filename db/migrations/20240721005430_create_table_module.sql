-- migrate:up
CREATE TABLE "total_tools_core"."module"(
    "key_name" VARCHAR(255) PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "icon" VARCHAR NOT NULL,
    "is_installed" BOOLEAN NOT NULL
);

GRANT SELECT ON "total_tools_core"."module" TO total_tools_admin;

COMMENT ON TABLE "total_tools_core"."module" IS
    E'@omit create,update,delete';

-- migrate:down
DROP TABLE "total_tools_core"."module";
