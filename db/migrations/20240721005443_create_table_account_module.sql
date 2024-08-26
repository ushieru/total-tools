-- migrate:up
CREATE TABLE "total_tools_core"."account_module"(
    "account_id" VARCHAR(255) NOT NULL CONSTRAINT fk_account
        REFERENCES "total_tools_core"."account"("id") ON DELETE CASCADE,
    "module_id" VARCHAR(255) NOT NULL CONSTRAINT fk_module
        REFERENCES "total_tools_core"."module"("key_name") ON DELETE CASCADE,
    PRIMARY KEY("account_id", "module_id")
);

GRANT SELECT ON "total_tools_core"."account_module" TO total_tools_admin;

COMMENT ON TABLE "total_tools_core"."account_module" IS
    E'@omit create,update,delete';

-- migrate:down
DROP TABLE "total_tools_core"."account_module";
